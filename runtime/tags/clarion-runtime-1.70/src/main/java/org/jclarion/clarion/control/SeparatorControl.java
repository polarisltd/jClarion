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

import javax.swing.AbstractButton;
import javax.swing.JMenu;

import org.jclarion.clarion.constants.Create;

public class SeparatorControl extends AbstractMenuItemControl {

    @Override
    public int getCreateType() {
        return Create.ITEM;
    }

    @Override
    public void createMenuItem(JMenu parent) 
    {
        parent.addSeparator();
    }

    @Override
    public AbstractButton getButton() 
    {
        return null;
    }

    @Override
    public Component getComponent() {
        return null;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
    }
}
