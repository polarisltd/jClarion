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
import java.util.ArrayList;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.MediaSize;
import javax.print.attribute.standard.MediaSizeName;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Paper;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propprint;
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
    private boolean deleted;
    private int reNumber=-1;

    
    //private OpenReport report;
    private List<PrintObject> objects=new ArrayList<PrintObject>();
    private int moveableCount=0;
    
    private int landscape=0;
    private int paper=Paper.A4;
    private String media=null;
    private int paperWidth=0;
    private int paperHeight=0;
	private OpenReport report;
    
    public Page(OpenReport report)
    {
        xscale=report.getXScale();
        yscale=report.getYScale();
        x=report.getX();
        y=report.getY();
        width=report.getWidth();
        height=report.getHeight();
    	ClarionReport cr = report.getReport();
        if (cr!=null) {
        	landscape    = cr.getProperty(Prop.LANDSCAPE).intValue();        
        	
        	ClarionObject rawpaper = cr.getRawProperty(Propprint.PAPER,false);
        	if (rawpaper!=null) {
        		if (rawpaper instanceof ClarionString) {
        			paper=-1;
        			media=rawpaper.toString().trim();
        		} else {
        			paper=rawpaper.intValue();
        		}
        	}
        	paperWidth 	= cr.getProperty(Propprint.PAPERWIDTH).intValue();
        	paperHeight = cr.getProperty(Propprint.PAPERHEIGHT).intValue();
        }
        this.report=report;
    }
    
    public OpenReport getReport()
    {
    	return report;
    }
    
    public Page(int x, int y, int width, int height, double xs, double ys,
			int landscape,int paper,int paperWidth,int paperHeight,String media) {
    	this.x=x;
    	this.y=y;
    	this.width=width;
    	this.height=height;
    	this.xscale=xs;
    	this.yscale=ys;
    	this.landscape=landscape;
    	this.paper=paper;
    	this.paperWidth=paperWidth;
    	this.paperHeight=paperHeight;
    	this.media=media;
	}

	public void setReNumber(int renumber) {
    	this.reNumber=renumber;
    }
    
    public int getReNumber()
    {
    	return this.reNumber;
    }
    
    
    
    public void setScale(float x,float y)
    {
        xscale=x;
        yscale=y;
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

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int getWidth() {
        return width;
    }

    public int getHeight() {
        return height;
    }
    
    public double getXScale() {
        return xscale;
    }

    public double getYScale() {
        return yscale;
    }

    public int getLandscape()
    {
        return landscape;
    }
    
    public int getPaper()
    {
    	return paper;
    }
    
    public String getMedia()
    {
    	return media;
    }
    
    public int getPaperWidth()
    {
    	return paperWidth;
    }
    
    public int getPaperHeight()
    {
    	return paperHeight;
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

	public Dimension getGraphicsSize() 
	{
		switch(page) {
			case Paper.USER:
				return new Dimension(
						(int)(getPaperWidth()/getXScale()*72),
								(int)(getPaperHeight()/getYScale()*72)
					);
			default:
				MediaSize ms = MediaSize.getMediaSizeForName(MediaSizeName.ISO_A4);
				if (getLandscape()>0) {
					return new Dimension(
							(int)(ms.getY(MediaSize.INCH)*72),
							(int)(ms.getX(MediaSize.INCH)*72)
							);
				} else {
					return new Dimension(
							(int)(ms.getX(MediaSize.INCH)*72),
							(int)(ms.getY(MediaSize.INCH)*72)
					);					
				}
		}
	}
}
