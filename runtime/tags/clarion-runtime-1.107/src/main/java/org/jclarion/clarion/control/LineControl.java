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

import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.swing.LineImpl;

public class LineControl extends AbstractControl {

    public LineControl setLineWidth(int width)
    {
        setProperty(Prop.LINEWIDTH,width);
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
        return Create.LINE;
    }

    private LineImpl li;
    private Insets   insets;
    
    
    
    @Override
    public void clearMetaData()
    {
        li=null;
        insets=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"li",li);
        debugMetaData(sb,"insets",insets);
    }
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
    	if (li!=null) return;
        if (!isProperty(Prop.LINEWIDTH)) {
            setLineWidth(1);
        }
        li = new LineImpl(this);
        
        int width = getProperty(Prop.LINEWIDTH).intValue();
        insets=new Insets(width,width,width,width);
        
        setPositionAndState();
        addComponent(parent,li);
    }

    @Override
    public Component getComponent() {
        return li;
    }

    @Override
    public Insets getControlAdjustInsets() {
        return insets;
    }
    
    
}
