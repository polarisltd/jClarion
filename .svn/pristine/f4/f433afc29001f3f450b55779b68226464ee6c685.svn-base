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
package org.jclarion.clarion.print;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Shape;
import java.awt.geom.AffineTransform;
import java.util.Stack;

import org.jclarion.clarion.swing.WaitingImageObserver;

import com.kitfox.svg.SVGDiagram;
import com.kitfox.svg.SVGException;

public class AWTPrintContext extends PrintContext
{
    private Graphics2D          g2d;
    private Stack<Shape> clipHist = new Stack<Shape>();
    private Stack<AffineTransform> transformHist = new Stack<AffineTransform>();
    
    
    public AWTPrintContext(Graphics2D g2d)
    {
        this.g2d=g2d;
    }

    @Override
    public void box(int x1, int y1, int width, int height, 
            Color fg,Color bg,
            int lineWidth,int curve) {
        
        if (bg!=null) {
            g2d.setColor(bg);
            if (curve==0) {
                g2d.fillRect(x1,y1,width,height);
            } else {
                g2d.fillRoundRect(x1,y1,width,height,curve,curve);
                
            }
        }
        
        if (fg!=null) {
            g2d.setStroke(new BasicStroke(lineWidth));
            g2d.setColor(fg);
            if (curve==0) {
                g2d.drawRect(x1,y1,width,height);
            } else {
                g2d.drawRoundRect(x1,y1,width,height,curve,curve);
                
            }
        }
    }

    @Override
    public void clip(int x1, int y1, int width, int height) {
        clipHist.push(g2d.getClip());
        g2d.setClip(x1,y1,width,height);
    }

    @Override
    public void drawLine(int x1, int y1, int x2, int y2, int width) {
        g2d.setStroke(new BasicStroke(width));
        g2d.drawLine(x1,y1,x2,y2);
    }

    @Override
    public void drawString(String text, int x, int y,boolean trans) {
        
        if (!trans) {
            int w = g2d.getFontMetrics().stringWidth(text);
            int h = g2d.getFontMetrics().getHeight();
            Color c = g2d.getColor();
            g2d.setColor(Color.WHITE);
            g2d.fillRect(x,y,w,h);
            g2d.setColor(c);
        }

        g2d.drawString(text,x,y+g2d.getFontMetrics().getAscent());
    }

    @Override
    public int getHeight() {
        return g2d.getFontMetrics().getHeight();
    }

    @Override
    public void restoreClip() {
        g2d.setClip(clipHist.pop());
    }

    @Override
    public void restoreTranslation() {
        g2d.setTransform(transformHist.pop());
    }

    @Override
    public void setColor(Color color) {
        g2d.setColor(color);
    }

    @Override
    public void setFont(Font font) {
        g2d.setFont(font);
    }

    @Override
    public int stringWidth(String text) {
        return g2d.getFontMetrics().stringWidth(text);
    }

    @Override
    public void translate(int scaleX, int scaleY) {
        transformHist.push(g2d.getTransform());
        g2d.translate(scaleX,scaleY);
    }

    @Override
    public void complete() 
    {
        this.g2d.scale(10,10);
    }

    @Override
    public void start() 
    {
        this.g2d.scale(0.1,0.1);
    }

    @Override
    public void drawImage(Image img, int x, int y, int width, int height) 
    {
        if (!this.g2d.drawImage(img,x,y,width,height,null,null)) {
            WaitingImageObserver wait = new WaitingImageObserver();
            if (!this.g2d.drawImage(img,x,y,width,height,null,wait)) {
                wait.waitTillDone();
                this.g2d.drawImage(img,x,y,width,height,null,null);
            }
        }
    }

	@Override
	public void drawImage(SVGDiagram diagram, int x1, int y1, int width,int height) {
		
		AffineTransform b= g2d.getTransform();
		g2d.translate(x1, y1);		
		if (width!=0 && height!=0) {
			float sx=diagram.getWidth();					
			float sy=diagram.getHeight();
			g2d.scale(width/sx,height/sy);
		}
		
		try {
			diagram.render(g2d);
		} catch (SVGException e) {
			e.printStackTrace();
		}		
		g2d.setTransform(b);
	}

}
