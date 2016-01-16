/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.swing;

import javax.swing.DefaultListSelectionModel;
import javax.swing.JTable;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableModel;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueueEvent;
import org.jclarion.clarion.ClarionQueueListener;
import org.jclarion.clarion.ClarionQueueReader;
import org.jclarion.clarion.TreeClarionQueue;
import org.jclarion.clarion.control.ListColumn;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.swing.gui.LocalServer;
import org.jclarion.clarion.swing.gui.NetworkModel;
import org.jclarion.clarion.swing.gui.RemoteNetwork;

import com.sun.org.apache.regexp.internal.recompile;

public class QueueTableModel implements TableModel,ClarionQueueListener,ListSelectionListener
{
    private ClarionQueueReader queue;
    private ListControl control;
    private List<TableModelListener> listeners=new ArrayList<TableModelListener>();
    private ListColumn columns[];
    private JTable table;
    private boolean hasMark;
    
    private int last_size=-1;
    
    public QueueTableModel(ListControl control)
    {
        this.control=control;
        this.queue=control.getFrom();
        hasMark = control.getRawProperty(Prop.MARK) != null;
        last_size=queue.records();
        
        columns=ListColumn.construct(control.getProperty(Prop.FORMAT).toString());
        if (columns.length==0) columns=ListColumn.constructDefault();
        
        for (int scan=0;scan<columns.length;scan++) {
            if (columns[scan].isTree()) {
                int offset = columns[scan].getFieldNumber()+1;
                if (columns[scan].isIcon() | columns[scan].isTransparantIcon()) offset++;
                queue = new TreeClarionQueue(queue,offset);
                break;
            }
        }

        queue.addListener(this);
    }
    
    public ClarionQueueReader getQueue()
    {
        return queue;
    }
    
    public void init(JTable table)
    {
        this.table=table;        
        table.getSelectionModel().addListSelectionListener(this);
        applyModel();
        
        /*
        control.addListener(new PropertyObjectListener() {

            @Override
            public Object getProperty(PropertyObject owner, int property) {
                return null;
            }

            @Override
            public void propertyChanged(PropertyObject owner, int property,
                    ClarionObject value) {
                
                if (property==Prop.FORMAT) {
                    columns=ListColumn.construct(control.getProperty(Prop.FORMAT).toString());
                    applyModel();
                    queueModified(new ClarionQueueEvent(queue,EventType.SORT,0));
                }
                
           } } );
       */
    }

    private boolean apply;
    
    public void applyModel()
    {
    	try {
    		apply=true;
			table.tableChanged(new TableModelEvent(this, -1, -1, -1,
					TableModelEvent.HEADER_ROW));
			TableColumnModel tcm = table.getColumnModel();
			for (int scan = 0; scan < tcm.getColumnCount(); scan++) {
				ListColumn lc = getColumns()[scan];
				TableColumn tc = tcm.getColumn(scan);
				int width = control.getWindowOwner().widthDialogToPixels(
						lc.getWidth());
				lc.syncSetSwingWidth(width);
				tc.setPreferredWidth(width);
				tc.setWidth(width);
				tc.setResizable(lc.isResizable());
				ClarionCellRenderer ccr = new ClarionCellRenderer(control);
				tc.setCellRenderer(ccr);
			}
    	} finally {
    		apply=false;
    	}
    }

    public boolean isApplying()
    {
    	return apply;
    }
    
    public ListControl getControl()
    {
        return control;
    }
    
    public void setValueAt(int row,int col,ClarionObject value)
    {
    	getControl().noteQueueChange(getQueue().getQueueRow(row),getQueue().getQueueColumn(col),value);
    }
    
    public void notifyChanges()
    {   
    	getControl().pushQueueChanges();
    }
    
    public ListColumn[] getColumns()
    {
        return columns;
    }

    public void  setColumns(ListColumn[] columns)
    {
        this.columns=columns;
    }

    @Override
    public void addTableModelListener(TableModelListener l) {
        listeners.add(l);
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        return String.class;
    }

    @Override
    public int getColumnCount() {
        return columns.length;
    }

    @Override
    public String getColumnName(int columnIndex) {
        return columns[columnIndex].getHeader();
    }

    private int assumedRows;
    
    @Override
    public int getRowCount() {
        assumedRows=getCapturedRowCount();
        return assumedRows;
    }
    
    public int getAssumedRowCount()
    {
    	return assumedRows;
    }
    

    private int lastPos=-1;
    private ClarionObject lastGet[];
    
    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        if (columnIndex>=columns.length) return null;
                
        if (lastPos!=rowIndex) {
            lastGet=queue.getRecord(rowIndex+1);
            lastPos=rowIndex;
        }
        
        if (lastGet==null) {
            lastPos=-1;
            return null;
        }

        return new ClarionQueueTableCell(queue,rowIndex+1,columns[columnIndex],lastGet);
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return false;
    }

    @Override
    public void removeTableModelListener(TableModelListener l) {
        listeners.remove(l);
    }

    @Override
    public void setValueAt(Object value, int rowIndex, int columnIndex) {
    }

    private boolean			postNS = false;
    private TableModelEvent tme    = null;
    private boolean         tmeAll = false;
    private boolean			ignore;
    
    public void setIgnoreModificationEvents(boolean ignore)
    {
    	this.ignore=ignore;
    }
    
    public boolean isIgnoreModificationEvent()
    {
    	return ignore;
    }
    
    @Override
    public void queueModified(ClarionQueueEvent event) 
    {
        if (event.event==ClarionQueueEvent.EventType.TOGGLE) {
        	if (NetworkModel.getClient().isLocal()) {
        		postNS=false;
        		tmeAll=true;
        		processModelChange();
        	}
            if (!NetworkModel.getServer().isLocal()) {            	
            	control.notifyTreeToggle(event.record,event.column);
            }
            return;
        } 
                
    	if (ignore) return;
        lastPos=-1;

        if (tme!=null) {
            tmeAll=true;
            postNS=true;
            tme=null;
        }
        
        if (!tmeAll) {
            if (event.event==ClarionQueueEvent.EventType.ADD) {
                tme=new TableModelEvent(this,event.record-1,event.record-1,
                        TableModelEvent.ALL_COLUMNS,TableModelEvent.INSERT);
            }

            if (event.event==ClarionQueueEvent.EventType.PUT) {
                tme=new TableModelEvent(this,event.record-1,event.record-1,
                        TableModelEvent.ALL_COLUMNS,TableModelEvent.UPDATE);
            }

            if (event.event==ClarionQueueEvent.EventType.DELETE) {
                tme=new TableModelEvent(this,event.record-1,event.record-1,
                        TableModelEvent.ALL_COLUMNS,TableModelEvent.DELETE);
            }

            if (event.event==ClarionQueueEvent.EventType.FREE) {
                postNS=true;
                tmeAll=true;
            }

            if (event.event==ClarionQueueEvent.EventType.SORT) {
                postNS=true;
                tmeAll=true;
            }
            
        }
    }
    
    private Integer currentRows;
	private boolean selectionEvent;
    
    private int getCapturedRowCount()
    {    	
    	if (currentRows==null) currentRows=queue.records();
    	return currentRows;
    }
    
    public void processModelChange()
    {
    	
    	currentRows=queue.records();
    	setSelectionEvent(false);
    	if (tmeAll) {
            if (assumedRows==currentRows) {            	
                tme=new TableModelEvent(this,0,queue.records()-1,TableModelEvent.ALL_COLUMNS,TableModelEvent.UPDATE);
            } else {
                tme=null;
            }
        }
        if (tme==null) tme=new TableModelEvent(this);
        
        int sel = table.getSelectedRow();
        for ( TableModelListener l : listeners) {
            l.tableChanged(tme);
        }
        
        if (!hasMark) {
        	if (sel>=queue.records()) sel=queue.records()-1;
        	if (sel>=0) {
        		table.getSelectionModel().setSelectionInterval(sel,sel);
        	}
        }
        tme=null;
        tmeAll=false;
        
        if (queue.records()!=last_size) {
            table.invalidate();
            table.repaint();            
        }        
        
    	if (postNS) {
    		//if (last_size>0) {
    		if (!setSelectionEvent(false)) {
    			control.post(Event.NEWSELECTION);
    		}
            postNS=false;
    	} 
    	
    	last_size=queue.records();
    }
    
    public JTable getTable()
    {
    	return table;
    }
    
    private boolean setSelectionEvent(boolean event)
    {
    	boolean result=false;
    	synchronized(this) {
    		result=this.selectionEvent;
    		this.selectionEvent=event;
    	}
    	return result;
    }

	@Override
	public void valueChanged(ListSelectionEvent e) 
	{
		if (!e.getValueIsAdjusting()) {
			setSelectionEvent(true);
		}
	}

}
