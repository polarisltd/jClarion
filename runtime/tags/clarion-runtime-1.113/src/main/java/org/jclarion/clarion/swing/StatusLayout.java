package org.jclarion.clarion.swing;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.LayoutManager;

public class StatusLayout implements LayoutManager
{
    private int[] sizes;
    public StatusLayout(int sizes[])
    {
        this.sizes=sizes;
    }
    
    @Override
    public void addLayoutComponent(String name, Component comp) 
    {
    }

    @Override
    public void layoutContainer(Container parent) 
    {
        
        int committedSize=0;
        int adjustCount=0;
        for (int scan=0;scan<sizes.length;scan++) {
            if (sizes[scan]>0) {
                committedSize+=sizes[scan];
            } else {
                committedSize-=sizes[scan];
                adjustCount++;
            }
        }
        
        int adjustSize=0;
        if (adjustCount>0) {
            adjustSize=(parent.getWidth()-committedSize)/adjustCount;
        }
        
        int xpos=0;
        for (int scan=0;scan<parent.getComponentCount();scan++) {
            Component base = parent.getComponent(scan);
            Dimension pref = base.getPreferredSize();
            base.setLocation(xpos,0);
            int width = sizes[scan];
            if (width<0) {
                width=-width+adjustSize;
            }
            base.setSize(width,pref.height);
            xpos+=width;
        }
    }

    @Override
    public Dimension minimumLayoutSize(Container parent) 
    {
        int maxHeight=0;
        int width=0;
        for (int scan=0;scan<parent.getComponentCount();scan++) {
            Component base = parent.getComponent(scan);
            Dimension pref = base.getMinimumSize();
            if (sizes[scan]>0) {
                width+=sizes[scan];
            } else {
                width-=sizes[scan];
            }
            if (pref.height>maxHeight) maxHeight=pref.height;
        }
        return new Dimension(width,maxHeight);
    }

    @Override
    public Dimension preferredLayoutSize(Container parent) 
    {
        int maxHeight=0;
        int width=0;
        for (int scan=0;scan<parent.getComponentCount();scan++) {
            Component base = parent.getComponent(scan);
            Dimension pref = base.getPreferredSize();
            if (sizes[scan]>0) {
                width+=sizes[scan];
            } else {
                width-=sizes[scan];
            }
            if (pref.height>maxHeight) maxHeight=pref.height;
        }
        return new Dimension(width,maxHeight);
    }

    @Override
    public void removeLayoutComponent(Component comp) 
    {
    }
}
