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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.JPanel;

import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.swing.ClarionBorder;
import org.jclarion.clarion.swing.ClarionLayoutManager;

public class GroupControl extends AbstractControl 
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
        return Create.GROUP;
    }

    private JPanel panel;
    
    @Override
    public void clearMetaData() {
        this.panel=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"panel",panel);
    }
    
    @Override
    public void constructSwingComponent(Container parent) {
        panel = new JPanel();
        panel.setOpaque(false);
        panel.setLayout(new ClarionLayoutManager());
        parent.add(panel);

        for (AbstractControl child : getChildren()) 
        {
            child.constructSwingComponent(parent);
        }

        panel.setBorder(new ClarionBorder(this, -1, 1, true));
        configureFont(panel);
        configureColor(panel);
        setPositionAndState();
   }

    @Override
    public Component getComponent() {
        return panel;
    }
    
    
}
