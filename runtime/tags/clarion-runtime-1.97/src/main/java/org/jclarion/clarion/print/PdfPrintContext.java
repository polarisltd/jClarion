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

import java.awt.Color;
import java.awt.Image;
import java.awt.Point;
import java.io.IOException;
import java.util.Stack;

import com.kitfox.svg.SVGDiagram;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.DefaultFontMapper;

public class PdfPrintContext extends PrintContext 
{
    private DefaultFontMapper mapper;

    int xofs,yofs=0;
    
    private Stack<Point> translateHistory=new Stack<Point>();
    
    private Color       color;
    
    private Font        font;

    private PDFContext context;

    public PdfPrintContext(PDFContext context) {
    	this.context=context;
        mapper=new DefaultFontMapper();
    }

    private void pathBox(int x1, int y1, int width, int height,int curve)
    {
        if (curve==0) {
            context.cb.rectangle( 
                (x1+xofs)/10.0f,
                context.document.getPageSize().getHeight()-(y1+yofs)/10.0f,
                width/10.0f,
                height/-10.0f);
        } else {
            context.cb.roundRectangle( 
                    (x1+xofs)/10.0f,
                    context.document.getPageSize().getHeight()-(y1+yofs)/10.0f,
                    width/10.0f,
                    height/-10.0f,curve/10.0f);
        }
    }
    
    @Override
    public void box(int x1, int y1, int width, int height, Color fg, Color bg,
            int lineWidth, int curve) {

        
        if (bg!=null) {
            //context.cb.closePath();
            context.cb.setColorFill(bg);
        
            pathBox(x1,y1,width,height,curve);

            context.cb.fill();
        }

        if (fg!=null) {
            //context.cb.closePath();
            context.cb.setColorStroke(fg);
            context.cb.setLineWidth(lineWidth/10.0f);
        
            pathBox(x1,y1,width,height,curve);

            context.cb.stroke();
        }
    }

    @Override
    public void clip(int x1, int y1, int width, int height) 
    {
    }

    @Override
    public void complete() {
    }

    @Override
    public void drawLine(int x1, int y1, int x2, int y2, int width) {
        //context.cb.closePath();
        context.cb.setColorStroke(color);
        context.cb.setLineWidth(width/10.0f);
        context.cb.moveTo(
                (xofs+x1)/10f,
                context.document.getPageSize().getHeight()-(y1+yofs)/10.0f);
        context.cb.lineTo(
                (xofs+x2)/10f,
                context.document.getPageSize().getHeight()-(y2+yofs)/10.0f);
        context.cb.stroke();
    }

    @Override
    public void drawString(String text, int x, int y, boolean transparent) 
    {
        context.cb.beginText();
        if (color!=null) {
            context.cb.setColorFill(color);
        } else {
            context.cb.setColorFill(Color.BLACK);
        }
        context.cb.setFontAndSize(font.getBaseFont(),font.getSize());
        context.cb.setTextMatrix((x+xofs)/10,
        		context.document.getPageSize().getHeight()-(y+yofs)/10
                -font.getSize());
        context.cb.showText(text);
        context.cb.endText();
    }

    @Override
    public int getHeight() {
        return (int)(font.getSize()*10);
    }

    @Override
    public void restoreClip() 
    {
    }

    @Override
    public void restoreTranslation() {
        Point p = translateHistory.pop();
        xofs=p.x;
        yofs=p.y;
    }

    @Override
    public void setColor(Color color) {
        this.color=color;
    }

    @Override
    public void setFont(java.awt.Font font) {
        this.font = new Font(mapper.awtToPdf(font),font.getSize()/10.0f);
    }

    @Override
    public void start() {
    }

    @Override
    public int stringWidth(String text) {
        return (int)(font.getBaseFont().getWidth(text)*font.getSize()/100);
    }

    @Override
    public void translate(int scaleX, int scaleY) 
    {
        translateHistory.push(new Point(xofs,yofs));
        xofs+=scaleX;
        yofs+=scaleY;
    }

    @Override
    public void drawImage(Image img, int x, int y, int width, int height) 
    {
        try {
        	com.lowagie.text.Image pdfimg = context.cache.get(img);
        	if (pdfimg==null) {
        		pdfimg=com.lowagie.text.Image.getInstance(img,null);
        		context.cache.put(img,pdfimg);
        	}
        	
            context.cb.addImage(pdfimg,
                    width/10.0f,0,0,height/10.0f,
                    (xofs+x)/10.0f,
                    context.document.getPageSize().getHeight()-(y+yofs+height)/10.0f
                    );
        } catch (BadElementException e) {
            e.printStackTrace();
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

	@Override
	public void drawImage(SVGDiagram diagram, int x1, int y1, int width,
			int height) {
		// TODO Auto-generated method stub
		
	}
}
