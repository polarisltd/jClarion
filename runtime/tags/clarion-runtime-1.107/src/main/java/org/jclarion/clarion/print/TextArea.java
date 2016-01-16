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
import java.util.ArrayList;
import java.util.List;


import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.runtime.format.Formatter;

public class TextArea extends AbstractElement implements TextElement
{
    private String text;
    private String unformat;
    private Color color;
    private Font font;
    private boolean resize;
    private List<String> lines;

    @Override
 	public PrintElement split(Page report,PrintContext g,int maxHeight) {
 		TextArea ta = new TextArea(control,unformat,text,x1,y1,x2,y2,color,font,resize);
        if (!resize) return ta;

        g.setFont(font);
        int maxlines=0;
        maxlines = report.scaleY(maxHeight-y1,false)/g.getHeight();
        if (maxlines<=0) maxlines=1;
        
        StringBuilder t1 = new StringBuilder(text.length());
        StringBuilder t2 = new StringBuilder(text.length());

        TextBreaker tb = new TextBreaker(text,g,report.scaleX(x2-x1,true));
        boolean any=false;
        while (maxlines>0) {
        	String n = tb.next();
        	if (n==null) break;
        	if (any) { 
        		t1.append('\n');
        	} else {
        		any=true;
        	}
        	t1.append(n);
        	maxlines--;
        }

        any=false;
        while (true) {
        	String n = tb.next();
        	if (n==null) break;
        	if (any) { 
        		t2.append('\n');
        	} else {
        		any=true;
        	}
        	t2.append(n);        	
        }
        
        this.text=t1.toString();
        this.lines=null;
        this.y2=this.y1;
        
        ta.text=t2.toString();
        ta.y2=ta.y1;
        
        this.getPreferredDimensions(report, g);
        ta.getPreferredDimensions(report, g);

        return ta;
 	}    
    
    
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
        g.setColor(color);
        g.setFont(font);
        
        int height = g.getHeight();
        int yofs = r.scaleY(y1,false); 
        int x1=r.scaleX(this.x1,false);
 
        for (String line : getLines(r,g)) {
            g.drawString(line,x1,yofs,false);
            yofs+=height;
        }
        
        //g.restoreClip();
    }

    private List<String> getLines(Page report,PrintContext g)
    {
    	if (lines==null) {
    		lines=new ArrayList<String>();
            g.setFont(font);
            TextBreaker tb = new TextBreaker(text,g,report.scaleX(x2-x1,true));
            while (true) {
            	String n = tb.next();
            	if (n==null) break;
            	lines.add(n);
            }
    	}
    	return lines;
    }
    
    @Override
    public Rectangle getPreferredDimensions(Page report,PrintContext g) 
    {
        if (resize) {
            g.setFont(font);
            this.y2=this.y1+report.descaleY(getLines(report, g).size()*g.getHeight(),true);
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
		lines=null;
	}
}
