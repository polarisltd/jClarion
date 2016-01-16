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

import java.awt.Image;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.runtime.CWin;

public class Bitmap extends AbstractElement
{
    private String image;
    private ClarionObject data;

    public Bitmap(AbstractControl control,int x1,int y1,int x2,int y2,String image,ClarionObject data)
    {
        super(control,x1,y1,x2,y2,true);
        this.image=image;
        this.data=data;
    }

    private Image i =null;
    
    @Override
    public void paint(Page r,PrintContext g) 
    {
        int x1=r.scaleX(this.x1,false);
        int y1=r.scaleY(this.y1,false);
        int x2=r.scaleX(this.x2,true);
        int y2=r.scaleY(this.y2,true);
        if (image!=null) {
        	g.drawImage(CWin.getInstance().getImage(image,0,0),x1,y1,x2-x1,y2-y1);
        } else {
        	if (i==null) {
        		i=CWin.getInstance().getImageFromBinaryData(data);
        	}
        	g.drawImage(i,x1,y1,x2-x1,y2-y1);
        }
    }

	@Override
	public Object[] getMetaData() {
		return new Object[] { x1,y1,x2,y2,image,data }; 
	}

	public Bitmap(Object[] o ) {
		super(o);
		image=(String)o[4];
		data=(ClarionObject)o[5];
		
	}
	
}
