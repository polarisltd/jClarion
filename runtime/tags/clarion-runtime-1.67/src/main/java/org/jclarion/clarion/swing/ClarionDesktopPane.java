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
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;

import javax.swing.JComponent;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.Scrollable;

public class ClarionDesktopPane extends JDesktopPane implements Scrollable
{
    private static final long serialVersionUID = -8633187541933389502L;

    
    
    @Override
    public Dimension getPreferredScrollableViewportSize() {
        return getPreferredSize();
    }

    @Override
    public int getScrollableBlockIncrement(Rectangle visibleRect,
            int orientation, int direction) 
    {
        return 30;
    }

    @Override
    public boolean getScrollableTracksViewportHeight() {
        
        Dimension d = getPreferredSize();
        return (d.height<getParent().getHeight());
    }

    @Override
    public boolean getScrollableTracksViewportWidth() {
        Dimension d = getPreferredSize();
        return (d.width<getParent().getWidth());
    }

    @Override
    public int getScrollableUnitIncrement(Rectangle visibleRect,int orientation, int direction) {
        return 10;
    }
    
    @Override
    public Dimension getPreferredSize()
    {
        int w=50;
        int h=50;
        for ( Component c : getComponents() ) {
            
            if (!c.isVisible()) continue;

            if (c instanceof JComponent) {
                if (((JComponent)c).getClientProperty("shadow")!=null) continue;
            }
            
            if (c instanceof JInternalFrame) {
                if (((JInternalFrame)c).isMaximum()) continue;
            }

            
            int nw = c.getX()+c.getWidth();
            if (nw>w) w=nw; 

            int nh = c.getY()+c.getHeight();
            if (nh>h) h=nh; 
        }
        
        return new Dimension(w,h);
    }
    
    public ClarionDesktopPane getDesktop()
    {
        return this;
    }

    @Override
    protected void addImpl(Component comp, Object constraints, int index) {
        relocate(comp);
        super.addImpl(comp, constraints, index);
        
        comp.addComponentListener(new ComponentListener() {

            @Override
            public void componentHidden(ComponentEvent e) {
                // TODO Auto-generated method stub
            }

            @Override
            public void componentMoved(ComponentEvent e) {
                relocate(e.getComponent());
                getDesktop().invalidate();
                getDesktop().getParent().validate();
            }

            @Override
            public void componentResized(ComponentEvent e) {
                getDesktop().invalidate();
                getDesktop().getParent().validate();
            }

            @Override
            public void componentShown(ComponentEvent e) {
                // TODO Auto-generated method stub
            } } );
        
        invalidate();
    }

    @Override
    public void remove(int index) {
        super.remove(index);
        invalidate();
    }
    
    public void relocate(Component c)
    {
        if (c.getX()<0 || c.getY()<0) {
            Point t = c.getLocation();
            if (t.x<0) t.x=0;
            if (t.y<0) t.y=0;
            c.setLocation(t);
            invalidate();
        }
    }
}
