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
import java.awt.Insets;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;

import javax.swing.JComponent;
import javax.swing.JPasswordField;
import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.SpinnerNumberModel;
import javax.swing.event.ChangeEvent;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.swing.gui.GUIModel;

public class SpinControl extends AbstractControl 
{
    public SpinControl setRange(int lo,int hi)
    {
        setProperty(Prop.RANGELOW,lo);
        setProperty(Prop.RANGEHIGH,hi);
        return this;
    }

    public SpinControl setHScroll()
    {
        setProperty(Prop.HSCROLL,true);
        return this;
    }

    public SpinControl setVScroll()
    {
        setProperty(Prop.VSCROLL,true);
        return this;
    }
    
    public SpinControl setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
    }
    
    public SpinControl setStep(int value)
    {
        setProperty(Prop.STEP, value);
        return this;
    }
    
    @Override
    public int getCreateType() {
        return Create.SPIN;
    }
    
    @Override
    public void update()
    {
        ClarionObject update = getUseObject();
        if (update==null) return;
        
        ClarionObject text = getLocalProperty(Prop.SCREENTEXT);
        if (text==null) return;
        forcedUpdate=true;
        try {
            getUseObject().setValue(getPicture().deformat(text.toString()));
        } finally {
            forcedUpdate=false;
        }
    }

    @Override
    public boolean isAcceptAllControl() {
        return true;
    }

    @Override
    public boolean validateInput() {
        return true;
    }

    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(final ClarionMemoryModel cmodel) {
            if (!forcedUpdate) {
                getWindowOwner().addAcceptTask(getUseID(),refresh);
            }
        }
    }
    
    private class EntrySwingAccept extends SwingAccept
    {

        @Override
        public boolean accept(boolean focusLost) {
            JTextField f=field;
            if (f==null) return true;
            boolean a_result = true;
            String result = f.getText();
            String deformat = getPicture().deformat(result);
            
            boolean outOfRange=false;
            if (!getPicture().isError()) {
                
                result=getPicture().format(deformat);
                
                ClarionObject lo  = getRawProperty(Prop.RANGELOW,false);
                ClarionObject hi  = getRawProperty(Prop.RANGEHIGH,false);

                ClarionNumber cmp = null;
                if (lo!=null || hi!=null) cmp = new ClarionNumber(deformat); 
                
                if (lo!=null && lo.compareTo(cmp)>0) {
                    outOfRange=true;
                }
                if (hi!=null && hi.compareTo(cmp)<0) {
                    outOfRange=true;
                }
            }
            
            if (getPicture().isError() || outOfRange) {
                a_result = false;
                result = getPicture().format(getUseObject().toString()).trim();
                f.setText(result.trim());
                getWindowOwner().setRefocus(f);
                f.requestFocusInWindow();
                //clearRefocusOnEventQueue(getWindowOwner(), f);
                f.selectAll();
                post(Event.REJECTED);
            } else {
                if (modified) {
                    f.setText(result.trim());
                    sendAccept(deformat);
                    model.setValue(Integer.parseInt(deformat));
                }
                if (!f.hasFocus()) {
                    f.getCaret().setDot(f.getText().length());
                }
            }
            modified=false;
            return a_result;
        }
    }

    private JSpinner            spinner;
    private SpinnerNumberModel  model;
    private JTextField          field;
    private ChangeListener      listener;
    private boolean             forcedUpdate;
    private boolean             modified;
    private EntrySwingAccept    accept;
    private Insets              insets;
    private Runnable            refresh=new Refresh();

    
    private void sendAccept(Object value)
    {
        if (listener==null) getUseObject().setValue(value);
        GUIModel.getServer().send(this,ACCEPT,value);
    }
    
	@Override
	public Object command(int command, Object... params) {
		if (command==ACCEPT) {
			try {
				forcedUpdate=true;
				getUseObject().setValue(params[0]);
			} finally { forcedUpdate=false; }
			post(Event.ACCEPTED);
			return null;
		}
		return super.command(command, params);
	}
	
	
	
    @Override
	protected Object[] getRefreshParams() {
    	return new Object[] { getUseObject() };
	}

	@Override
	protected void handleRefresh(Object... params) {
		
		Object raw_result=null; 
		if (params!=null && params.length>0) {
			raw_result = params[0];
			if (raw_result instanceof ClarionObject) {
				raw_result=((ClarionObject)raw_result).intValue();
			}
			int i = (Integer)raw_result;
			if (listener==null) {
				getUseObject().setValue(i);
			}
			model.setValue(i);
		}
		
        JTextField f=field;
        if (f!=null) {
            String result = getPicture().format(raw_result!=null ? raw_result.toString() : getUseObject().toString()).trim();
            boolean allSelected = f.getSelectionStart()==0 && f.getSelectionEnd()==f.getText().length();
            f.setText(result);
            try {
                if (allSelected) {
                    f.selectAll();
                } else {
                    f.getCaret().setDot(result.length());
                }
            } catch (RuntimeException ex) {
            }
            modified=false;
        }
	}

	@Override
    public void clearMetaData()
    {
        this.listener=null;
        this.field=null;
        this.forcedUpdate=false;
        this.modified=false;
        this.accept=null;
        this.spinner=null;
        this.model=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"field",field);
        debugMetaData(sb,"listener",listener);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
        debugMetaData(sb,"modified",modified);
        debugMetaData(sb,"accept",accept);
        debugMetaData(sb,"spinner",spinner);
        debugMetaData(sb,"model",model);
        debugMetaData(sb,"refresh",refresh);
    }
    
    @Override
    public SwingAccept getAccept()
    {
        return accept; 
    }
    
    public boolean isAccept()
    {
    	return true;
    }

    @Override
    public void opened()
    {
        ClarionObject use = getUseObject();
        if (use == null) {
            use = new ClarionString();
            use(use);
        }
	if (listener==null) {
	        listener=new ChangeListener();
       		use.addChangeListener(listener);    	
	}
    }
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
    	if (spinner!=null) return;
        if( CWin.getInstance().isNimbus()) {
            insets=new Insets(3,0,3,0);
        } else {
            insets=null;
        }
        
        if (isProperty(Prop.PASSWORD)) {
            field = new JPasswordField();
        } else {
            field = new JTextField();
        }

        spinner = new JSpinner();
        configureModel();
        
        spinner.setEditor(field);
        
        addComponent(parent,spinner);    

        ClarionObject use = getUseObject();
        String result = getPicture().format(use.toString()).trim();
        field.setColumns(getPicture().getMaxLen());
        field.setText(result);

        if (isProperty(Prop.RIGHT) || isProperty(Prop.DECIMAL)) {
            field.setHorizontalAlignment(JTextField.RIGHT);
        }
        
        final boolean imm = isProperty(Prop.IMM);

        field.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void changedUpdate(DocumentEvent e) {
                modified=true;
                if (imm) {
                    post(Event.NEWSELECTION);
                }
            }

            @Override
            public void insertUpdate(DocumentEvent e) {
                modified=true;
                if (imm) {
                    post(Event.NEWSELECTION);
                }
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                modified=true;
                if (imm) {
                    post(Event.NEWSELECTION);
                }
            }
        });

        accept = new EntrySwingAccept();

        field.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
                JTextField f = field;
                if (f!=null) {
                    f.selectAll();
                }
            }

            @Override
            public void focusLost(FocusEvent e) {
            	if (getWindowOwner().getRefocus()!=null) return;
                EntrySwingAccept esa = accept;
                if (esa!=null) {
                    esa.accept(true);
                }
            }
        });

        configureFont(field);
        configureColor(field);
        setPositionAndState();
        setFocus(field);
        setKey(field);
        setFocus(spinner);
        setKey(spinner);
    }

    private void configureModel() {
        model = new SpinnerNumberModel();
        model.setValue(getUseObject().intValue());
        
        ClarionObject co;
        
        co = getRawProperty(Prop.STEP,false);
        model.setStepSize(co!=null ? co.intValue() : 1 );
        
        co = getRawProperty(Prop.RANGELOW,false);
        if (co!=null) {
            model.setMinimum(co.intValue());
        }

        co = getRawProperty(Prop.RANGEHIGH,false);
        if (co!=null) {
            model.setMaximum(co.intValue());
        }
        
        spinner.setModel(model);

        javax.swing.event.ChangeListener cl = new javax.swing.event.ChangeListener() {

            @Override
            public void stateChanged(ChangeEvent e) 
            {
                if (!getUseObject().equals(model.getValue())) {
                    handleRefresh(model.getValue());                    
                    sendAccept(model.getValue());
                }
            } };
            
            spinner.addChangeListener(cl);
    }

    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        JTextField field=this.field;
        if (field!=null) {
            switch (index) {
                case Prop.SELSTART:
                    return new ClarionNumber(field.getSelectionStart() + 1);
                case Prop.SELEND:
                    if (field.getSelectionStart() == field.getSelectionEnd()) {
                        return new ClarionNumber(0);
                    }
                    return new ClarionNumber(field.getSelectionEnd());
                case Prop.SCREENTEXT:
                    return new ClarionString(field.getText());
                case Prop.TOUCHED:
                    return new ClarionNumber(modified ? 1: 0);
            }
        }

        return super.getAWTProperty(index);
    }
    
    @Override
    public boolean isAWTProperty(int index) {
        switch(index) {
            case Prop.SCREENTEXT:
            case Prop.SELSTART:
            case Prop.SELEND:
            case Prop.TOUCHED:
                return true;
            default:
                return super.isAWTProperty(index);
        }
    }

    @Override
	protected void handleAWTChange(int indx, ClarionObject value) {
    	if (indx==Prop.TOUCHED) {
    		modified=value.boolValue();
    		return;
    	}
		super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
		if (indx==Prop.TOUCHED) return true;
		return super.isAWTChange(indx);
	}
    
    
    @Override
    protected void doNotifyLocalChange(int indx, ClarionObject value) {
        super.doNotifyLocalChange(indx, value);
        if (indx==Prop.TEXT) {
            AbstractWindowTarget awt = getWindowOwner();
            if (awt!=null) {
                awt.addAcceptTask(getUseID(),refresh);
            }
        }
    }

    @Override
    public Component getComponent() {
        return spinner;
    }
    
    public JTextField getField() {
    	return field;
    }
    
    public void setKey(JComponent comp) {
        CWin.getInstance().setKey(
                getWindowOwner(),comp,this instanceof SimpleMnemonicAllowed,
                false,this);
    }

    public Insets getControlAdjustInsets()
    {
        return insets;
    }
}
