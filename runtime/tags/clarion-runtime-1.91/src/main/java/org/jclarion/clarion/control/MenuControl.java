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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.swing.AbstractButton;
import javax.swing.JMenu;

import org.jclarion.clarion.constants.Create;

public class MenuControl extends AbstractMenuItemControl {

    private List<AbstractMenuItemControl> controls=new ArrayList<AbstractMenuItemControl>();

    @Override
    public void addChild(AbstractControl control)
    {
        add((AbstractMenuItemControl)control);
    }
    
    
    public void add(AbstractMenuItemControl ic)
    {
        controls.add(ic);
        ic.setParent(this);
    }
    
    @Override
    public Collection<AbstractMenuItemControl> getChildren() {
        return controls;
    }
    
    @Override
    public int getCreateType() {
        return Create.MENU;
    }

    private JMenu menu;
    
    @Override
    public void clearMetaData()
    {
        menu=null;
        super.clearMetaData();
    }
    
    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"menu",menu);
    }
    
    
    
    public JMenu getMenu() 
    {
        if (menu==null) {
            menu = new JMenu();
            configureDefaults(menu);
            configureButton();
            initButton();
            setKey(menu);

            for (AbstractMenuItemControl amc : controls ) {
                amc.createMenuItem(menu);
            }
        }
        return menu;
    }


    @Override
    public void createMenuItem(JMenu parent) 
    {
        parent.add(getMenu());
    }

    @Override
    public AbstractButton getButton() 
    {
        return menu;
    }


    @Override
    public Component getComponent() {
        return menu;
    }
}
