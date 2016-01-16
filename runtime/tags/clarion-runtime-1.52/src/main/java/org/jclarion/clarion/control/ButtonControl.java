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
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.beans.PropertyChangeListener;

import javax.swing.AbstractButton;
import javax.swing.Action;
import javax.swing.JButton;
import javax.swing.JRootPane;
import javax.swing.KeyStroke;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.FlatBorder;
import org.jclarion.clarion.swing.SwingAccept;

public class ButtonControl extends AbstractButtonControl implements KeyableControl, SimpleMnemonicAllowed
{
    private int acceptKey;
    
    public ButtonControl setKey(int key)
    {
        acceptKey=key;
        return this;
    }
    
    @Override
    public int getKey()
    {
        return acceptKey;
    }

    public ButtonControl setRepeat(int key)
    {
        throw new RuntimeException("Not yet implemented");
    }

    public ButtonControl setDelay(int key)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    public ButtonControl setDefault()
    {
        setProperty(Prop.DEFAULT,true);
        return this;
    }
    
    public ButtonControl setFlat()
    {
        setProperty(Prop.FLAT,true);
        return this;
    }
    
    public ButtonControl setIcon(String icon)
    {
        setProperty(Prop.ICON,icon);
        return this;
    }

    @Override
    public boolean isAcceptAllControl() {
        return false;
    }

    @Override
    public boolean validateInput() {
        return true;
    }
    
    @Override
    public int getCreateType() {
        return Create.BUTTON;
    }

    private JButton button;
    private boolean nimbusOver;
    private boolean nimbusFocus;
    
    private void toggleFlatNimbus()
    {
        JButton button = this.button;
        if (button!=null) {
            button.setContentAreaFilled(nimbusOver | nimbusFocus);
        }
    }
    
    @Override
    public void clearMetaData() 
    {
        nimbusOver=false;
        nimbusFocus=false;
        button=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"nimbusOver",nimbusOver);
        debugMetaData(sb,"nimbusFocus",nimbusFocus);
        debugMetaData(sb,"button",button);
    }
    
    
    private ButtonControl getUs()
    {
        return this;
    }

    public class MyAction implements Action
    {
        private String type;
        
        public MyAction(String type)
        {
            this.type=type;
        }
        
        @Override
        public void addPropertyChangeListener(PropertyChangeListener listener) {
        }

        @Override
        public Object getValue(String key) {
            return null;
        }

        @Override
        public boolean isEnabled() 
        {
            JButton b=  button;
            if (b==null) return false;
            AbstractWindowTarget awt = getWindowOwner();
            if (awt==null) return false;
            JRootPane r = awt.getRootPane();
            if (r==null) return false;
            if (r.getDefaultButton()!=null) return false;
            return true;
        }

        @Override
        public void putValue(String key, Object value) {
        }

        @Override
        public void removePropertyChangeListener(PropertyChangeListener listener) {
        }

        @Override
        public void setEnabled(boolean b) {
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            JButton b=  button;
            if (b!=null && isEnabled()) {
                button.getActionMap().get(type).actionPerformed(e);
            }
        }
        
    };
    
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
        button = new JButton();
        parent.add(button);
        Insets i = button.getMargin();
        i.left = 0;
        i.right = 0;
        button.setMargin(i);

        if (isProperty(Prop.FLAT)) {
            if (!CWin.getInstance().isNimbus()) {
                button.setContentAreaFilled(false);
                FlatBorder.init(button);
            } else {
                button.setContentAreaFilled(false);
                
                
                button.addMouseListener(new MouseListener() {

                    @Override
                    public void mouseClicked(MouseEvent e) {
                    }

                    @Override
                    public void mouseEntered(MouseEvent e) {
                        nimbusOver=true;
                        toggleFlatNimbus();
                    }

                    @Override
                    public void mouseExited(MouseEvent e) {
                        nimbusOver=false;
                        toggleFlatNimbus();
                    }

                    @Override
                    public void mousePressed(MouseEvent e) {
                    }

                    @Override
                    public void mouseReleased(MouseEvent e) {
                    } } );
                
                button.addFocusListener(new FocusListener() {
                    @Override
                    public void focusGained(FocusEvent e) {
                        nimbusFocus=true;
                        toggleFlatNimbus();
                    }
                    @Override
                    public void focusLost(FocusEvent e) {
                        nimbusFocus=false;
                        toggleFlatNimbus();
                    } } );
            }
        }

        if (isProperty(Prop.DEFAULT)) {
            button.getRootPane().setDefaultButton(button);
        }

        if (isProperty(Prop.ICON)) {
            button.setIcon(getIcon(getProperty(Prop.ICON).toString(), 0, 0));
        }

        configureButton();
        configureDefaults(button);
        initButton();

        

        
        button.getInputMap().put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER,0,false),"noDefaultPressed");
        button.getInputMap().put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER,0,true),"noDefaultReleased");
        
        
        button.getActionMap().put("noDefaultPressed",new MyAction("pressed"));
        button.getActionMap().put("noDefaultReleased",new MyAction("released"));
        
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                
                
                AbstractControl focus = (AbstractControl) getWindowOwner().getCurrentFocus();

                if (focus != null && focus != getUs()) {
                    SwingAccept accept = focus.getAccept(); 
                    if (accept != null) {
                        if (!accept.accept(false)) return;
                    }
                    getWindowOwner().setCurrentFocus(getUs());
                    post(Event.SELECTED);
                }
                if (!button.hasFocus()) {
                    getWindowOwner().setRefocus(button);
                    button.requestFocusInWindow();
                }
                
                post(Event.ACCEPTED);
            }
        });
    }

    @Override
    protected void notifyLocalChange(int indx, ClarionObject value) {
        super.notifyLocalChange(indx,value);
        if (indx==Prop.TEXT && button!=null) {
            configureButton();
        }
        if (indx==Prop.DEFAULT) {
            CWin.getInstance().setDefaultButton(getWindowOwner());
        }
    }

    @Override
    public AbstractButton getButton() {
        return button;
    }

    @Override
    public Component getComponent() {
        return button;
    }

    @Override
    protected void doToggleMode(boolean value, int mode) 
    {
        super.doToggleMode(value, mode);
        if (isProperty(Prop.DEFAULT)) {
            CWin.getInstance().setDefaultButton(getWindowOwner());
        }
    }

    
}
