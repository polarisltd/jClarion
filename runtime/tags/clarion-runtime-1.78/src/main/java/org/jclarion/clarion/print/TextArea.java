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


import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.runtime.format.Formatter;

public class TextArea extends AbstractElement implements TextElement
{
    private String text;
    private String unformat;
    private Color color;
    private Font font;
    private boolean resize;

    public TextArea(AbstractControl control,String unformat,String text,int x1,int y1,int x2,int y2,Color color,Font font,boolean resize)
    {
        super(control,x1,y1,x2,y2,true);
        this.text=text;
        this.unformat=unformat;
        this.color=color;
        this.font=font;
        this.resize=resize;
    }

    @Override
    public void paint(Page r,PrintContext g) {
        g.setFont(font);
        g.setColor(color);
        
        TextBreaker tb = new TextBreaker(text,g,r.scaleX(x2-x1,true));
        
        int height = g.getHeight();
        int yofs = r.scaleY(y1,false); 
        int x1=r.scaleX(this.x1,false);
 
        while ( true ) {
            String line = tb.next();
            if (line==null) break;
            g.drawString(line,x1,yofs,false);
            yofs+=height;
        }
        
        //g.restoreClip();
    }

    @Override
    public Rectangle getPreferredDimensions(Page report,PrintContext g) 
    {
        if (resize) {
            g.setFont(font);
            TextBreaker tb = new TextBreaker(text,g,report.scaleX(x2-x1,true));
            int count=0;
            while (tb.next()!=null) count++;
            this.y2=report.descaleY(this.y1+count*g.getHeight(),true);
        }

        return super.getPreferredDimensions(report,g);
    }

	@Override
	public String getText() {
		return text;
	}

	@Override
	public String getUnformattedText() {
		return unformat;
	}
	
    public Formatter getFormatter()
    {
    	if (control!=null) return control.getPicture();
    	return null;
    }

    @Override
	public Object[] getMetaData() {
		return new Object[] { x1,y1,x2,y2,text,color,font};
	}

	public TextArea(Object[] o) {
		super(o);
		text=(String)o[4];
		color=(Color)o[5];
		font=(Font)o[6];
	}
}
