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

import javax.swing.JPanel;

import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.swing.ClarionBorder;
import org.jclarion.clarion.swing.ClarionLayoutManager;

public class PanelControl extends AbstractControl {

    public PanelControl setFillColor(int color)
    {
        setProperty(Prop.FILL,color);
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
        return Create.PANEL;
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
    public void constructSwingComponent(Container parent) 
    {
    	if (panel!=null) return;
        setProperty(Prop.BOXED, true);
        panel = new JPanel();
        panel.setLayout(new ClarionLayoutManager());
        addComponent(parent,panel);

        Color bg = getColor(Prop.FILL);
        if (bg != null) {
            panel.setOpaque(true);
            panel.setBackground(bg);
        } else {
            panel.setOpaque(false);
        }

        panel.setBorder(new ClarionBorder(this,1, 1, false));
        configureFont(panel);
        configureColor(panel);
        setPositionAndState();
    }

    @Override
    public Component getComponent() {
        return panel;
    }
    
    
}
