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
import java.awt.Font;
import java.awt.Image;
import java.awt.Point;
import java.awt.Rectangle;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractReportControl;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.runtime.format.Formatter;

public class PrintObject 
{
    private int positionedX;
    private int positionedY;
    
    private int x;
    private int y;
    private int width;
    private int height;
    
    private boolean moveable=true;
    
    private List<PrintElement> components=new ArrayList<PrintElement>();
    
    private AbstractReportControl control;
    
    public PrintObject()
    {
    }
    
    public PrintObject(AbstractReportControl detail, OpenReport report,CWinImpl impl) {
        setControl(report,impl,detail);
    }

    public PrintObject(AbstractReportControl detail, OpenReport report,CWinImpl impl,boolean mo) {
        setControl(report,impl,detail);
        setMoveable(mo);
    }

    public PrintObject(int x,int y,int w,int h,int px,int py) {
    	this.x=x;
    	this.y=y;
    	this.width=w;
    	this.height=h;
    	this.positionedX=px;
    	this.positionedY=py;
	}

	private Map<ClarionObject,ClarionObject> fieldValues = new IdentityHashMap<ClarionObject, ClarionObject>();
    
    public ClarionObject getFieldValue(ClarionObject field)
    {
        return fieldValues.get(field); 
    }
    
    public void setControl(OpenReport report,CWinImpl impl,AbstractReportControl control)
    {
        this.control=control;
        
        x=control.getProperty(Prop.XPOS).intValue();
        y=control.getProperty(Prop.YPOS).intValue();

        ClarionObject raw_width = control.getRawProperty(Prop.WIDTH);
        if (raw_width!=null) {
            width=raw_width.intValue();
        } else {
            width=report.getWidth();
        }
        height=control.getProperty(Prop.HEIGHT).intValue();

        for (AbstractControl ac : control.getChildren() ) {
            if (ac.getUseObject()!=null) {
                if (report.isAggregatingField(ac.getUseObject())) {
                    ClarionObject co = ac.getUseObject();
                    fieldValues.put(co,co.genericLike());
                }
            }
            
            draw(report,impl,ac);
        }
    }
    
    public AbstractReportControl getControl()
    {
        return control;
    }
    
    public void setPosition(int x,int y)
    {
        positionedX=x;
        positionedY=y;
    }
    
    
    public void setAt(int x,int y,int width,int height)
    {
        this.x=x;
        this.y=y;
        this.width=width;
        this.height=height;
    }
    
    public int getX() {
        return x;
    }
    public void setX(int x) {
        this.x = x;
    }
    public int getY() {
        return y;
    }
    public void setY(int y) {
        this.y = y;
    }
    public int getWidth() {
        return width;
    }
    public void setWidth(int width) {
        this.width = width;
    }
    public int getHeight() {
        return height;
    }
    public void setHeight(int height) {
        this.height = height;
    }

    public void add(PrintElement object) 
    {
        components.add(object);
    }

    public PrintElement getElement(int indx)
    {
        return components.get(indx);
    }

    public Iterable<PrintElement> getElements()
    {
    	return components;
    }
    
    public void update(Page page)
    {
        for ( PrintElement pe : components ) {
            pe.update(page);
        }
    }
    
    public void draw(OpenReport report,CWinImpl impl,AbstractControl ac) 
    {
        if (ac instanceof GroupControl) {
            if (ac.isProperty(Prop.HIDE)) return;
            for (AbstractControl gc : ac.getChildren() ) {
                draw(report,impl,gc);
            }
            return;
        }
            
        int x1 = ac.getProperty(Prop.XPOS).intValue();
        int y1 = ac.getProperty(Prop.YPOS).intValue();
        int x2 = x1+ac.getProperty(Prop.WIDTH).intValue();
        int y2 = y1+ac.getProperty(Prop.HEIGHT).intValue();
        
        if (ac instanceof LineControl) {
            int width = ac.getProperty(Prop.LINEWIDTH).intValue();
            Color c = impl.getColor(ac,Prop.COLOR);
            if (c==null) c = Color.black;
            drawLine(ac,x1,y1,x2,y2,width,c);
            return;
        }
        
        if (ac instanceof BoxControl) {
            int width = ac.getProperty(Prop.LINEWIDTH).intValue();
            Color f = impl.getColor(ac,Prop.COLOR);
            Color b = impl.getColor(ac,Prop.FILL);
            boolean round = ac.isProperty(Prop.ROUND);
            drawBox(ac,x1,y1,x2,y2,width,f,b,round);
            return;
        }
        
        if (ac instanceof StringControl) {
            Color c = impl.getColor(ac,Prop.FONTCOLOR);
            Font f = impl.getFontOnly(null,ac,10.0);
            boolean trans = ac.isProperty(Prop.TRN);
        
            String text;
            String unformat;
            Text.Justify justify=Text.Justify.LEFT;
            int justifyOffset=0;
            
            ReportStatistic rs=null;
            
            if (ac.getUseObject()==null) {
                text=ac.getProperty(Prop.TEXT).toString().trim();
                unformat=text;
            } else {
                rs = report.getStatistic((StringControl)ac);
                Formatter format = ac.getPicture();
                if (rs==null) {
                    text = ac.getUseObject().toString().trim();
                } else {
                    text = rs.get().toString().trim();
                }
                unformat=text;
                text=format.format(text).trim();
            }

            if (ac.isProperty(Prop.LEFT)) {
                justifyOffset=ac.getProperty(Prop.LEFTOFFSET).intValue();
            }

            if (ac.isProperty(Prop.RIGHT)) {
                justify=Text.Justify.RIGHT;
                justifyOffset=ac.getProperty(Prop.RIGHTOFFSET).intValue();
            }

            if (ac.isProperty(Prop.DECIMAL)) {
                justify=Text.Justify.DECIMAL;
                justifyOffset=ac.getProperty(Prop.DECIMALOFFSET).intValue();
            }

            if (ac.isProperty(Prop.CENTER)) {
                justify=Text.Justify.CENTER;
                justifyOffset=ac.getProperty(Prop.CENTEROFFSET).intValue();
            }
            
            Text t= drawText(ac,unformat,text,x1,y1,x2,y2,justify,justifyOffset,c,f,trans);
            if (rs!=null) t.setAggregate(rs);
            return;
        }

        if (ac instanceof TextControl) {
            Color c = impl.getNestedColor(ac,Prop.FONTCOLOR);
            Font f = impl.getFontOnly(null,ac,10.0);

            String text;
            String unformat;
            if (ac.getUseObject()==null) {
                text=ac.getProperty(Prop.TEXT).toString().trim();
                unformat=text;
            } else {
                Formatter format = ac.getPicture();
                text = ac.getUseObject().toString().trim();
                unformat=text;
                if (format!=null) {
                	text=format.format(text).trim();
                }
            }
            
            drawTextArea(ac,unformat,text,x1,y1,x2,y2,c,f,ac.isProperty(Prop.RESIZE));
            return;
        }
        
        if (ac instanceof ImageControl) {
            drawImage(ac,x1,y1,x2,y2);
            return;
        }
          
        
        throw new IllegalArgumentException("Do not know how to print:"+ac);
    }
    
    public void drawLine(AbstractControl control,int x1,int y1,int x2,int y2,int width,Color color)
    {
        add(new Line(control,x1,y1,x2,y2,width,color));
    }
    
    public void drawBox(AbstractControl control,int x1,int y1,int x2,int y2,int width,Color fg,Color bg,boolean round)
    {
        add(new Box(control,x1,y1,x2,y2,width,fg,bg,round));
    }

    public void drawImage(AbstractControl control,int x1,int y1,int x2,int y2)
    {
        Image i = null;
        String name = control.getProperty(Prop.TEXT).toString().trim();
        if (name.length()>0) {
            add(new Bitmap(control,x1,y1,x2,y2,name,null));
        } else {
            add(new Bitmap(control,x1,y1,x2,y2,null,control.getRawProperty(Prop.IMAGEBITS)));
        }
        if (i!=null) {
        }
    }

    public Text drawText(AbstractControl control,String unformat,String text,int x1,int y1,int x2,int y2,
            Text.Justify justify,int justifyOffset,
            Color color,Font font,boolean transparent)
    {
        Text t=new Text(control,unformat,text,x1,y1,x2,y2,justify,justifyOffset,color,font,transparent);
        add(t);
        return t;
    }

    public void drawTextArea(AbstractControl control,String unformat,String text,int x1,int y1,int x2,int y2,Color color,Font font,boolean resize)
    {
        add(new TextArea(control,unformat,text,x1,y1,x2,y2,color,font,resize));
    }
    
    public Rectangle getSize(Page report,PrintContext graphics)
    {
        //graphics.start();
        
        // resize as necessary
        for ( PrintElement e : components ) {
            Rectangle r = e.getPreferredDimensions(report,graphics);

            if (e.isResize()) {
                if (r.x+r.width>this.width) {
                    this.width=r.x+r.width;
                }
                if (r.y+r.height>this.height) {
                    this.height=r.y+r.height;
                }
            }
        }

        //graphics.complete();
     
        return new Rectangle(x,y,width,height);
    }
    
    public void paint(Page report,PrintContext graphics)
    {
        graphics.translate(report.scaleX(x,false),report.scaleY(y,false));
        graphics.clip(0,0,report.scaleX(width,true),report.scaleY(height,true));

        for ( PrintElement e : components ) {
            e.paint(report,graphics);
        }

        graphics.restoreClip();
        graphics.restoreTranslation();
    }

    public void setMoveable(boolean mo)
    {
        moveable=mo;
    }
    
    public boolean isMoveable() {
        return moveable;
    }

    public int getPositionedX() {
        return positionedX;
    }

    public int getPositionedY() {
        return positionedY;
    }

    public Point getPosition() {
        return new Point(positionedX,positionedY);
    }
    
    public void setPosition(Point p)
    {
        setPosition(p.x,p.y);
    }
    
    public boolean contains(ClarionObject object)
    {
        for ( PrintElement e : components ) {
            if (e.contains(object)) return true;
        }
        return false;
    }
    
    public String toString()
    {
        StringBuilder sb=  new StringBuilder("PrintObject[");
        sb.append("X:").append(x);
        sb.append(" Y:").append(y);
        sb.append(" W:").append(width);
        sb.append(" H:").append(height);
        sb.append(" PX:").append(positionedX);
        sb.append(" PY:").append(positionedY);
        sb.append("]");
        return sb.toString();
    }
}
