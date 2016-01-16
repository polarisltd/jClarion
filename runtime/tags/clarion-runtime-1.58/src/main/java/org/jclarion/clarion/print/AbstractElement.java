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

import java.awt.Rectangle;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.control.AbstractControl;

public abstract class AbstractElement implements PrintElement
{
    protected AbstractControl control;
    protected ReportStatistic aggregate;
    protected int x1,y1,x2,y2;
    
    public AbstractElement(AbstractControl control,int x1,int y1,int x2,int y2,boolean normalize)
    {
        this.control=control;
        if (normalize) {
            if (x1>x2) {
                int temp=x1;
                x1=x2;
                x2=temp;
            }
            if (y1>y2) {
                int temp=y1;
                y1=y2;
                y2=temp;
            }
        } else {
            if (x1>x2 && y1>y2) {
                int temp;
                
                temp=x1;
                x1=x2;
                x2=temp;

                temp=y1;
                y1=y2;
                y2=temp;
            }
        }

        this.x1=x1;
        this.y1=y1;
        this.x2=x2;
        this.y2=y2;
    }

    
    @Override
    public Rectangle getPreferredDimensions(Page r,PrintContext c) {
        
        int x,w,y,h;
        
        x=x1;
        y=y1;
        
        w=x2-x1;
        h=y2-y1;
        
        if (w<0) {
            w=-w;
            x=x-w;
        }
        
        if (h<0) {
            h=-h;
            y=y-h;
        }
        
        return new Rectangle(x,y,w,h);
    }


    @Override
    public void update(Page page) 
    {
        // TODO Auto-generated method stub
    }


    @Override
    public boolean contains(ClarionObject object) {
        if (control!=null) {
            if (control.getUseObject()==object) return true;
        }
        return false;
    }


    public ReportStatistic getAggregate() {
        return aggregate;
    }


    public void setAggregate(ReportStatistic aggregate) {
        this.aggregate = aggregate;
    }


    @Override
    public boolean isResize() {
        return true;
        /*
        if (control==null) return false;
        return control.isProperty(Prop.RESIZE);
        */
    }
    
    
}
