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
import java.awt.Point;
import java.util.Stack;

import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.DefaultFontMapper;
import com.lowagie.text.pdf.PdfContentByte;

public class PdfPrintContext extends PrintContext 
{
    private DefaultFontMapper mapper;
    
    private PdfContentByte cb;

    int xofs,yofs=0;
    
    private Stack<Point> translateHistory=new Stack<Point>();
    
    private Color       color;
    
    private Font        font;

    private Document document;

    public PdfPrintContext(Document d,PdfContentByte cb) {
        this.document=d;
        this.cb=cb;
        mapper=new DefaultFontMapper();
    }

    private void pathBox(int x1, int y1, int width, int height,int curve)
    {
        if (curve==0) {
            cb.rectangle( 
                (x1+xofs)/10.0f,
                document.getPageSize().getHeight()-(y1+yofs)/10.0f,
                width/10.0f,
                height/-10.0f);
        } else {
            cb.roundRectangle( 
                    (x1+xofs)/10.0f,
                    document.getPageSize().getHeight()-(y1+yofs)/10.0f,
                    width/10.0f,
                    height/-10.0f,curve/10.0f);
        }
    }
    
    @Override
    public void box(int x1, int y1, int width, int height, Color fg, Color bg,
            int lineWidth, int curve) {

        
        if (bg!=null) {
            //cb.closePath();
            cb.setColorFill(bg);
        
            pathBox(x1,y1,width,height,curve);

            cb.fill();
        }

        if (fg!=null) {
            //cb.closePath();
            cb.setColorStroke(fg);
            cb.setLineWidth(lineWidth/10.0f);
        
            pathBox(x1,y1,width,height,curve);

            cb.stroke();
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
        //cb.closePath();
        cb.setColorStroke(color);
        cb.setLineWidth(width/10.0f);
        cb.moveTo(
                (xofs+x1)/10f,
                document.getPageSize().getHeight()-(y1+yofs)/10.0f);
        cb.lineTo(
                (xofs+x2)/10f,
                document.getPageSize().getHeight()-(y2+yofs)/10.0f);
        cb.stroke();
    }

    @Override
    public void drawString(String text, int x, int y, boolean transparent) 
    {
        cb.beginText();
        if (color!=null) {
            cb.setColorFill(color);
        } else {
            cb.setColorFill(Color.BLACK);
        }
        cb.setFontAndSize(font.getBaseFont(),font.getSize());
        cb.setTextMatrix((x+xofs)/10,
                document.getPageSize().getHeight()-(y+yofs)/10
                -font.getSize());
        cb.showText(text);
        cb.endText();
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

}
