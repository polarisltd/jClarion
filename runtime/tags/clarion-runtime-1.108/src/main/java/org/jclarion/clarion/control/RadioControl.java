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
import java.awt.Insets;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.KeyListener;

import javax.swing.AbstractButton;
import javax.swing.JRadioButton;
import javax.swing.JToggleButton;
import javax.swing.SwingConstants;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.SwingButtonIconReceiver;
import org.jclarion.clarion.swing.FlatBorder;
import org.jclarion.clarion.swing.gui.GUIModel;

public class RadioControl extends AbstractButtonControl implements SimpleMnemonicAllowed 
{
    public RadioControl setValue(String value) {
    	setProperty(Prop.VALUE,value);
        return this;
    }

    public RadioControl setValue(ClarionString value) {
    	setProperty(Prop.VALUE,value);
        return this;
    }

    private int acceptKey;
    
    @Override
    public int getKey()
    {
        return acceptKey;
    }
    
    
    public RadioControl setKey(int key) {
        acceptKey=key;
        return this;
    }
    
    public RadioControl setFlat()
    {
        setProperty(Prop.FLAT,true);
        return this;
    }
    
    public RadioControl setIcon(String icon)
    {
        setProperty(Prop.ICON,icon);
        return this;
    }

    public String getValue()
    {    	
        return getProperty(Prop.VALUE).toString();
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
        return Create.RADIO;
    }

    public class FlatButton extends JToggleButton
    {
        private static final long serialVersionUID = -5670592452303725224L;

        @Override
        public boolean isContentAreaFilled() 
        {
            return isSelected();
        }
    }

    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(ClarionMemoryModel model) {
        	notifyObjectChanged(getParent().getUseObject().compareTo(getValue()) == 0);
        }
    }
    
    private boolean			keyInit=false;
    private JToggleButton   button;
    private boolean         forcedSelect;
    private boolean         forcedRadioSelect;
    private ChangeListener  listener;

    
    
    @Override
	protected void handleObjectChanged(Object value) {
        JToggleButton b = button;
        if (b==null) return;
        boolean sel = (Boolean)value;
        if (b.isSelected() ^ sel) {
            forcedSelect=true;
            try {
                b.setSelected(sel);
            } finally {
                forcedSelect=false;
            }
        }
	}

	public void setForcedRadioSelect()
    {
        forcedRadioSelect=true;
    }
    
    @Override
    public void clearMetaData() {
        keyInit=false;
        button=null;
        forcedSelect=false;
        forcedRadioSelect=false;
        listener=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"button",button);
        debugMetaData(sb,"forcedSelect",forcedSelect);
        debugMetaData(sb,"forcedRadioSelect",forcedRadioSelect);
        debugMetaData(sb,"listener",listener);
    }

    @Override
    public AbstractButton getButton() {
        return button;
    }

    
    @Override
    public void opened()
    {
    	if (listener!=null) return;
    	listener=new ChangeListener();        
        getParent().getUseObject().addChangeListener(listener);
    }
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
    	if (button!=null) {
            initKeyListener();
            return;
    	}
    	
        if (isProperty(Prop.ICON)) {
            JToggleButton r = new JToggleButton();
            SwingButtonIconReceiver icon = new SwingButtonIconReceiver(r);
            icon.init(getProperty(Prop.ICON).toString(), 16,16,true);
            if (getProperty(Prop.TEXTALIGN).toString().equals("bottom")) {
            	r.setVerticalTextPosition(SwingConstants.BOTTOM);
            	r.setHorizontalTextPosition(SwingConstants.CENTER);
            }
            button=r;
        } else {
            if (isProperty(Prop.FLAT)) {
                button = new FlatButton();
                FlatBorder.init(button);
            } else {
                button = new JRadioButton();
            }
        }
        
        Insets i = button.getMargin();
        i.left = 0;
        i.right = 0;
        i.top = 0;
        i.bottom = 0;
        button.setMargin(i);
        
        addComponent(parent,button);
        configureButton();
        configureDefaults(button);
        initButton();

        if (getParent().getUseObject().equals(getValue())) {
            button.setSelected(true);
        }

        button.addItemListener(new ItemListener() {
            public void itemStateChanged(ItemEvent e) {
                if (forcedSelect) return;
                if (e.getStateChange() == ItemEvent.SELECTED) {
                	
                    sendAccept(getValue(),!forcedRadioSelect);
                    forcedRadioSelect=false;
                	
                } else {
                    forcedSelect=true;
                    try {
                        button.setSelected(true);
                    } finally {
                        forcedSelect=false;
                    }
                }
            }
        });
        initKeyListener();
    }

    public void initKeyListener() {
        if (keyInit) return;
        if (!(getParent() instanceof OptionControl)) return;
        KeyListener ki  =((OptionControl)getParent()).getRadioKey();
        if (ki==null) return;
        if (getButton()==null) return;
        getButton().addKeyListener(ki);
        keyInit=true;
	}

	@Override
    public Component getComponent() {
        return button;
    }
    

    private void sendAccept(String value,boolean accept)
    {
    	GUIModel.getServer().send(getParent(),ACCEPT,value,accept);
    }
    
    @Override
	protected void handleAWTChange(int indx, ClarionObject value) {
		if (indx==Prop.TEXT) {
            JToggleButton b = button;
            if (b==null) return;

            configureButton();
            Dimension size = b.getSize();
            Dimension psize = b.getPreferredSize();
            if (psize.width>size.width) {
                b.setSize(psize.width,size.height);
            }            		
		}
		super.handleAWTChange(indx, value);
	}

	@Override
	protected boolean isAWTChange(int indx) {
		if (indx==Prop.TEXT) return true;
		return super.isAWTChange(indx);
	}
}
