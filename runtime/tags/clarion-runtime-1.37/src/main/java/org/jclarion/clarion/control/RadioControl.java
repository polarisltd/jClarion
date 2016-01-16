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

import javax.swing.AbstractButton;
import javax.swing.JRadioButton;
import javax.swing.JToggleButton;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.FlatBorder;

public class RadioControl extends AbstractButtonControl implements SimpleMnemonicAllowed 
{
    private String value;
    
    public RadioControl setValue(String value) {
        this.value=value;
        return this;
    }

    public RadioControl setValue(ClarionString value) {
        this.value=value.toString();
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
        return value;
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

    private class FlatButton extends JToggleButton
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
            
            JToggleButton b = button;
            if (b==null) return;
            boolean sel = getParent().getUseObject().compareTo(getValue()) == 0;
            if (b.isSelected() ^ sel) {
                forcedSelect=true;
                try {
                    b.setSelected(sel);
                } finally {
                    forcedSelect=false;
                }
            }
        }
    }
    
    private JToggleButton   button;
    private boolean         forcedSelect;
    private boolean         forcedRadioSelect;
    private ChangeListener  listener;
    
    public void setForcedRadioSelect()
    {
        forcedRadioSelect=true;
    }
    
    @Override
    public void clearMetaData() {
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
    public void constructSwingComponent(Container parent) 
    {
        if (isProperty(Prop.ICON)) {
            JToggleButton r = new JToggleButton();
            r.setIcon(getIcon(getProperty(Prop.ICON).toString(), 16,16));
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
        
        parent.add(button);
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
                    getParent().getUseObject().setValue(getValue());
                    if (forcedRadioSelect) {
                        forcedRadioSelect=false;
                    } else {
                        getParent().post(Event.ACCEPTED);
                    }
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

        listener=new ChangeListener();
        getParent().getUseObject().addChangeListener(listener);
    }

    @Override
    public Component getComponent() {
        return button;
    }
    
    @Override
    protected void notifyLocalChange(int indx, ClarionObject value) {
        super.notifyLocalChange(indx,value);
        
        if (indx==Prop.TEXT) {
            
            CWinImpl.run(new Runnable() {
                public void run()
                {
                    JToggleButton b = button;
                    if (b==null) return;

                    configureButton();
                    Dimension size = b.getSize();
                    Dimension psize = b.getPreferredSize();
                    if (psize.width>size.width) {
                        b.setSize(psize.width,size.height);
                    }
                    
                }
            });
            
        }
    }
}
