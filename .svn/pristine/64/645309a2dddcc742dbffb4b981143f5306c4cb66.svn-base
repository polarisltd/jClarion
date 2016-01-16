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
import java.awt.Rectangle;
import java.awt.Font;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.runtime.format.Formatter;

public class Text extends AbstractElement implements TextElement
{
    public enum Justify { LEFT, RIGHT, CENTER, DECIMAL }

    private String unformat;
    private String text;
    private Justify justify;
    private int justifyOffset;
    private Color color;
    private Font font;
    private boolean transparent;
    
    public Text(
            AbstractControl control,
            String unformat,String text,
            int x1,int y1,int x2,int y2,
            Justify justify,int justifyOffset,
            Color color,Font font,
            boolean transparent)
    {
        super(control,x1,y1,x2,y2,true);
        this.unformat=unformat;
        this.text=text;
        this.justify=justify;
        this.justifyOffset=justifyOffset;
        this.color=color;
        if (this.color==null) this.color=Color.BLACK;
        this.font=font;
        this.transparent=transparent;
    }
    
    
    
    @Override
    public void paint(Page r,PrintContext c) {
        
        int x1=r.scaleX(this.x1,false);
        int y1=r.scaleY(this.y1,false);
        int x2=r.scaleX(this.x2,true);
        int y2=r.scaleY(this.y2,true);
        int justifyOffset=r.scaleX(this.justifyOffset,false);
        
        c.clip(x1, y1, x2-x1, y2-y1);

        c.setFont(font);
        c.setColor(color);
        
        int offset=0;

        if (justify==Justify.LEFT) {
            offset=justifyOffset;
        }
        
        if (justify==Justify.RIGHT) {
            offset=(x2-x1)-c.stringWidth(text)-justifyOffset;
        }

        if (justify==Justify.CENTER) {
            offset=((x2-x1)-c.stringWidth(text))/2+justifyOffset;
        }

        if (justify==Justify.DECIMAL) {
            
            int lastDot = text.lastIndexOf('.');
            String trim=text;
            if (lastDot>-1) {
                trim=text.substring(0,lastDot+1);
            }
            
            offset=(x2-x1)-c.stringWidth(trim)-justifyOffset;
        }

        c.drawString(text,x1+offset,y1,transparent);
        
        c.restoreClip();
    }



    @Override
    public Rectangle getPreferredDimensions(Page report,PrintContext c) {
        
        if (x2-x1==0 || y2-y1==0) {
            c.setFont(font);
            c.setColor(color);
            if (y2-y1==0) {
                y2=y1+report.descaleY(c.getHeight(),true);
            }
            if (x2-x1==0) {

                int m1 = report.descaleX(c.stringWidth(text),true);
                int m2=0;
                
                if (control!=null) {
                    if (control.getPicture()!=null) {
                        m2 = report.descaleX(c.stringWidth(control.getPicture().getPictureRepresentation()),true);
                    }
                }
                
                x2=x1+(m1>m2?m1:m2);
            }
        }
        
        // TODO Auto-generated method stub
        return super.getPreferredDimensions(report,c);
    }
    
    public String getText()
    {
        return text;
    }

    public void setText(String text)
    {
    	this.unformat=text;
        if (control!=null) {
            if (control.getPicture()!=null) {
                text = control.getPicture().format(text).trim();
            }
        }
        this.text=text;
    }
    
    public Formatter getFormatter()
    {
    	if (control!=null) return control.getPicture();
    	return null;
    }

    @Override
    public void update(Page page)
    {
        if (control!=null) {
            if (control.isProperty(Prop.PAGENO)) {
                setText(String.valueOf(page.getPageNo()));
                return;
            }
            
            if (getAggregate()!=null && getAggregate().isPagedItem()) {
                
                getAggregate().reset();
                
                for ( PrintObject po : page.getPrintObjects() ) {
                    if (!(po.getControl() instanceof ReportDetail)) continue; 
                    if (!po.contains(control.getUseObject())) continue;

                    getAggregate().add(po.getFieldValue(control.getUseObject()));
                }
                setText(getAggregate().get().toString());
            }
        }
    }



	@Override
	public String getUnformattedText() {
		return unformat;
	}

}
