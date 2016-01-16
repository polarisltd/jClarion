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

import java.awt.Dimension;
import java.awt.Rectangle;
import java.awt.print.PageFormat;
import java.util.ArrayList;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractReportControl;

/**
 * Model a clarion report page
 * 
 * @author barney
 */

public class Page 
{
    private double xscale;  // adjustors to convert from clarion size to /72th of an inch
    private double yscale;  // adjustors to convert from clarion size to /72th of an inch
    private int x;
    private int y;
    private int width;
    private int height;
    private PageFormat format;
    
    private boolean deleted;

    
    //private OpenReport report;
    private List<PrintObject> objects=new ArrayList<PrintObject>();
    private int moveableCount=0;
    private int orientation;
    public Page(OpenReport report)
    {
        this(report,PageFormat.PORTRAIT);
    }
    
    public Page(OpenReport report,int orientation)
    {
        format=report.getPageFormat();
        xscale=report.getXScale();
        yscale=report.getYScale();
        x=report.getX();
        y=report.getY();
        width=report.getWidth();
        height=report.getHeight();
        
        //this.report=report;
        this.orientation=orientation;
    }
    
    /**
     * Return graphics size, in /72ths of an inch
     * @return
     */
    public Dimension getGraphicsSize()
    {
        return new Dimension((int)format.getWidth(),(int)format.getHeight());
    }
    
    public int scaleX(int x,boolean up)
    {
        if (xscale==1) return x;
        if (up) {
            return (int)Math.ceil(x*xscale);
        } else {
            return (int)(x*xscale);
        }
    }

    public int scaleY(int y,boolean up)
    {
        if (yscale==1) return y;
        if (up) {
            return (int)Math.ceil(y*yscale);
        } else {
            return (int)(y*yscale);
        }
    }

    public int descaleX(int x,boolean up)
    {
        if (xscale==1) return x;
        if (up) {
            return (int)Math.ceil(x/xscale);
        } else {
            return (int)(x/xscale);
        }
    }

    public int descaleY(int y,boolean up)
    {
        if (yscale==1) return y;
        if (up) {
            return (int)Math.ceil(y/yscale);
        } else {
            return (int)(y/yscale);
        }
    }

    private int getX() {
        return x;
    }

    private int getY() {
        return y;
    }

    private int getWidth() {
        return width;
    }

    private int getHeight() {
        return height;
    }
    
    public PageFormat getPageFormat()
    {
        return format;
    }

    public int getOrientation()
    {
        return orientation;
    }

    public boolean layout(PrintContext report,PrintObject object)
    {
        if (object.getControl().isProperty(Prop.ABSOLUTE)) {
            object.setMoveable(false);
            add(report,object);
            return true;
        }
        
        Rectangle new_o = object.getSize(this,report);
        
        PrintObject last = getLastMoveable();
        
        if (last!=null) {
            Rectangle last_o = last.getSize(this,report);

            // try to fit it to the left first
            if (last.getPositionedX()+last_o.x+last_o.width+new_o.x+new_o.width-getX()<=getWidth()) 
            {
                object.setPosition(last.getPositionedX()+last_o.x+last_o.width,last.getPositionedY());
                add(report,object);
                return true;
            }
            
            // try to fit it to the bottom next
            if (last.getPositionedY()+last_o.y+last_o.height+new_o.y+new_o.height-getY()<=getHeight()) 
            {
                object.setPosition(getX(),last.getPositionedY()+last_o.y+last_o.height);
                add(report,object);
                return true;
            }
            
        } else {
            object.setPosition(getX(),getY());
            add(report,object);
            return true;
        }
        
        
        return false;
    }
    
    public void add(PrintContext report,PrintObject object)
    {
        object.getSize(this,report);
        objects.add(object);
        if (object.isMoveable()) moveableCount++;
    }
    
    public int getMoveableCount()
    {
        return moveableCount;
    }
    
    public int getCount()
    {
        return objects.size();
    }

    public PrintObject[] getMoveableObjects()
    {
        PrintObject[] result = new PrintObject[moveableCount];
        int scan=0;
        for (PrintObject po : objects ) {
            if (po.isMoveable()) result[scan++]=po;
        }
        return result;
    }
    
    public Iterable<PrintObject> getPrintObjects()
    {
        return objects;
    }
    
    public PrintObject getPrintObject(int offset)
    {
        return objects.get(offset); 
    }
 
    public void removeLastMoveable()
    {
        int scan = objects.size()-1;
        while (scan>-1 && !objects.get(scan).isMoveable()) {
            scan--;
        }
        if (scan>-1) {
            objects.remove(scan);
            moveableCount--;
        }
    }
    
    public PrintObject getLastMoveable()
    {
        int scan = objects.size()-1;
        while (scan>-1) {
            PrintObject object =  objects.get(scan);
            if (object.isMoveable()) return object;
            scan--;
        }
        return null;
    }

    public void print(PrintContext graphics) 
    {
        Map<AbstractReportControl,Object> absoluteTypes = new IdentityHashMap<AbstractReportControl, Object>();
        
        graphics.start();
        for (PrintObject po : objects ) {

            if (!po.isMoveable()) {
                if (absoluteTypes.containsKey(po.getControl())) continue;
                absoluteTypes.put(po.getControl(),null);
            }
            
            graphics.translate(
                    scaleX(po.getPositionedX(),false),
                    scaleY(po.getPositionedY(),false)
            );
            po.paint(this,graphics);
            graphics.restoreTranslation();
        }
        graphics.complete();
    }
    
    
    private int page;

    public void setPageNo(int page)
    {
        this.page=page;
    }
    
    public int getPageNo()
    {
        return page;
    }
    
    public void update() 
    {
        for ( PrintObject po : objects ) {
            po.update(this);
        }
    }

    public boolean isDeleted()
    {
        return deleted;
    }
    
    public void delete()
    {
        deleted=true;
    }

    private PageBook book;
    
    private Page us()
    {
        return this;
    }
    
    public PageBook getBook() {
        if (book==null) {
            book=new PageBook() {

                @Override
                public Page getPage(int page) {
                    if (page!=0) return null;
                    return us(); 
                }

                @Override
                public int getPageCount() {
                    return 1;
                }
           };
        }
        return book;
    }
}
