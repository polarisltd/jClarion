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

public class Box extends AbstractElement
{
    private static final int CURVE=100;
    
    private int width;
    private Color bg;
    private Color fg;
    private boolean round;
    
    @Override
	public PrintElement split(Page report,PrintContext g,int reduceHeight) {
		return new Box(control,x1,y1,x2,y2,width,fg,bg,round);
	}    
    
    public Box(AbstractControl control,int x1,int y1,int x2,int y2,int width,Color fg,Color bg,boolean round)
    {
        super(control,x1,y1,x2,y2,true);
        this.width=width;
        
        if (bg==null && fg==null) {
            fg=Color.BLACK;
        }
        
        this.bg=bg;
        this.fg=fg;
        this.round=round;
    }

    @Override
    public void paint(Page r,PrintContext g) 
    {
        
        int x1=r.scaleX(this.x1,false);
        int y1=r.scaleY(this.y1,false);
        int x2=r.scaleX(this.x2,true);
        int y2=r.scaleY(this.y2,true);
        int width=r.scaleX(this.width,false);
        if (width<5) width=5;
    
        int roundIndx=0;
        if (round) {
            roundIndx=r.scaleX(CURVE,false);
        }
        
        g.box(x1,y1,x2-x1,y2-y1,fg,bg,width,roundIndx);
    }

	@Override
	public Object[] getMetaData() {
		return new Object[] { x1,y1,x2,y2,width,bg,fg,round};
	}
	
	public Box(Object[] o) {
		super(o);
		width=(Integer)o[4];
		bg=(Color)o[5];
		fg=(Color)o[6];
		round=(Boolean)o[7];
	}
}
