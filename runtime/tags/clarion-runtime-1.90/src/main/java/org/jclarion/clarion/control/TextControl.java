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

import java.awt.AWTKeyStroke;
import java.awt.Component;
import java.awt.Container;
import java.awt.KeyboardFocusManager;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.HashSet;
import java.util.Set;

import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.JTextComponent;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.runtime.format.Formatter;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.swing.gui.GUIModel;

public class TextControl extends AbstractControl {

	
	
    public TextControl setReadOnly()
    {
        setProperty(Prop.READONLY,true);
        return this;
    }
    
    public TextControl setSingle()
    {
    	setProperty(Prop.SINGLE,true);
    	return this;
    }

    public TextControl setResize()
    {
        setProperty(Prop.RESIZE,true);
        return this;
    }

    public TextControl setFull()
    {
        setProperty(Prop.FULL,true);
        return this;
    }

    public TextControl setVScroll()
    {
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    public TextControl setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
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
        return Create.TEXT;
    }
    
    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(final ClarionMemoryModel model) 
        {
            if (forcedUpdate) return;
            AbstractWindowTarget awt = getWindowOwner();
            if (awt!=null) {
                awt.addAcceptTask(getUseID(),refresh);
            }
        }
    }

    private class TextSwingAccept extends SwingAccept
    {
        @Override
        public boolean accept(boolean focusLost) {
            JTextComponent f = field;
            if (f==null) return true;
            boolean a_result = true;
            String result = f.getText();
            if (isProperty(Prop.UPR)) {
                result = result.toUpperCase();
            }
            String deformat = result;
            boolean error = false;
            Formatter picture = getPicture();
            if (picture!=null) {
                deformat = picture.deformat(result);
                if (picture.isError()) {
                    a_result = false;
                    result = picture.format(getUseObject().toString());
                    result=ClarionString.rtrim(result);
                    f.setText(result);
                    if (!f.hasFocus()) {
                        f.requestFocusInWindow();
                        getWindowOwner().setRefocus(f);
                    }
                    f.selectAll();
                    post(Event.REJECTED);
                    error = true;
                } else {
                    result = picture.format(deformat);
                }
            }

            if (!error) {
                if (modified) {
                    f.setText(ClarionString.rtrim(result));
                    getUseObject().setValue(deformat);
                    sendAccept(deformat);
                }
            }
            modified=false;
            return a_result;
        }
    };
    
    
    private JTextComponent  field;
    private JScrollPane     scroll;
    private boolean         forcedUpdate;
    private boolean         modified;
    private ChangeListener  listener;
    private TextSwingAccept accept;
    private Runnable            refresh=new Refresh();

    
	@Override
	protected Object[] getRefreshParams() {
		return new Object[] { getUseObject() };
	}
    
    @Override
	protected void handleRefresh(Object... params) {
		getUseObject().setValue(params[0]);
        JTextComponent f=field;
        if (f!=null) {
            String result = getUseObject().toString();
            if (getPicture() != null) {
                result = getPicture().format(result);
            }
            result = ClarionString.rtrim(result);
            f.setText(result);
            f.getCaret().setDot(result.length());
            modified=false;
        }
	}

	@Override
    public void clearMetaData()
    {
        field=null;
        scroll=null;
        forcedUpdate=false;
        listener=null;
        modified=false;
        accept=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"field",field);
        debugMetaData(sb,"scroll",scroll);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
        debugMetaData(sb,"listener",listener);
        debugMetaData(sb,"modified",modified);
        debugMetaData(sb,"accept",accept);
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
    
    public static final int SUBSTITUTE = 200;
    
    public void substituteComponent(final JTextComponent newField)
    {
    	CWinImpl.run(this,SUBSTITUTE,newField);
    }
    
    private void sendAccept(Object value)
    {
        GUIModel.getServer().send(this,ACCEPT,value);
    }        
    
    @Override
    public Object command(int command,Object... params) 
    {
		if (command==UPDATE_FROM_SCREENTEXT) {
			ClarionObject o = getAWTProperty(Prop.SCREENTEXT);
			if (o!=null) {
				try {
					forcedUpdate=true;
					getUseObject().setValue(o);
				} finally {
					forcedUpdate=false;
				}
			}
			return o;
		}
		if (command==ACCEPT) {
			try {
				forcedUpdate=true;
				getUseObject().setValue(params[0]);
			} finally { forcedUpdate=false; }
			post(Event.ACCEPTED);
			return null;
		}
    	if (command==SUBSTITUTE) {
    		doSubstitute((JTextComponent)params[0]);
    		return null;    		
    	}
    	return super.command(command,params);
    }
    
	private void doSubstitute(final JTextComponent newField) {
		if (field != null) {
			scroll.getViewport().remove(field);
		}
		field = newField;
		if (field == null)
			return;
		scroll.getViewport().add(field);

		Set<AWTKeyStroke> forward = new HashSet<AWTKeyStroke>();
		forward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB, 0));
		field.setFocusTraversalKeys(
				KeyboardFocusManager.FORWARD_TRAVERSAL_KEYS, forward);

		Set<AWTKeyStroke> backward = new HashSet<AWTKeyStroke>();
		backward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB,
				KeyEvent.SHIFT_MASK));
		field.setFocusTraversalKeys(
				KeyboardFocusManager.BACKWARD_TRAVERSAL_KEYS, backward);

		if (isProperty(Prop.READONLY)) {
			field.setEditable(false);
		}
        SpellChecker.getInstance().init(field,this);

		accept = null;

		setFocus(field);
		setKey(field);

	}

	@Override
	public void opened()
	{
        ClarionObject use = getUseObject();
        if (use == null) {
            use = new ClarionString();
            use(use);
        }

        listener=new ChangeListener();
        use.addChangeListener(listener);		
	}
	
    @Override
    public void constructSwingComponent(Container parent) 
    {
    	final JTextArea jta = new JTextArea();
        field = jta;
        scroll = new JScrollPane(field);

        scroll.setVerticalScrollBarPolicy( isProperty(Prop.VSCROLL) ? 
        		JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED : JScrollPane.VERTICAL_SCROLLBAR_NEVER);

        scroll.setHorizontalScrollBarPolicy( isProperty(Prop.HSCROLL) ? 
        		JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED : JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        
        if (!isProperty(Prop.HSCROLL)) {
        	jta.setLineWrap(true);
        	jta.setWrapStyleWord(true);
        }
        
        Set<AWTKeyStroke> forward = new HashSet<AWTKeyStroke>();
        forward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB, 0));
        field.setFocusTraversalKeys(
                KeyboardFocusManager.FORWARD_TRAVERSAL_KEYS, forward);

        Set<AWTKeyStroke> backward = new HashSet<AWTKeyStroke>();
        backward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB,
                KeyEvent.SHIFT_MASK));
        field.setFocusTraversalKeys(
                KeyboardFocusManager.BACKWARD_TRAVERSAL_KEYS, backward);

        if (isProperty(Prop.READONLY)) {
            field.setEditable(false);
        }

        Formatter picture = getPicture();
        if (picture!=null) {
            picture.setStrictMode();
        }
        
        ClarionObject use = getUseObject();
        String result = use.toString();
        if (picture != null) result = picture.format(result);
        result = ClarionString.rtrim(result);
        field.setText(result);
        
        SpellChecker.getInstance().init(jta,this);
        
        field.getDocument().addDocumentListener(new DocumentListener() {
            @Override
            public void changedUpdate(DocumentEvent e) {
                modified=true;
            }

            @Override
            public void insertUpdate(DocumentEvent e) {
                modified=true;
            }

            @Override
            public void removeUpdate(DocumentEvent e) {
                modified=true;
            }
        });

        accept=new TextSwingAccept();

        field.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
            }
            @Override
            public void focusLost(FocusEvent e) {
            	if (getWindowOwner().getRefocus()!=null) return;
                if (accept!=null) {
                    accept.accept(true);
                }
            }
        });

        configureFont(field);
        configureColor(field);
        setPositionAndState();
        setFocus(field);
        setKey(field);

        if (isProperty(Prop.UPR)) {
            field.addKeyListener(new KeyListener() {

                @Override
                public void keyPressed(KeyEvent e) {
                }

                @Override
                public void keyReleased(KeyEvent e) {
                }

                @Override
                public void keyTyped(KeyEvent e) {
                    if (!e.isConsumed()) {
                        char c = e.getKeyChar();
                        c = Character.toUpperCase(c);
                        e.setKeyChar(c);
                    }
                }
            });
        }

        parent.add(scroll);
    }

    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        JTextComponent field= this.field;
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
    public Component getComponent() {
        return scroll;
    }

    @Override
    public Component getPopUpComponent() {
        return field;
    }
    
    public JTextComponent getField()
    {
        return field;
    }
    
    public JScrollPane getScrollPane()
    {
    	return scroll; 
    }
    
    

    @Override
	protected void handleAWTChange(int indx, ClarionObject value) {
    	if (indx==Prop.TOUCHED) {
    		modified=value.boolValue();
    		return;
    	}
        if (indx == Prop.SELSTART) {
            JTextComponent f = field;
            if (f!=null) {
                f.setSelectionStart(value.intValue() - 1);
            }
            return;
        }
        
        if (indx == Prop.SELEND) {
            JTextComponent f = field;
            if (f!=null) {
                f.setSelectionEnd(value.intValue());
            }
            return;
        }
		super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
        if (indx == Prop.SELSTART || indx== Prop.SELEND || indx==Prop.TOUCHED) return true;
		return super.isAWTChange(indx);
	}
	
	@Override
	protected boolean isCopy() {
		return true;
	}

	@Override
	protected boolean isPaste() {
		return true;
	}

    @Override
	protected void copy() {
    	JTextComponent f = field;
        if (f==null) return;
        boolean abridged=false;
        if (f.getSelectionStart()==0 && f.getSelectionEnd()==f.getText().length()) {
        	abridged=true;
        }
        if (f.getSelectionStart()==f.getSelectionEnd()) {
        	abridged=true;
        }
        if (abridged) {
        	ClarionObject o = getUseObject();
        	if (o!=null) {
                StringSelection ss = new StringSelection(o.toString().trim());
                Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss,ss);
                return;
        	}
        }
        f.copy();
	}

	@Override
	protected void paste() {
        JTextComponent f = field;
        if (f==null) return;
        f.paste();
	}
	
}
