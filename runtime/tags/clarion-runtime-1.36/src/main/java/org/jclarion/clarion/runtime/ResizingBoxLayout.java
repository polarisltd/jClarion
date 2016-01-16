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
package org.jclarion.clarion.runtime;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.LayoutManager;

import javax.swing.JComponent;

public class ResizingBoxLayout implements LayoutManager
{
    private int XGAP=5;
    
    @Override
    public void addLayoutComponent(String name, Component comp) 
    {
        // TODO Auto-generated method stub
    }

    @Override
    public void layoutContainer(Container parent) 
    {
        int width=  parent.getWidth();
        int xpos=0;
        int ypos=0;
        int height=0;
        
        for (Component scan : parent.getComponents() )
        {
            Dimension d = scan.getPreferredSize();
            boolean newline = (scan instanceof JComponent && ((JComponent)scan).getClientProperty("newline")!=null);
            if (xpos>0) xpos+=XGAP;
            if (newline || xpos+d.width>width) {
                xpos=0;
                ypos+=height;
                height=0;
            }
            
            scan.setLocation(xpos,ypos);
            scan.setSize(d);
            xpos+=d.width;
            if (d.height>height) height=d.height;
        }
    }

    @Override
    public Dimension minimumLayoutSize(Container parent) 
    {
        return new Dimension(0,0);
    }

    @Override
    public Dimension preferredLayoutSize(Container parent) 
    {
        //int width=  parent.getWidth();
        int xpos=0;
        int ypos=0;
        int height=0;
        int maxx=0;
        
        for (Component scan : parent.getComponents() )
        {
            Dimension d = scan.getPreferredSize();
            boolean newline = (scan instanceof JComponent && ((JComponent)scan).getClientProperty("newline")!=null);
            if (xpos>0) xpos+=XGAP;
            if (newline) {
                xpos=0;
                ypos+=height;
                height=0;
            }
            
            scan.setLocation(xpos,ypos);
            scan.setSize(d);
            xpos+=d.width;
            if (xpos>maxx) maxx=xpos;
            if (d.height>height) height=d.height;
        }
        
        return new Dimension(maxx,ypos+height);
    }

    @Override
    public void removeLayoutComponent(Component comp) 
    {
    }
}
