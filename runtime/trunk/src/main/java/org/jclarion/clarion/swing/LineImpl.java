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

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Stroke;

import javax.swing.Box;
import javax.swing.BoxLayout;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;

public class LineImpl extends Box implements ClarionCanvas
{
    /**
     * 
     */
    private static final long serialVersionUID = -1278925434206770718L;
    
    private LineControl control;
    private CWinImpl impl;

    private Color color;
    private int   width;
    private boolean negX;
    private boolean negY;
    
    public LineImpl(LineControl control)
    {
        super(BoxLayout.X_AXIS);
        this.control=control;
        this.impl=CWin.getInstance();
        getInfo();
        
        control.addListener(new PropertyObjectListener() {

            @Override
            public Object getProperty(PropertyObject owner, int property) {
                return null;
            }

            @Override
            public void propertyChanged(PropertyObject owner, int property,ClarionObject value) {
            	getInfo();
//                repaint();
            } 
        } );
    }

    public void getInfo()
    {
        color=impl.getColor(control,Prop.COLOR);
        if (color==null) color=Color.BLACK;
        setOpaque(false);
        width=control.getProperty(Prop.LINEWIDTH).intValue();
        width=control.getOwner().widthDialogToPixels(width);
        if (width==0) width=1;
        
        ClarionObject w=control.getRawProperty(Prop.WIDTH,false);
        negX = w!=null && w.intValue()<0;

        ClarionObject h=control.getRawProperty(Prop.HEIGHT,false);
        negY = h!=null && h.intValue()<0;
    }

    @Override
    protected void paintComponent(Graphics g) {
      g.setColor(color);
      
      Graphics2D g2d =((Graphics2D)g); 
      
      Stroke s = g2d.getStroke();
      g2d.setStroke(new BasicStroke(width));
      
      int x=width;
      int y=width;
      int runx=getWidth()-width-width;
      int runy=getHeight()-width-width;

      if (negX) {
          x+=runx;
          runx=-runx;
      }
      if (negY) {
          y+=runy;
          runy=-runy;
      }

      Object v = g2d.getRenderingHint(RenderingHints.KEY_ANTIALIASING);
      try {
          g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
          g.drawLine(x,y,x+runx,y+runy);
      } finally {
          g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,v);
      }
      
      g2d.setStroke(s);
    }
}
