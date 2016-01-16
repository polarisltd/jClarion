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

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.LinearGradientPaint;
import java.awt.Point;
import java.awt.RenderingHints;
import java.awt.Component.BaselineResizeBehavior;
import java.awt.geom.Path2D;

import javax.accessibility.Accessible;
import javax.swing.AbstractButton;
import javax.swing.JComponent;
import javax.swing.plaf.ButtonUI;
import javax.swing.plaf.metal.MetalToggleButtonUI;


import org.jclarion.clarion.runtime.CWin;

public class TabButtonUI extends ButtonUI 
{
    private ButtonUI base;
    private Path2D path;

    Color shadow;
    Color high;
    Color face;
    Color selcolor;

    
    
    public TabButtonUI()
    {
        base=new MetalToggleButtonUI();
        path = new Path2D.Float();
        shadow = CWin.getInstance().getColor(org.jclarion.clarion.constants.Color.BTNSHADOW);
        if (shadow==null) shadow=Color.RED;
        high = CWin.getInstance().getColor(org.jclarion.clarion.constants.Color.BTNHIGHLIGHT);
        if (high==null) high=Color.GREEN;
        face = CWin.getInstance().getColor(org.jclarion.clarion.constants.Color.BTNFACE);
        if (face==null) face=Color.BLUE;
        
        selcolor=new Color(130,130,255);
    }
    
    @Override
    public boolean contains(JComponent c, int x, int y) {
        return base.contains(c, x, y);
    }

    @Override
    public Accessible getAccessibleChild(JComponent c, int i) {
        return base.getAccessibleChild(c, i);
    }

    @Override
    public int getAccessibleChildrenCount(JComponent c) {
        return base.getAccessibleChildrenCount(c);
    }

    @Override
    public int getBaseline(JComponent c, int width, int height) {
        return base.getBaseline(c, width, height);
    }

    @Override
    public BaselineResizeBehavior getBaselineResizeBehavior(JComponent c) {
        return base.getBaselineResizeBehavior(c);
    }

    @Override
    public Dimension getMaximumSize(JComponent c) {
        return base.getMaximumSize(c);
    }

    @Override
    public Dimension getMinimumSize(JComponent c) {
        return base.getMinimumSize(c);
    }

    @Override
    public Dimension getPreferredSize(JComponent c) {
        AbstractButton ab = (AbstractButton)c;
        FontMetrics fm =  c.getFontMetrics(c.getFont());
        return new Dimension(fm.stringWidth(ab.getText())+16,fm.getHeight()+8);
    }

    @Override
    public void installUI(JComponent c) {
        base.installUI(c);
    }

    @Override
    public void paint(Graphics g, JComponent c) {
        base.paint(g, c);
    }

    @Override
    public void uninstallUI(JComponent c) {
        base.uninstallUI(c);
    }

    @Override
    public void update(Graphics og, JComponent c) 
    {
        Graphics2D g = (Graphics2D)og;

        AbstractButton ab = (AbstractButton)c;
        boolean select = ab.isSelected();
        int width=c.getWidth()-1;
        int height=c.getHeight();
        int sep=10;
        
        Object v = g.getRenderingHint(RenderingHints.KEY_ANTIALIASING);
        try {
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
            
            path.reset();
            path.moveTo(sep,0);
            path.lineTo(width-sep,0);
            path.quadTo(width,0,width,sep);
            path.lineTo(width,height);
            path.lineTo(0,height);
            path.lineTo(0,sep);
            path.quadTo(0,0,sep,0);
            path.closePath();

            if (select) {
                LinearGradientPaint lgp = new LinearGradientPaint(
                    new Point(0,0),
                    new Point(0,height),
                    new float[] { 0.0f, 1f },
                    new Color[] {  selcolor , high }
                    );
                g.setPaint(lgp);
            } else {
                g.setColor(face);
            }
            
            g.fill(path);
            g.setPaint(null);
            g.setColor(c.isEnabled()?Color.BLACK:Color.GRAY);
            g.draw(path);
            
        } finally {
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,v);
        }
        
        

        FontMetrics fm = g.getFontMetrics();
        String s = ab.getText();
        
        g.setFont(c.getFont());
        
        int mem = ab.getDisplayedMnemonicIndex();
        sun.swing.SwingUtilities2.drawStringUnderlineCharAt((JComponent) c.getParent(),g,s,mem,8,fm.getAscent()+2);

        /*
        if (mem>-1) {
            int y = 2+fm.getAscent()+2;
            int x1 = 8+fm.stringWidth(s.substring(0,mem));
            int x2 = x1+fm.charWidth(s.charAt(mem));
            g.drawLine(x1,y,x2,y);
        }
        */
        //base.update(g, c);
    }

    
    

}
