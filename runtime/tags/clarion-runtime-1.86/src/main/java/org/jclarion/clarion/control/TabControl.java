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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.AbstractButton;
import javax.swing.JComponent;
import javax.swing.JToggleButton;
import javax.swing.SwingConstants;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.swing.TabButtonUI;


public class TabControl extends AbstractButtonControl 
{
    private List<AbstractControl> controls=new ArrayList<AbstractControl>();

    @Override
    public void addChild(AbstractControl control)
    {
        add(control);
    }

    public void removeChild(AbstractControl control)
    {
        controls.remove(control);
    }
    
    
    public AbstractControl add(AbstractControl child)
    {
        controls.add(child);
        child.setParent(this);
        return this;
    }
    
    public Collection<AbstractControl> getChildren() {
        return controls;
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
        return Create.TAB;
    }
    

    private JToggleButton button;
    
    @Override
    public void clearMetaData()
    {
        button=null;
        super.clearMetaData();
    }
    
    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"button",button);
    }
    

    @Override
    public AbstractButton getButton() 
    {
        return button;
    }
    
    public void initButton(JComponent parent,final int count)
    {
        button = new JToggleButton();
        button.setUI(new TabButtonUI());
        button.setMargin(new Insets(0, 10, 0, 10));
        button.setBorderPainted(false);
        button.setContentAreaFilled(false);
        if (count == 1) {
            button.setSelected(true);
            //button.setBorderPainted(false);
        } else {
            //button.setContentAreaFilled(false);
        }
        button.setHorizontalAlignment(SwingConstants.LEFT);
        configureButton();
        configureFont(button);
        initButton();
        button.setFocusable(false);
        parent.add(button);

        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (!button.isSelected()) {
                    button.setSelected(true);
                } else {
                	((SheetControl)getParent()).notifyChange(count);
                }
            }
        });
    }

    @Override
    public ClarionObject getLocalProperty(int index) 
    {
        if (index == Prop.VISIBLE) {
            ControlIterator ci = new ControlIterator(this, true);
            ci.setScanDisabled(true);
            return new ClarionBool(ci.isAllowed(this,false));
        }
        return super.getLocalProperty(index);
    }

    @Override
    public Component getComponent() {
        return button;
    }

    @Override
    public void constructSwingComponent(Container parent) 
    {
        ((SheetControl)getParent()).constructTab(this);
    }
}
