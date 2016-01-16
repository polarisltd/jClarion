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
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.AbstractButton;
import javax.swing.JMenu;
import javax.swing.JMenuItem;

import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;

public class ItemControl extends AbstractMenuItemControl {

    @Override
    public int getCreateType() {
        return Create.ITEM;
    }

    private JMenuItem item;
    
    @Override
    public void clearMetaData()
    {
        item=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"item",item);
    }
    

    @Override
    public void createMenuItem(JMenu parent) 
    {
        item = new JMenuItem();
        item.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                post(Event.ACCEPTED);
            }
        });
        configureButton();
        configureDefaults(item);        
        setKey(item);
        initButton();
        parent.add(item);
    }

    @Override
    public AbstractButton getButton() {
        return item;
    }


    @Override
    public Component getComponent() {
        return item;
    }
    
}
