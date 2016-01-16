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

import javax.swing.JMenuBar;
import javax.swing.JRootPane;

import org.jclarion.clarion.constants.Create;

public class MenubarControl extends AbstractControl {

    private List<MenuControl> controls=new ArrayList<MenuControl>();
    
    @Override
    public void addChild(AbstractControl control)
    {
        add((MenuControl)control);
    }
    
    
    public void add(MenuControl m)
    {
        controls.add(m);
        m.setParent(this);
    }
    
    public List<MenuControl> getMenus()
    {
        return controls;
    }

    @Override
    public Collection<MenuControl> getChildren() {
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
        return Create.MENUBAR;
    }

    private JMenuBar bar;
    
    @Override
    public void clearMetaData()
    {
        bar=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"bar",bar);
    }

    @Override
    public void constructSwingComponent(Container parent) 
    {
    	if (bar!=null) return;
        JRootPane metaData = getWindowOwner().getRootPane();
        
        bar = new JMenuBar();
        setKey(bar);

        metaData.setJMenuBar(bar);

        for (MenuControl menu : getMenus()) {
            bar.add(menu.getMenu());
        }

        //if (System.getProperty("clarion.debug")!=null) {
        //    addMemoryMonitor();
        //}
    }
    
    @Override
    public Component getComponent() {
        return bar;
    }
    
}
