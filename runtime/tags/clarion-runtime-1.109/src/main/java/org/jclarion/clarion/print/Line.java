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

import org.jclarion.clarion.control.AbstractControl;

public class Line extends AbstractElement  
{
    private int width;
    private Color color;
    
    @Override
 	public PrintElement split(Page report,PrintContext g,int reduceHeight) {
 		return new Line(control,x1,y1,x2,y2,width,color);
 	}    
    
    public Line(AbstractControl control,int x1,int y1,int x2,int y2,int width,Color color)
    {
        super(control,x1,y1,x2,y2,false);
        this.width=width;
        this.color=color;
    }

    @Override
    public void paint(Page r,PrintContext g) 
    {
        int x1=r.scaleX(this.x1,false);
        int y1=r.scaleY(this.y1,false);
        int x2=r.scaleX(this.x2,this.x1!=this.x2);
        int y2=r.scaleY(this.y2,this.y1!=this.y2);
        int width=r.scaleX(this.width,false);
        if (width<5) width=5;
        
        g.setColor(color);
        g.drawLine(x1,y1,x2,y2,width);
    }

	@Override
	public Object[] getMetaData() {
		return new Object[] { x1,y1,x2,y2,width,color};
	}
	
	public Line(Object[] o) {
		super(o);
		width=(Integer)o[4];
		color=(Color)o[5];
	}
}
