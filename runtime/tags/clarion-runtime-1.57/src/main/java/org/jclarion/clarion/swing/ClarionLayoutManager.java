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
package org.jclarion.clarion.swing;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.LayoutManager2;

public class ClarionLayoutManager implements LayoutManager2 
{

    @Override
    public void addLayoutComponent(String name, Component comp) {
    }

    @Override
    public void layoutContainer(Container parent) {
    }

    @Override
    public Dimension minimumLayoutSize(Container parent) {
        return preferredLayoutSize(parent);
    }

    @Override
    public Dimension preferredLayoutSize(Container parent) {
        int maxx=0;
        int maxy=0;
        
        for (int scan=0;scan<parent.getComponentCount();scan++) {
            Component c = parent.getComponent(scan);
            int tx = c.getX()+c.getWidth();
            if (tx>maxx) maxx=tx;
            int ty = c.getY()+c.getHeight();
            if (ty>maxy) maxy=ty;
        }
        
        if (maxx==0) {maxx=50;} else {maxx+=10;}
        if (maxy==0) {maxy=50;} else {maxy+=10;}

        Dimension r = new Dimension(maxx,maxy);
        return r;
    }
    
    @Override
    public void removeLayoutComponent(Component comp) {
    }

    @Override
    public void addLayoutComponent(Component comp, Object constraints) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public float getLayoutAlignmentX(Container target) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public float getLayoutAlignmentY(Container target) {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public void invalidateLayout(Container target) 
    {
    }

    @Override
    public Dimension maximumLayoutSize(Container target) {
        return null;
    }

}
