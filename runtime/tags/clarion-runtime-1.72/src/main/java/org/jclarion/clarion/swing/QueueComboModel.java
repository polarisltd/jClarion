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

import java.util.ArrayList;
import java.util.List;

import javax.swing.ComboBoxModel;
import javax.swing.JComboBox;
import javax.swing.event.ListDataEvent;
import javax.swing.event.ListDataListener;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueueEvent;
import org.jclarion.clarion.ClarionQueueListener;
import org.jclarion.clarion.ClarionQueueReader;
import org.jclarion.clarion.TreeClarionQueue;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractListControl;
import org.jclarion.clarion.control.ListColumn;

public class QueueComboModel implements ComboBoxModel, ClarionQueueListener, Runnable
{

    
    private AbstractListControl control;
    private ClarionQueueReader queue;
    private ListColumn[] columns;
    
    public QueueComboModel(AbstractListControl control)
    {
        this.control=control;
        this.queue=control.getFrom();
        
        columns = ListColumn.construct(control.getProperty(Prop.FORMAT).toString());
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

    public void init(JComboBox combo) {
        //this.combo=combo;
        applyModel();
    }

    private void applyModel()
    {
    }
    
    public Object item;
    
    @Override
    public Object getSelectedItem() {
        return item;
    }

    @Override
    public void setSelectedItem(Object anItem) 
    {
        if (anItem instanceof String) {
            int indx = getIndex(anItem.toString());
            if (indx>0) {
                item=getElementAt(indx-1);
            }
        } else {
            this.item=anItem;
        }
    }

    public int getIndex(String anItem)
    {
        anItem=anItem.trim();
        for (int scan=1;scan<=queue.records();scan++) {
            if (anItem.equals(queue.getRecord(scan)[0].toString().trim())) {
                return scan;
            }
        }
        return 0;
    }
    
    private List<ListDataListener> listeners=new ArrayList<ListDataListener>();
    
    @Override
    public void addListDataListener(ListDataListener l) {
        listeners.add(l);
    }

    public ClarionObject getValue(int index)
    {
        ClarionObject co[] = queue.getRecord(index+1);
        return co[0];
    }
    
    @Override
    public Object getElementAt(int index) 
    {
        ClarionObject co[] = queue.getRecord(index+1);
        //return co[0].toString();
        return new ClarionQueueTableCell(queue,index+1,columns[0],co);
    }

    @Override
    public int getSize() {
        return queue.records();
    }

    @Override
    public void removeListDataListener(ListDataListener l) {
        listeners.remove(l);
    }

    @Override
    public void queueModified(ClarionQueueEvent event) {
        control.getWindowOwner().addAcceptTask(this);
    }

    @Override
    public void run() {
        for (ListDataListener l : listeners ) {
            l.contentsChanged(new ListDataEvent(this,ListDataEvent.CONTENTS_CHANGED,0,queue.records()));
        }
        control.contentsChanged();
    }

    
}
