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
package org.jclarion.clarion.control;

import java.awt.Component;
import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.text.JTextComponent;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionQueueEvent;
import org.jclarion.clarion.ClarionQueueListener;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propstyle;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionCellRenderer;
import org.jclarion.clarion.swing.QueueComboModel;
import org.jclarion.clarion.swing.SimpleComboQueue;
import org.jclarion.clarion.swing.gui.CommandList;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.NetworkQueue;
import org.jclarion.clarion.swing.gui.RemoteWidget;

public abstract class AbstractListControl extends AbstractControl
{
    protected ClarionQueue from;
    
    public final ClarionQueue getFrom()
    {
        if (from==null) from=new SimpleComboQueue();
        return from;
    }

    
    protected NetworkQueue queue;
    
    @Override
	public void disposeWidget() {
		super.disposeWidget();
	}
    
    public static final int MD_QUEUE=0x2100;
    public static final int MD_QUEUE_CHANGE=0x2101;
    public static final int MD_PROPSTYLE=0x2102;

	protected void addInitialMetaData(Map<Integer, Object> changes) 
	{
		if (listStyleProperties!=null) {
			changes.put(MD_PROPSTYLE,listStyleProperties);
		}
	}    
    
	@Override
	public Map<Integer, Object> getChangedMetaData() {
		// we only want to construct the queue if we are server side. 
		if (queue==null && isOpened()) {
			queue=new NetworkQueue(getFrom(),this);
		}
		
		if ( (queue!=null && queue.isModified()) || (changes!=null) ) { 
			Map<Integer, Object> result = super.getChangedMetaData();
			if (result==null) result=new HashMap<Integer,Object>();
			if (queue!=null && queue.isModified()) {
				result.put(MD_QUEUE,queue.getMetaData());
			}
			if (changes!=null) {
				result.put(MD_QUEUE_CHANGE,changes);
				changes=null;
			}
			return result;
		} else {
			return super.getChangedMetaData();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	protected boolean setMetaData(int index, Object value) {
		if (index==MD_PROPSTYLE) {
			Map<Integer,Map<Integer,ClarionObject>> styleData = (Map<Integer,Map<Integer,ClarionObject>>)value;
			for (Map.Entry<Integer,Map<Integer,ClarionObject>> me : styleData.entrySet() ) {
				ListStyleProperty lp = getListStyle(me.getKey());
				for (Map.Entry<Integer,ClarionObject> p : me.getValue().entrySet() ) {
					lp.setProperty(p.getKey(),p.getValue());
				}
			}
			return true;
		}
		if (index==MD_QUEUE) {
			from=NetworkQueue.reconstruct(from,(Object[])value);
			return true;
		}
		if (index==MD_QUEUE_CHANGE) {
			for (Object item : (Object[])value ) {
				Object bits[] = (Object[])item;
				getFrom().doSetValueAt((Integer)bits[0],(Integer)bits[1],(ClarionObject)bits[2]);
			}
			return true;
		}
		return super.setMetaData(index, value);
	}	
	
    private List<Object[]> changes=null;
    
	public void noteQueueChange(int queueRow, int queueColumn,ClarionObject value) 
	{
		getFrom().doSetValueAt(queueRow,queueColumn,value);
		if (changes==null) {
			changes=new ArrayList<Object[]>();
		}
		changes.add(new Object[] { queueRow,queueColumn,value } );
	}

		
	public void pushQueueChanges() {
	}
	
	
	@Override
	public Component getComponent() {
		return null;
	}

	@Override
	public int getCreateType() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isAcceptAllControl() {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public boolean validateInput() {
		// TODO Auto-generated method stub
		return false;
	}



	private Map<Integer,ListStyleProperty> listStyleProperties;
    private Map<Integer,String>            icons;
    
    
    public ListStyleProperty getListStyle(int index)
    {
        if (listStyleProperties==null) {
            listStyleProperties=new HashMap<Integer, ListStyleProperty>();
        }
        
        ListStyleProperty result = listStyleProperties.get(index);
        if (result==null) {
            result=new ListStyleProperty(this);
            listStyleProperties.put(index,result);
        }
        return result;
    }
    
    public String getIcon(int indx)
    {
        if (icons==null) return null;
        return icons.get(indx);
    }
    
    private int convListStylePropertyCodeToPropertyCode(int code)
    {
        switch(code) {
            case Propstyle.FONTNAME:
                return Prop.FONTNAME;
            case Propstyle.FONTSIZE:
                return Prop.FONTSIZE;
            case Propstyle.FONTCOLOR:
                return Prop.FONTCOLOR;
            case Propstyle.FONTSTYLE:
                return Prop.FONTSTYLE;
            case Propstyle.TEXTCOLOR:
                return Prop.FONTCOLOR;
            case Propstyle.BACKCOLOR:
                return Prop.BACKGROUND;
            case Propstyle.TEXTSELECTED:
                return Prop.SELECTEDCOLOR;
            case Propstyle.BACKSELECTED:
                return Prop.SELECTEDFILLCOLOR;
            case Propstyle.PICTURE:
                return Prop.TEXT;
            case Propstyle.CHARSET:
                return Prop.CHARSET;
            default:
                throw new RuntimeException("Not Supported:"+code);
        }
    }
    
    public static final int OBJECT_CHANGED=100;
    public static final int SELSTART_CHANGED=101;
    public static final int LIST_ACCEPT=102;
    public static final int LIST_FORMAT_CHANGE=103;

    @Override
	public CommandList getCommandList() {
    	return super.getCommandList()
    		.add("OBJECT_CHANGED",OBJECT_CHANGED)
    		.add("SELSTART_CHANGED",SELSTART_CHANGED)
    		.add("LIST_ACCEPT",LIST_ACCEPT)
    		.add("LIST_FORMAT_CHANGE",LIST_FORMAT_CHANGE)
    		.add("MD_QUEUE",MD_QUEUE)
    		.add("MD_QUEUE_CHANGE",MD_QUEUE_CHANGE)
    		.add("MD_PROPSTYLE",MD_PROPSTYLE)
    	;
    }
    
    protected void notifyFormatChange(int event,String format)
    {
    	GUIModel.getServer().send(this,LIST_FORMAT_CHANGE,event,format);
    }
    
    protected void listFormatChange(int event,String format)
    {
    }
        
	@Override
	public Object command(int command, Object... params) {
    	switch(command) {
    		case LIST_FORMAT_CHANGE: {
    			int event = (Integer)params[0];
    			String format = (String)params[1];
    			listFormatChange(event,format);
    			break;
    		}
    		case ACCEPT: {
				if (params.length>0 && getUseObject()!=null) {
					try {
						forcedUpdate=true;
						getUseObject().setValue(params[0]);
					} finally { forcedUpdate=false; }
				}
    			post(Event.NEWSELECTION);
    			post(Event.ACCEPTED);
    			return null;
    		}
			case SELSTART_CHANGED: {
				JComboBox c = combo;
				if (c!=null) {
					int value = (Integer)params[0];
					c.setSelectedIndex(value - 1);
					c.repaint();
				}    		
				return null;
			}
    		case OBJECT_CHANGED: {
                JComboBox c = combo;
                if (c!=null) {
                    String s = ClarionString.rtrim(params[0].toString());
                    int indx = qcm.getIndex(s);
                    if (indx>0) {
                        if (c.getSelectedIndex()!=indx-1) {
                            c.setSelectedIndex(indx-1);
                        }
                        field.setText(s);
                    } else {
                        field.setText(s);
                    }
                }
    			return null;
    		}
    	}
		// TODO Auto-generated method stub
		return super.command(command, params);
	}



	private class ComboModel implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(final ClarionMemoryModel model) {
        	CWinImpl.run(getWidget(),OBJECT_CHANGED,model.toString());
        }
    }

	private RemoteWidget getWidget()
	{
		return this;
	}
	
    private QueueComboModel 		qcm;
    private JComboBox       		combo;
    private ComboModel      		model;
    private JTextComponent  		field;
    private boolean         		forcedUpdate;
    private ClarionQueueListener 	refreshTrigger;
    private Runnable            	refresh=new Refresh();
    
    @Override
    public void clearMetaData() 
    {
        this.qcm=null;
        this.combo=null;
        this.model=null;
        this.field=null;
        this.forcedUpdate=false;
        refreshTrigger=null;
        super.clearMetaData();
    }
    
    public boolean isCombo()
    {
    	return true;
    }
    
    protected void debugBaseMetaData(StringBuilder sb) 
    {
        debugMetaData(sb,"qcm",qcm);
        debugMetaData(sb,"combo",combo);
        debugMetaData(sb,"model",model);
        debugMetaData(sb,"field",field);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
    }
    
    
    
    @Override
    public ClarionObject getAWTProperty(int index) 
    {
    	if (combo!=null) {
    		if (index==Prop.SELSTART) {
    			JComboBox c = combo;
    			if (c!=null) {
    				return new ClarionNumber(combo.getSelectedIndex() + 1);
    			}
    		}
    		if (index==Prop.SCREENTEXT) {
    			JTextComponent f = field;
    			if (f!=null) {
    				return new ClarionString(f.getText());
    			}
    		}
    	}
        return super.getAWTProperty(index);
    }
    
    @Override
    public boolean isAWTProperty(int index) {
    	if (isCombo()) {
    		switch(index) {
            	case Prop.SELSTART:
            	case Prop.SCREENTEXT:
            		return true;
    		}
    	}
        return super.isAWTProperty(index);
    }
    
    
    @Override
    protected void doNotifyLocalChange(int indx,ClarionObject value) 
    {
        if (isCombo() && isOpened() && indx==Prop.SELSTART) {
            CWinImpl.run(this,SELSTART_CHANGED,value.intValue());
        }
        super.doNotifyLocalChange(indx,value);
    }
    
    
    
    @Override
    public void setProperty(ClarionObject key, ClarionObject index,
            ClarionObject value) {

        int ikey = key.intValue();

        if (ikey>=Propstyle.FIRST && ikey<=Propstyle.LAST) {
            ListStyleProperty po = getListStyle(index.intValue());  
            po.setProperty(convListStylePropertyCodeToPropertyCode(ikey),value);
            if (isOpened()) {
            	recordChange(MD_PROPSTYLE,listStyleProperties);
            	triggerGuiSync();
            }
            return;
        }
        
        switch(ikey) {
            case Prop.ICONLIST: {
                if (icons==null) icons=new HashMap<Integer, String>();
                icons.put(index.intValue(),value.toString());
                return;
            }
        }
        
        // TODO Auto-generated method stub
        super.setProperty(key, index, value);
    }

    @Override
    public void opened()
    {
        if (getUseObject()==null) {
            use(new ClarionString());
        }
        model=new ComboModel();
        getUseObject().addChangeListener(model);
        refreshTrigger=new ClarionQueueListener() {
			@Override
			public void queueModified(ClarionQueueEvent event) {
                AbstractWindowTarget awt = getWindowOwner();
                if (awt!=null) {
                    awt.addAcceptTask(getUseID(),refresh);
                }				
			}
		};
        getFrom().addListener(refreshTrigger);
    }
    
    public void createComboControl(Container parent,boolean edit) 
    {
        qcm = new QueueComboModel(this);
        combo = new JComboBox(qcm);
        combo.setEditable(edit);
        ClarionCellRenderer ccr = new ClarionCellRenderer(this);
        combo.setRenderer(ccr);
        qcm.init(combo);
        field=(JTextComponent)combo.getEditor().getEditorComponent();
        
        field.setText(ClarionString.rtrim(getUseObject().toString()));

        int indx = 0;
        ClarionObject co = getLocalProperty(Prop.SELSTART);
        if (co != null) indx = co.intValue();
        indx--;

        combo.addItemListener(new ItemListener() {

            @Override
            public void itemStateChanged(ItemEvent e) {

                if (e.getStateChange()==ItemEvent.DESELECTED) return;
                
                if (forcedUpdate) return;

                Object value=null;
                int i = combo.getSelectedIndex();
                if (i >= 0) {
                	value=qcm.getValue(i);
                }
                
                sendAccept(value);
                
            } } );

        combo.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) 
            {
                JTextComponent _field=field;
                if (_field==null) return;

                if (e.getActionCommand().equals("comboBoxChanged")) return;

                String text = _field.getText().trim();
                if (getUseObject().toString().trim().equals(text)) {
                    return;
                }
                sendAccept(text);
            }
        });
        
        if (indx>-1) {
            if (combo.getModel().getSize()>indx) {
                combo.setSelectedIndex(indx);
            }
        }

        configureFont(combo);
        configureColor(combo);
        setPositionAndState();
        setFocus(combo);
        setKey(combo);
        setKey((JComponent)combo.getEditor().getEditorComponent());
        parent.add(combo);
        
        field.addFocusListener(new FocusListener() {

            @Override
            public void focusGained(FocusEvent e) {
                JTextComponent jc = field;
                if (jc!=null) {
                    jc.selectAll();
                }
            }

            @Override
            public void focusLost(FocusEvent e) {
            } } );
    }

    
    private void sendAccept(Object value)
    {
    	if (value!=null) {
    		try {
    			forcedUpdate=true;
    			getUseObject().setValue(value);
                field.setText(value.toString().trim());
    		} finally {
    			forcedUpdate=false;
    		}
    		GUIModel.getServer().send(this,ACCEPT,value);
    	} else {
    		GUIModel.getServer().send(this,ACCEPT);    		
    	}
    }
    
    
    public JComboBox getCombo()
    {
        return combo;
    }
    
    public abstract boolean isTableFocus();

    public void contentsChanged() 
    {
        if (model!=null) {
            model.objectChanged(getUseObject());
        }
        
    }
}
