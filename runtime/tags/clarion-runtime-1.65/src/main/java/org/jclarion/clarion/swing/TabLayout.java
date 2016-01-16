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

public class TabLayout implements LayoutManager2
{
    private boolean spread;
    
    private int y;
    
    public TabLayout(boolean spread)
    {
        this.spread=spread;
    }

    @Override
    public void addLayoutComponent(String name, Component comp) {
    }

    private void layoutRow(Component[] kids, int first, int last, int spread,int y) 
    {
        if (last==first) return;
        int avgSpread=spread/(last-first);
        
        int x = 0;
        
        for (int scan=first;scan<last;scan++) {
            if (scan<last-1) {
                spread-=avgSpread;
            } else {
                avgSpread=spread;
            }

            Dimension current=kids[scan].getPreferredSize();
            current.height=current.height-2;
            current.width=current.width+avgSpread;
            kids[scan].setSize(current);
            kids[scan].setLocation(x,y);
            x+=current.width;
        }
    }
    
    @Override
    public void layoutContainer(Container parent) {
        int width = parent.getWidth();
        Component kids[] = parent.getComponents();
        
        int x=0;
        int y=0;
        int maxy=0;
        
        int first=0;
        
        for (int scan=0;scan<kids.length;scan++) {
            Dimension current=kids[scan].getPreferredSize();
            current.height=current.height-2;
            
            if (x>0 && x+current.width>width) {
                layoutRow(kids,first,scan,width-x,y);
                y+=maxy;
                maxy=0;
                x=0;
                first=scan;
            }
            
            x+=current.width;
            if (maxy<current.height) maxy=current.height;
        }

        if (x>0) {
            layoutRow(kids,first,kids.length,spread?width-x:0,y);
            y+=maxy;
        }    
        
        
        this.y=y;
        
    }


    public int getY()
    {
        return y;
    }
    
    @Override
    public Dimension minimumLayoutSize(Container parent) {
        return new Dimension(20,20);
    }

    @Override
    public Dimension preferredLayoutSize(Container parent) 
    {
        return new Dimension(20,20);
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
    public void invalidateLayout(Container target) {
        target.validate();
    }

    @Override
    public Dimension maximumLayoutSize(Container target) {
        // TODO Auto-generated method stub
        return null;
    }
}
