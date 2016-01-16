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
import java.awt.Dimension;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JComponent;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.runtime.format.Formatter;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.swing.gui.GUIModel;

public class EntryControl extends AbstractControl {

    public EntryControl setUpper()
    {
        setProperty(Prop.UPR,true);
        return this;
    }

    public EntryControl setCapitalise()
    {
        setProperty(Prop.CAP,true);
        return this;
    }
    
    protected void initPicture(Formatter formatter)
    {
        formatter.setStrictMode();
    }
    

    public EntryControl setRequired()
    {
        setProperty(Prop.REQ,true);
        return this;
    }

    public EntryControl setPassword()
    {
        setProperty(Prop.PASSWORD,true);
        return this;
    }

    public EntryControl setReadOnly()
    {
        setProperty(Prop.READONLY,true);
        return this;
    }
    
    @Override
    public void update()
    {
        ClarionObject update = getUseObject();
        if (update==null) return;
        
    	Object v =  CWinImpl.runNow(this,UPDATE_FROM_SCREENTEXT);
    	if (v==null) return;
    	forcedUpdate=true;
        try {
        	update.setValue(v);
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

    @Override
    public int getCreateType() {
        return Create.ENTRY;
    }
   
    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(final ClarionMemoryModel model) 
        {
            if (!forcedUpdate) {
                AbstractWindowTarget awt = getWindowOwner();
                if (awt!=null) {
                    awt.addAcceptTask(getUseID(),refresh);
                }
            }
        }
    }
    
    private class EntrySwingAccept extends SwingAccept
    {
        public boolean accept(boolean aFocusLost) {
            
            final JTextField f=field;
            if (f==null) return true;
            
            
            if (acceptResult!=null) {
                if (aFocusLost) {
                    getWindowOwner().setRefocus(f);
                }
                f.requestFocusInWindow();
                f.selectAll();
                return acceptResult; 
            }
            
            boolean a_result = true;
            String result = f.getText();
            if (isProperty(Prop.UPR)) {
                result = result.toUpperCase();
            }
            String deformat = getPicture().deformat(result);
            if (!getPicture().isError())
                result = getPicture().format(deformat);
            if (getPicture().isError()) {
                a_result = false;
                result = getPicture().format(getUseObject().toString()).trim();
                f.setText(result.trim());
                if (f.isEnabled() && f.isVisible()) {
                    if (aFocusLost) {
                        getWindowOwner().setRefocus(f);
                    }
                    f.requestFocusInWindow();
                    f.selectAll();

                    if (!aFocusLost) {
                        post(Event.REJECTED);
                    } else {
                        acceptResult=false;
                    }
                } else {
                    post(Event.REJECTED);
                }
            } else {
                if (modified) {
                    f.setText(result.trim());
                    sendAccept(deformat);
                }
                if (!f.hasFocus()) {
                    f.getCaret().setDot(f.getText().length());
                }
            }
            modified=false;
            return a_result;
        }
    }
    
    private JTextField          field;
    private ChangeListener      listener;
    private boolean             forcedUpdate;
    private boolean             modified;
    private EntrySwingAccept    accept;
    private Insets              insets;
    private Boolean             acceptResult;
    private boolean             gainViaMousePress;
    private Runnable            refresh=new Refresh();
    @Override
    public void clearMetaData()
    {
        this.listener=null;
        this.field=null;
        this.forcedUpdate=false;
        this.modified=false;
        this.accept=null;
        this.acceptResult=null;
        this.gainViaMousePress=false;
        super.clearMetaData();
    }

    private void sendAccept(Object value)
    {
        GUIModel.getServer().send(this,ACCEPT,value);
    }

    
    
	@Override
	public Object command(int command, Object... params) {
		if (command==UPDATE_FROM_SCREENTEXT) {
            JTextField f = field;
            if (f==null) return null;
            String value = f.getText();
            if (getPicture()!=null) {
            	value=getPicture().deformat(value);
            	if (getPicture().isError()) value=null;
            }
			if (value!=null) {
				try {
					forcedUpdate=true;
					getUseObject().setValue(value);
				} finally {
					forcedUpdate=false;
				}
			}
			return value;
		}
		if (command==ACCEPT) {
			try {
				forcedUpdate=true;
				getUseObject().setValue(params[0]);
			} finally { forcedUpdate=false; }
			post(Event.ACCEPTED);
			return null;
		}
		// TODO Auto-generated method stub
		return super.command(command, params);
	}
	
	

	@Override
	protected Object[] getRefreshParams() {
		return new Object[] { getUseObject() };
	}

	@Override
	protected void handleRefresh(Object... params) {
		getUseObject().setValue(params[0]);
        JTextField f=field;
        if (f!=null) {
            String result = getPicture().format(getUseObject().toString()).trim();
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
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"listener",listener);
        debugMetaData(sb,"field",field);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
        debugMetaData(sb,"modified",modified);
        debugMetaData(sb,"accept",accept);
        debugMetaData(sb,"acceptResult",acceptResult);
        debugMetaData(sb,"refresh",refresh);
        debugMetaData(sb,"gainViaMousePress",gainViaMousePress);
    }

    @Override
    public SwingAccept getAccept()
    {
        return accept; 
    }

    
    
    @Override
	public void opened() {
		super.opened();
        ClarionObject use = getUseObject();
        if (use == null) {
            use = new ClarionString();
            use(use);
        }

        listener=new ChangeListener();
        use.addChangeListener(listener);
	}

	@Override
    public void constructSwingComponent(Container parent) {

        
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

        parent.add(field);    

        if (isProperty(Prop.READONLY)) {
            field.setEditable(false);
        }


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

        final EntryControl us = this;
        
        field.addMouseListener(new MouseListener() {

            @Override
            public void mouseClicked(MouseEvent e) {
            }

            @Override
            public void mouseEntered(MouseEvent e) {
            }

            @Override
            public void mouseExited(MouseEvent e) {
            }

            @Override
            public void mousePressed(MouseEvent e) {
                if (getWindowOwner()==null) return;
                if (getWindowOwner().getCurrentFocus()!=us) {
                    gainViaMousePress=true;
                }
            }

            @Override
            public void mouseReleased(MouseEvent e) {
            } });
        
        configureDefaults(field);
        
        field.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
                JTextField f = field;
                if (f!=null) {
                    if (gainViaMousePress) {
                        gainViaMousePress=false;
                    } else {
                        f.selectAll();
                    }
                }
                if (acceptResult!=null) {
                    acceptResult=null;
                    post(Event.REJECTED);
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

        final boolean upr = isProperty(Prop.UPR);
        final boolean cap = isProperty(Prop.CAP);
            
        field.addKeyListener(new KeyListener() {

            @Override
            public void keyPressed(KeyEvent e) {
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }

            @Override
            public void keyTyped(KeyEvent e) {
                
                if (!e.isConsumed() && e.getKeyChar()!=0 && getPicture().getMaxLen()<=field.getText().length() && field.getSelectionStart()==field.getSelectionEnd()) {
                    e.consume();
                    return;
                }
                
                if (upr && !e.isConsumed()) {
                    char c = e.getKeyChar();
                    c = Character.toUpperCase(c);
                    e.setKeyChar(c);
                }
                
                if (cap && !e.isConsumed() && !e.isShiftDown()) {
                    char c = e.getKeyChar();
                    
                    // force lower
                    char lastchar=' ';
                    int pos = field.getSelectionStart();
                    if (pos>0) {
                        lastchar=field.getText().charAt(pos-1);
                    }
                    
                    
                    if (Character.isWhitespace(lastchar)) {
                        c = Character.toUpperCase(c);
                        e.setKeyChar(c);
                    } else {
                        c = Character.toLowerCase(c);
                        e.setKeyChar(c);
                    }
                }
            }
        });
    }
    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        JTextField f = field;
        if (f!=null) {
            switch (index) {
                case Prop.SELSTART:
                    return new ClarionNumber(f.getSelectionStart() + 1);
                case Prop.SELEND:
                    if (f.getSelectionStart() == f.getSelectionEnd()) {
                        return new ClarionNumber(0);
                    }
                    return new ClarionNumber(f.getSelectionEnd());
                case Prop.SCREENTEXT:
                    return new ClarionString(f.getText());
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
    	if (indx==Prop.TEXT) {
            JTextField f = field;
            if (f==null) return;
            String result = getPicture().format(getUseObject().toString()).trim();
            f.setColumns(getPicture().getMaxLen());
            f.setText(result);    		
    	}
		super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
		if (indx==Prop.TEXT || indx==Prop.TOUCHED) return true;
		return super.isAWTChange(indx);
	}

    @Override
    public Component getComponent() {
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

    @Override
    public Dimension getPreferredSize() 
    {
        Dimension r = getComponent().getPreferredSize();
        
        if (getUseObject()!=null) {
            // try another size
            if (getPicture()!=null) {
                Graphics g = getComponent().getGraphics();
                if (g!=null) {
                    String rep = getPicture().getPictureRepresentation();
                    FontMetrics fm = getComponent().getGraphics().getFontMetrics(getComponent().getFont());
                    r.width = fm.stringWidth(rep)+4;
                    if (r.width>205) r.width=205;
                }
            }
        }
        
        return r; 
    }

    
}
