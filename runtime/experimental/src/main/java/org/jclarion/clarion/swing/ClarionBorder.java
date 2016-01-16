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
import java.awt.Component;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.LayoutManager;
import java.awt.geom.Rectangle2D;

import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.UIManager;
import javax.swing.border.Border;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWinImpl;


public class ClarionBorder implements Border
{
    static Color h1 = CWinImpl.getUIColor("controlHighlight");
    static Color h2 = CWinImpl.getUIColor("controlLtHighlight","controlLHighlight");

    static Color d1 = CWinImpl.getUIColor("controlShadow");
    static Color d2 = CWinImpl.getUIColor("controlDkShadow");

    static Color t = UIManager.getColor("text");

    private int         outer;
    private int         inner;
    private String      title;
    private boolean     stepTitle=false;
    
    public ClarionBorder(int outer,int inner,String title)
    {
        this.outer=outer;
        this.inner=inner;
        this.title=title;
    }

    public ClarionBorder(PropertyObject po,int defOuter,int defInner,boolean allowTitle)
    {
        if (po.isProperty(Prop.BOXED)) {
            this.outer=defOuter;
            this.inner=defInner;
            stepTitle=allowTitle;
            
            ClarionObject co;
            co= po.getRawProperty(Prop.BEVELOUTER);
            if (co!=null) {
                outer=co.intValue();
                allowTitle=false;
                stepTitle=false;
            }
            co= po.getRawProperty(Prop.BEVELINNER);
            if (co!=null) {
                inner=co.intValue();
                allowTitle=false;
                stepTitle=false;
            }
        
            this.title=null;
            if (allowTitle) {
                co = po.getRawProperty(Prop.TEXT);
                if (co!=null) {
                    title=co.toString();
                }
            }
        } else {
            stepTitle=false;
        }
    }
    
    @Override
    public Insets getBorderInsets(Component c) {
        return new Insets(0,0,0,0);
    }
    
    @Override
    public boolean isBorderOpaque() {
        return false;
    }
    
    @Override
    public void paintBorder(Component c, Graphics g, int x, int y, int width,
            int height) {

        if (c instanceof JPanel) {
            LayoutManager lm = ((JPanel)c).getLayout();
            if (lm instanceof TabLayout) {
                int my = ((TabLayout)lm).getY();
                if (my>0) my--;
                y+=my;
                height-=my;
            }
        }
        
        Rectangle2D sb=null;
        int ty=y;
        
        if (title!=null) {
            g.setFont(c.getFont());
            FontMetrics fm = g.getFontMetrics();
            y+=fm.getHeight()/2;
            ty+=fm.getMaxAscent();
            sb=fm.getStringBounds(title,g);
            height-=fm.getMaxAscent();
        } else if (stepTitle) {
            g.setFont(c.getFont());
            FontMetrics fm = g.getFontMetrics();
            y+=fm.getHeight()/2;
            ty+=fm.getMaxAscent();
            height-=fm.getMaxAscent();
        }
        
        width--;
        height--;

        int lwidth=0;
        
        for (int mode=0;mode<2;mode++) {
            int scan=mode==0?outer:inner;
            while (scan!=0) {
                lwidth++;
                if (mode==0) {
                    g.setColor(scan>0?h2:d1);
                } else {
                    g.setColor(scan>0?h1:d2);
                }
                g.drawLine(x,y,x+width,y);
                g.drawLine(x,y,x,y+height);

                if (mode==0) {
                    g.setColor(scan>0?d2:h1);
                } else {
                    g.setColor(scan>0?d1:h2);
                }
                g.drawLine(x+width,y+height,x+width,y);
                g.drawLine(x+width,y+height,x,y+height);
                scan=scan+(scan>0?-1:1);
            
                x++;
                y++;
                width-=2;
                height-=2;
            }
        }

        if (title!=null) {
            x+=2;
            g.setColor(c.getBackground());
            g.fillRect(x,y-lwidth,(int)sb.getWidth()+10,lwidth);
            
            Component scan = c;
            while (scan!=null && !(scan instanceof JComponent)) {
                scan=scan.getParent();
            }
            
            if (c.isEnabled()) {
                g.setColor(Color.BLACK);
                sun.swing.SwingUtilities2.drawString((JComponent)scan,g,title,x+5,ty);
            } else {
                g.setColor(h1);
                sun.swing.SwingUtilities2.drawString((JComponent)scan,g,title,x+6,ty+1);
                g.setColor(d1);
                sun.swing.SwingUtilities2.drawString((JComponent)scan,g,title,x+5,ty);
            }
        }
    }
            
}
