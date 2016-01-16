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

import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

import javax.swing.AbstractButton;
import javax.swing.JCheckBox;
import javax.swing.JToggleButton;
import javax.swing.border.LineBorder;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.SwingAccept;

public class CheckControl extends AbstractButtonControl implements SimpleMnemonicAllowed {

    private String trueValue="1";
    private String falseValue="0";
    
    public String getTrueValue()
    {
        return trueValue;
    }
    
    public String getFalseValue()
    {
        return falseValue;
    }
    
    public CheckControl setValue(String trueValue,String falseValue) {
        if (trueValue!=null) this.trueValue=trueValue;
        if (falseValue!=null) this.falseValue=falseValue;
        return this;
    }

    public CheckControl setFlat() {
        setProperty(Prop.FLAT,true);
        return this;
    }

    private int acceptKey;
    
    public CheckControl setKey(int key) {
        acceptKey=key;
        return this;
    }
    
    @Override
    public int getKey()
    {
        return acceptKey;
    }


    public CheckControl setIcon(String icon) {
        setProperty(Prop.ICON,icon);
        return this;
    }

    public CheckControl setValue(ClarionString lo,ClarionString hi) {
        return setValue(lo==null?null:lo.toString(),hi==null?null:hi.toString());
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
        return Create.CHECK;
    }

    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(ClarionMemoryModel model) {
            if (ignoreVariableUpdate) return;

            CWinImpl.run(new Runnable() { 
                public void run()
                {
                    JToggleButton c = check;
                    if (c==null) return;
                    ignoreVariableChange=true;
                    try {
                        c.setSelected(getUseObject().equals(getTrueValue()));
                    } finally {
                        ignoreVariableChange=false;
                    }
                }
            });
        }
    }
    
    private JToggleButton check;
    private boolean       ignoreVariableChange;
    private boolean       ignoreVariableUpdate;
    private ChangeListener  listener;
    
    @Override
    public void clearMetaData() {
        check=null;
        ignoreVariableChange=false;
        ignoreVariableUpdate=false;
        listener=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"check",check);
        debugMetaData(sb,"ignoreVariableChange",ignoreVariableChange);
        debugMetaData(sb,"ignoreVariableUpdate",ignoreVariableUpdate);
        debugMetaData(sb,"listener",listener);
    }
    
    private CheckControl getUs()
    {
        return this;
    }
    
    @Override
    public void constructSwingComponent(Container parent) {
        if (isProperty(Prop.FLAT) || isProperty(Prop.ICON)) {
            check = new JToggleButton();
            if (!CWin.getInstance().isNimbus()) {
                check.setBorder(new LineBorder(Color.BLACK));
            }
        } else {
            check = new JCheckBox();
        }

        if (isProperty(Prop.ICON)) {
            check.setIcon(getIcon(getProperty(Prop.ICON).toString(), 16,16));
        }

        parent.add(check);

        if (getUseObject() == null) {
            use(new ClarionString());
        }

        check.setSelected(getUseObject().equals(getTrueValue()));

        check.addItemListener(new ItemListener() {

            @Override
            public void itemStateChanged(ItemEvent e) {

                if (ignoreVariableChange) return;

                if (getWindowOwner().getRefocus() != null) {
                    check.setSelected(getUseObject().equals(getTrueValue()));
                    return;
                }

                AbstractControl focus = getWindowOwner().getCurrentFocus();
                if (focus != null && focus != getUs()) {
                    SwingAccept accept = focus.getAccept();
                    if (accept != null) {
                        if (!accept.accept(true)) {
                            ignoreVariableChange=true;
                            try {
                                check.setSelected(getUseObject().equals(getTrueValue()));
                            } finally {
                                ignoreVariableChange=false;
                            }
                            return;
                        }
                    }
                }

                ignoreVariableUpdate=true;
                if (check.isSelected()) {
                    getUseObject().setValue(getTrueValue());
                } else {
                    getUseObject().setValue(getFalseValue());
                }
                ignoreVariableUpdate=false;
                post(Event.ACCEPTED);
            }
        });

        listener=new ChangeListener();
        getUseObject().addChangeListener(listener);
        
        configureButton();
        configureDefaults(check);
        initButton();
    }

    @Override
    protected void notifyLocalChange(final int indx,final ClarionObject value) {

        if (indx==Prop.ICON || indx==Prop.TEXT) {
            CWinImpl.run(new Runnable() { 
                public void run()
                {
                    JToggleButton c = check;
                    if (c==null) return;
                    switch(indx) { 
                        case Prop.ICON:
                            check.setIcon(getIcon(value.toString(), 16, 16));
                            check.setBorder(null);
                            check.setSize(20, 20);
                        case Prop.TEXT:
                            configureButton();
                            {
                                Dimension ps = check.getPreferredSize();
                                Dimension s = check.getSize();
                                if (ps.width > s.width || ps.height > s.height) {
                                if (ps.width > s.width) s.width = ps.width;
                                if (ps.height > s.height) s.height = ps.height;
                                check.setSize(s);
                            }
                        }
                    }
                }
            });
        }
        super.notifyLocalChange(indx, value);
    }

    @Override
    public AbstractButton getButton() {
        return check;
    }

    @Override
    public Component getComponent() {
        return check;
    }
    
    
}
