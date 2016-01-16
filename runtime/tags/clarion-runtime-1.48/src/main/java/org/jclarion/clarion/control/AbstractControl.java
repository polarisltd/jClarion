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
package org.jclarion.clarion.control;

import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FocusTraversalPolicy;
import java.awt.Insets;
import java.awt.Point;
import java.awt.Window;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.swing.Icon;
import javax.swing.JComponent;
import javax.swing.JInternalFrame;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.runtime.format.Formatter;
import org.jclarion.clarion.swing.AWTPropertyGetter;
import org.jclarion.clarion.swing.AbstractAWTPropertyGetter;
import org.jclarion.clarion.swing.ClarionFocusTraversalPolicy;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.constants.*;

public abstract class AbstractControl extends PropertyObject implements AbstractAWTPropertyGetter
{
    private int useID;
    private ClarionObject useObject;
    private AbstractTarget owner;
    private AbstractControl parent;

    public abstract int getCreateType();
    
    public boolean containsUse(ClarionObject use)
    {
        if (this.useObject==use) return true;
        for ( AbstractControl ac : getChildren() ) {
            if (ac.containsUse(use)) return true;
        }
        return false;
    }
    
    public AbstractTarget getOwner()
    {
        if (owner!=null) return owner;
        if (parent!=null) {
            owner=parent.getOwner();
        }
        return owner;
    }
    
    public final AbstractWindowTarget getWindowOwner()
    {
        return (AbstractWindowTarget)getOwner();
    }
    
    public void setOwner(AbstractTarget target)
    {
         this.owner=target;
    }

    public void addChild(AbstractControl control)
    {
        throw new RuntimeException("Not supported");
    }

    public void removeChild(AbstractControl control)
    {
        throw new RuntimeException("Not supported");
    }
    
    public AbstractControl getParent()
    {
        return parent;
    }
    
    private static Collection<AbstractControl> noChildren=new ArrayList<AbstractControl>();
    
    public Collection<? extends AbstractControl> getChildren()
    {
        return noChildren;
    }
    
    public AbstractControl getChild(int index)
    {
        Iterator<? extends AbstractControl> control = getChildren().iterator();
        while (control.hasNext() && index>0) {
            if (control.hasNext()) {
                control.next();
            } else {
                return null;
            }
            index--;
        }
        if (control.hasNext()) return control.next();
        return null;
    }

    public int getChildIndex(AbstractControl control)
    {
        int count=0;
        for (AbstractControl test : getChildren()) {
            if (test==control) return count;
            count++;
        }
        return -1;
    }

    public void setParent(AbstractControl parent)
    {
        this.parent=parent;
    }
    
    public void setUseID(int id)
    {
        useID=id;
    }
    
    public int getUseID()
    {
        if (useID==0) return getOwner().register(this);
        return useID;
    }
    
    
    public AbstractControl setText(String text)
    {
        setProperty(Prop.TEXT,text);
        return this;
    }
    
    public AbstractControl setPicture(String picture)
    {
        setProperty(Prop.TEXT,picture);
        return this;
    }
    
    private Formatter picture;
    
    public Formatter getPicture()
    {
        if (picture!=null) return picture;
        if (useObject==null) return null;
        ClarionObject picture = getRawProperty(Prop.TEXT);
        if (picture==null) return null;
        this.picture=Formatter.construct(picture.toString());
        if (this.picture!=null) {
            initPicture(this.picture);
        }
        return this.picture;
    }
    
    protected void initPicture(Formatter formatter)
    {
    }

    public AbstractControl setCenter()
    {
        setProperty(Prop.CENTER,true);
        setProperty(Prop.CENTEROFFSET,0);
        return this;
    }

    public AbstractControl setAlrt(int keycode)
    {
        setProperty(Prop.ALRT,255,keycode);
        return this;
    }

    public AbstractControl setBoxed()
    {
        setProperty(Prop.BOXED,true);
        return this;
    }

    public AbstractControl setTransparent()
    {
        setProperty(Prop.TRN,true);
        return this;
    }

    public AbstractControl setBevel(Integer b1,Integer b2,Integer b3)
    {
        if (b1!=null) setProperty(Prop.BEVELOUTER,b1);
        if (b2!=null) setProperty(Prop.BEVELINNER,b2);
        if (b3!=null) setProperty(Prop.BEVELSTYLE,b3);
        return this;
    }

    public AbstractControl setStandard(int std)
    {
        setProperty(Prop.STD,std);
        return this;
    }

    public AbstractControl setLeft(Integer i)
    {
        setProperty(Prop.LEFT,true);
        setProperty(Prop.LEFTOFFSET,i);
        return this;
    }

    public AbstractControl setRight(Integer i)
    {
        setProperty(Prop.RIGHT,true);
        setProperty(Prop.RIGHTOFFSET,i);
        return this;
    }

    public AbstractControl setDecimal(Integer i)
    {
        setProperty(Prop.DECIMAL,true);
        setProperty(Prop.DECIMALOFFSET,i);
        return this;
    }
    
    public AbstractControl setAt(Integer x,Integer y,Integer width,Integer height)
    {
        setProperty(Prop.XPOS,x);
        setProperty(Prop.YPOS,y);
        setProperty(Prop.WIDTH,width);
        setProperty(Prop.HEIGHT,height);
        return this;
    }
    
    public AbstractControl setFont(String typeface,Integer size,Integer color,Integer style,Integer charset)
    {
        setProperty(Prop.FONTNAME,typeface);
        setProperty(Prop.FONTSIZE,size);
        setProperty(Prop.FONTCOLOR,color);
        setProperty(Prop.FONTSTYLE,style);
        setProperty(Prop.FONTCHARSET,charset);
        return this;
    }
    
    public AbstractControl setColor(Integer color,Integer fore,Integer back) {
        setProperty(Prop.FILLCOLOR,color);
        setProperty(Prop.SELECTEDCOLOR,fore);
        setProperty(Prop.SELECTEDFILLCOLOR,back);
        return this;
    }
    
    public AbstractControl setHidden()
    {
        setProperty(Prop.HIDE,true);
        return this;
    }

    public AbstractControl setDisabled()
    {
        setProperty(Prop.DISABLE,true);
        return this;
    }

    public AbstractControl setSkip()
    {
        setProperty(Prop.SKIP,true);
        return this;
    }

    public AbstractControl setImmediate()
    {
        setProperty(Prop.IMM,true);
        return this;
    }

    public AbstractControl setTip(String tip)
    {
        setProperty(Prop.TIP,tip);
        return this;
    }

    public AbstractControl setHelp(String help)
    {
        setProperty(Prop.HLP,help);
        return this;
    }

    public AbstractControl setMsg(String help)
    {
        setProperty(Prop.MSG,help);
        return this;
    }

    public AbstractControl use(ClarionObject object)
    {
        setProperty(Prop.USE,object);
        return this;
    }
    
    public ClarionObject getUseObject()
    {
        return useObject;
    }
    
    public void update()
    {
    }

    public int getKey() {
        return 0;
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        if (parent!=null) return parent;
        if (owner!=null) return owner;
        return null;
    }
    
    @Override
    protected boolean canNotifyLocalChange(int indx)
    {
        return getComponent()!=null || (getOwner()!=null && !(getOwner() instanceof ClarionReport)) || indx==Prop.USE;
    }
    

    protected void notifyLocalChange(final int indx,final ClarionObject value) 
    {
        boolean awtChange=false;
        switch(indx) {
            case Prop.TEXT:
                picture=null;
                return;
            case Prop.USE:
                useObject=(ClarionObject)value.getLockedObject(Thread.currentThread());
                return;
            case Prop.HIDE:
                if (constructOnUnhide && indx==Prop.HIDE && !value.boolValue() && getOwner() instanceof AbstractWindowTarget) 
                {
                    AbstractWindowTarget awt = getWindowOwner();
                    awt.noteFullRepaint();
                }
            case Prop.DISABLE:
            case Prop.HEIGHT:
            case Prop.WIDTH:
            case Prop.XPOS:
            case Prop.YPOS:
            case Prop.FONTNAME:
            case Prop.FONTSIZE:
            case Prop.FONTSTYLE:
                awtChange=true;
                break;
        }
        
        if (!awtChange) return;

        Runnable r = new Runnable()
        {
            public void run()
            {
                Insets i;

                if (constructOnUnhide && indx==Prop.HIDE && !value.boolValue() && getOwner() instanceof AbstractWindowTarget) 
                {
                    AbstractWindowTarget awt = getWindowOwner();
                    if (awt.getContentPane()!=null) {
                        constructOnUnhide=false;
                        //awt.noteFullRepaint();
                        constructSwingComponent(awt.getContentPane());
                        if (getUs() instanceof TabControl) {
                            getParent().getComponent().validate();
                        }
                    }
                }

                Component c = getComponent();
                AbstractWindowTarget t = getWindowOwner();
                
                if (c!=null && t!=null && value!=null) {
                    switch (indx) {
                        case Prop.HIDE:
                            toggleMode(!value.boolValue() ? getMode(Prop.HIDE) : false, Prop.HIDE,true);
                            return;
                        case Prop.DISABLE:
                            toggleMode(!value.boolValue() ? getMode(Prop.DISABLE) : false, Prop.DISABLE,true);
                            return;
                        case Prop.HEIGHT:
                            i=getControlAdjustInsets();
                            c.setSize(c.getWidth(),
                                t.heightDialogToPixels(
                                value.intValue())
                                +(i==null?0:i.top+i.bottom));
                            validateIfNecessary(c);
                            return;
                        case Prop.WIDTH:
                            i=getControlAdjustInsets();
                            c.setSize(t.widthDialogToPixels(value.intValue())
                                , c.getHeight()
                                +(i==null?0:i.left+i.right));
                            validateIfNecessary(c);
                            return;
                        case Prop.XPOS: {
                            i=getControlAdjustInsets();
                            int x = value.intValue();
                            x = t.widthDialogToPixels(x);
                            c.setLocation(x-(i==null?0:i.left), c.getY()); 
                            return;
                        }
                        case Prop.YPOS: {
                            i=getControlAdjustInsets();
                            int y = value.intValue();
                            y = t.heightDialogToPixels(y);
                            c.setLocation(c.getX(), y-(i==null?0:i.top));
                            return;
                        }
                    }
                }
                
                if (fontComponents!=null && fontComponents.size()>0) {
                    switch(indx) {
                        case Prop.FONTNAME:
                        case Prop.FONTSIZE:
                        case Prop.FONTSTYLE: {
                            for (Component fc : fontComponents ) {
                                changeFont(fc);
                            }
                        }
                    }
                }
            }
        };
        CWinImpl.run(r);
    }
    
    private void validateIfNecessary(Component c) {
        if (c instanceof Container && ((Container)c).getComponentCount()>0) {
            c.validate();
        }
    }

    private Set<Integer>    alerts;
    private boolean         mouseAlerts;

    public boolean isAlertKey(int key)
    {
        if (alerts==null) return false;
        return alerts.contains(key);
    }
    
    public boolean isMouseAlert()
    {
        return mouseAlerts;
    }
    
    @Override
    public void setProperty(ClarionObject key, ClarionObject index,ClarionObject value) 
    {
        if (key.intValue()==Prop.ALRT) {
            if (alerts==null) alerts= new HashSet<Integer>();
            int ivalue=value.intValue();
            alerts.add(ivalue);
            switch(ivalue) {
                case Constants.MOUSELEFT:
                case Constants.MOUSECENTER:
                case Constants.MOUSERIGHT:
                case Constants.MOUSELEFT2:
                case Constants.MOUSECENTER2:
                case Constants.MOUSERIGHT2:
                    mouseAlerts=true;
            }
            // wake up any property listeners
            setProperty(Prop.ALRT,true); 
            return;
        }
        
        super.setProperty(key, index, value);
    }

    
    
    @Override
    public ClarionObject getProperty(ClarionObject key, ClarionObject index) {

        int ikey=key.intValue();

        if (ikey==Prop.CHILDINDEX) {
            AbstractControl child = getOwner().getControl(index.intValue());
            if (child==null) return new ClarionNumber(0);
            if (child.getParent()!=this) return new ClarionNumber(0);
            return new ClarionNumber(this.getChildIndex(child)+1);
        }
        
        if (ikey==Prop.CHILD) {
            int iindex=index.intValue();
            if (iindex<1) return new ClarionNumber(0); 
            AbstractControl child = getChild(iindex-1);
            if (child==null) return new ClarionNumber(0);
            return new ClarionNumber(child.getUseID());
        }
        return super.getProperty(key, index);
    }

    public abstract boolean validateInput();
    
    public abstract boolean isAcceptAllControl();

    @Override
    public ClarionObject getAWTProperty(int index)
    {
        Component c=  getComponent();
        if (c==null) return null;

        Insets i;

        switch (index) {

            case Prop.HEIGHT:
                i = getControlAdjustInsets();
                return new ClarionNumber(getWindowOwner().heightPixelsToDialog(
                    c.getHeight() - (i == null ? 0 : i.top + i.bottom)));
            case Prop.WIDTH:
                i = getControlAdjustInsets();
                return new ClarionNumber(getWindowOwner().widthPixelsToDialog(
                    c.getWidth())
                    - (i == null ? 0 : i.left + i.right));
            case Prop.XPOS: {
                if (getRawProperty(Prop.XPOS, false) != null)
                    return null;

                i = getControlAdjustInsets();
                int x = c.getX();
                return new ClarionNumber(getWindowOwner().widthPixelsToDialog(
                    x + (i == null ? 0 : i.left)));
            }
            case Prop.YPOS: {
                if (getRawProperty(Prop.XPOS, false) != null)
                    return null;

                i = getControlAdjustInsets();
                int y = c.getY();
                return new ClarionNumber(getWindowOwner().heightPixelsToDialog(
                    y + (i == null ? 0 : i.top)));
            }
        }
        
        return null;
    }
    
    public boolean isAWTProperty(int index)
    {
        switch(index) {
            case Prop.HEIGHT: 
            case Prop.WIDTH: 
            case Prop.XPOS: 
            case Prop.YPOS:
                return true;
        }
        return false;
    }

    @Override
    public ClarionObject getLocalProperty(int index) {
        
        switch(index) {
            case Prop.PARENT:   
                if (getParent()!=null) return new ClarionNumber(getParent().getUseID());
                return new ClarionNumber(0);
            case Prop.TYPE:
                return new ClarionNumber(getCreateType());
            case Prop.VISIBLE: {
                ControlIterator ci = new ControlIterator(this, true);
                ci.setScanDisabled(true);
                return new ClarionBool(ci.isAllowed(this));
            }

            case Prop.ENABLED: {
                ControlIterator ci = new ControlIterator(this, true);
                ci.setScanDisabled(false);
                ci.setScanHidden(false);
                ci.setScanSheets(true);
                return new ClarionBool(ci.isAllowed(this));
            }
        }

        if (isAWTProperty(index)) return AWTPropertyGetter.getInstance().get(index,this); 
        
        return super.getLocalProperty(index);
    }

    private List<Component>     fontComponents;
    private boolean             mouseAlertsEnabled;
    private boolean             constructOnUnhide;

    @Override
    public void clearMetaData() 
    {
        fontComponents=null;
        mouseAlertsEnabled=false;
        constructOnUnhide=false;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) 
    {
        debugMetaData(sb,"fontComponents",null);
        debugMetaData(sb,"mouseAlerrsEnabled",null);
        debugMetaData(sb,"constructOnUngide",null);
    }
    
    public void setConstructOnUnhide()
    {
        constructOnUnhide=true;
    }
    
    public boolean canConstruct()
    {
        return !constructOnUnhide;
    }
    
    public SwingAccept getAccept()
    {
        return null; 
    }
    
    public abstract Component getComponent();
    
    
    public void constructSwingComponent(Container parent)
    {
        throw new IllegalStateException("Not Yet implemented");
    }

    public final void toggleMode(boolean value, int mode) 
    {
        toggleMode(value,mode,false);
    }

    public void toggleMode(boolean value, final int mode,final boolean refocus) 
    {
        if (value == true && mode==Prop.HIDE)  {
            ControlIterator ci = new ControlIterator(this);
            ci.setLoop(false);
            ci.setScanDisabled(true);
            ci.setScanHidden(false);
            ci.setScanSheets(false);
            if (!ci.isAllowed(this)) value=false;
        }
        
        final boolean f_value=value;
        
        CWinImpl.run(new Runnable() { 
            public void run() {
                doToggleMode(f_value,mode);
                if (refocus) {
                    Container c = getWindowOwner().getWindow();
                    if (c!=null) {
                        ClarionFocusTraversalPolicy cftp = (ClarionFocusTraversalPolicy)c.getFocusTraversalPolicy();
                        Component f=null;
                        if (c instanceof Window) {
                            f = ((Window)c).getFocusOwner();        
                        }
                        if (c instanceof JInternalFrame) {
                            f = ((JInternalFrame)c).getFocusOwner();
                        }
                        if (f==null) {
                            AbstractControl ac = getWindowOwner().getCurrentFocus();
                            if (ac!=null) f=ac.getComponent();
                            if (f==null) return;
                        }
                        if (cftp.accept(f,null)) return;
                    
                        f = cftp.getComponentAfter(c,f);
                        if (f==null) f=cftp.getFirstComponent(c);

                        if (f!=null) {
                            f.requestFocus();
                        }
                    }   
                }
            }
        });
    }
    
    public Component[] getToggleComponents()
    {
        return null;
    }

    protected void doToggleMode(boolean value, int mode) {
        if (value == true) {
            if (isProperty(mode)) value = false;
        }

        Component components[] = getToggleComponents();
        if (components!=null) {
            for (Component component: components ) {
                if (component==null) continue;
                switch (mode) {
                    case Prop.DISABLE:
                        component.setEnabled(value);
                        break;
                    case Prop.HIDE:
                        component.setVisible(value);
                        break;
                }
            }
        } else {
            Component component = getComponent();
            if (component != null) {
                switch (mode) {
                    case Prop.DISABLE:
                        component.setEnabled(value);
                        break;
                    case Prop.HIDE:
                        component.setVisible(value);
                        break;
                }
            }
        }
        
        if (value == true && mode == Prop.HIDE) {
            if (this instanceof TabControl) {
                if (this!=((SheetControl)getParent()).getSelectedTab()) {
                    value = false;
                }
            }
        }

        for (AbstractControl child : getChildren()) {
            child.doToggleMode(value, mode);
        }
    }

    public boolean getMode(int mode) {
        if (isProperty(mode)) return false;
        if (getParent()!=null) return getParent().getMode(mode);
        return true;
    }
    
    
    protected void setPositionAndState() 
    {
        ClarionObject tip = getRawProperty(Prop.TIP,false);
        if (tip!=null) {
            ((JComponent)getComponent()).setToolTipText(tip.toString());
        }
        
        
        if (isProperty(Prop.DISABLE)) {
            toggleMode(false, Prop.DISABLE);
        }
        if (isProperty(Prop.HIDE)) {
            toggleMode(false, Prop.HIDE);
        }

        
        getComponent().setSize(getPreferredSize());
        {
            Insets i = getControlAdjustInsets();
            
            ClarionObject x = getRawProperty(Prop.XPOS, false);
            ClarionObject y = getRawProperty(Prop.YPOS, false);

            if (x != null || y != null || i!=null) {

                /**
                 * AbstractControl scan = control.getParent(); if (scan!=null) {
                 * if (x!=null) { ClarionObject px =
                 * scan.getRawProperty(Prop.XPOS,false); if (px!=null) {
                 * x=x.subtract(px); } } if (y!=null) { ClarionObject py =
                 * scan.getRawProperty(Prop.YPOS,false); if (py!=null) {
                 * y=y.subtract(py); } } scan=scan.getParent(); }
                 */

                Point p = getComponent().getLocation();

                if (x != null) {
                    ClarionObject w = getRawProperty(Prop.WIDTH, false);
                    if (w != null && w.intValue() < 0)
                        x = x.add(w);
                    p.x = getWindowOwner().widthDialogToPixels(
                            x.intValue());
                }

                if (y != null) {
                    ClarionObject h = getRawProperty(Prop.HEIGHT, false);
                    if (h != null && h.intValue() < 0)
                        y = y.add(h);
                    p.y = getWindowOwner().heightDialogToPixels(
                            y.intValue());
                }
                
                if (i!=null) {
                    p.x=p.x-i.left;
                    p.y=p.y-i.top;
                }
                
                getComponent().setLocation(p);
            }

            ClarionObject w = getRawProperty(Prop.WIDTH, false);
            ClarionObject h = getRawProperty(Prop.HEIGHT, false);

            if (w != null || h != null || i != null) {
                
                Dimension p = getComponent().getSize();
                if (w != null)
                    p.width = getWindowOwner().widthDialogToPixels(
                            Math.abs(w.intValue()));
                if (h != null)
                    p.height = getWindowOwner().heightDialogToPixels(
                            Math.abs(h.intValue()));
                if (i!=null) {
                    p.width+=i.left+i.right;
                    p.height+=i.top+i.bottom;
                }
                getComponent().setSize(p);
            }
        }

        if (isProperty(Prop.FULL)) {
            
            AbstractControl parent = getParent();
            Component c;

            //final boolean window;
            
            if (parent!=null) {
                c=parent.getComponent();
                //window=false;
            } else {
                c=getWindowOwner().getContentPane();
                //window=true;
            }
            
            ComponentListener cl = new ComponentListener() {

                @Override
                public void componentHidden(ComponentEvent e) {
                }

                @Override
                public void componentMoved(ComponentEvent e) {
                    doResizeFull(e);
                }

                @Override
                public void componentResized(ComponentEvent e) {
                    doResizeFull(e);
                }

                @Override
                public void componentShown(ComponentEvent e) {
                }

                private void doResizeFull(ComponentEvent e) {

                    int width = e.getComponent().getWidth();
                    int height = e.getComponent().getHeight();

                    //int x = e.getComponent().getX();
                    //int y = e.getComponent().getY();

                    int my_x = getComponent().getX();
                    int my_y = getComponent().getY();

                    int new_width = width - my_x;
                    int new_height = height - my_y;

                    getComponent().setSize(new_width, new_height);

                }
            };

            c.addComponentListener(cl);
            cl.componentResized(new ComponentEvent(c,0));
        }
    }

    public Dimension getPreferredSize() {
        return getComponent().getPreferredSize();
    }

    public Color getColor(int property) 
    {
        return CWin.getInstance().getColor(this,property);
    }

    public Color getNestedColor(int property) 
    {
        return CWin.getInstance().getNestedColor(this,property);
    }
    
    public void configureColor(JComponent jw) 
    {
        Color c;
        c = getNestedColor(Prop.FONTCOLOR);
        if (c != null) jw.setForeground(c);
        c = getNestedColor(Prop.BACKGROUND);
        if (c != null) jw.setBackground(c);
    }
    
    public void configureFont(Component component) 
    {
        if (fontComponents==null) {
            fontComponents=new ArrayList<Component>();
        }
        fontComponents.add(component);
        
        changeFont(component);
    }

    public void changeFont(Component component)
    {
        CWin.getInstance().changeFont(component,this);
    }

    public ClarionEvent post(int event) 
    {
        ClarionEvent ce =new ClarionEvent(event, this, true); 
        getWindowOwner().post(ce);
        return ce;
    }

    public boolean postAndWait(int event) 
    {
        ClarionEvent ce = new ClarionEvent(event, this, true);
        getWindowOwner().post(ce);
        return ce.getConsumeResult();
    }
    
    
    public void clearRefocusOnEventQueue(final AbstractWindowTarget windowOwner, final Component field) 
    {
        Runnable r = new Runnable() {
            @Override
            public void run() {
                Object o = windowOwner.getRefocus();
                if (o == null) return;

                if (o == field) {
                    windowOwner.setRefocus(null);
                }
            }
        };

        CWinImpl.run(r);
    }
    
    public void configureDefaults(JComponent comp) 
    {
        configureFont(comp);
        configureColor(comp);
        setPositionAndState();
        setFocus(comp);
        setKey(comp);
    }
 
    private AbstractControl getUs()
    {
        return this;
    }
    
    public void setFocus(final JComponent comp) 
    {
        comp.putClientProperty("clarion", this);
        if (isProperty(Prop.SKIP)) {
            comp.putClientProperty("clarionSkipFocus", true);
        }

        comp.addFocusListener(new FocusListener() {

            @Override
            public void focusGained(FocusEvent e) 
            {
                AbstractWindowTarget awt = getWindowOwner();
                Component c = awt.getRefocus();

                if (c != null) {
                    Container window = awt.getWindow();
                    Component scan = c;
                    while (scan!=null) {
                        if (scan==window) break;
                        scan=scan.getParent();
                    }
                    if (scan==null) {
                        getWindowOwner().setRefocus(null);
                        c=null;
                    }
                }
                
                if (c!=null) {
                    if (!c.isEnabled() || !c.isVisible() || !c.isDisplayable()) {
                        getWindowOwner().setRefocus(null);
                        c=null;
                    }
                }

                if (c!=null) {
                    
                    
                    Container root = c.getFocusCycleRootAncestor();
                    if (root==null) {
                        getWindowOwner().setRefocus(null);
                        c=null;
                    } else {
                        FocusTraversalPolicy ftp =  
                            c.getFocusCycleRootAncestor().getFocusTraversalPolicy();
                        if (ftp!=null && ftp instanceof ClarionFocusTraversalPolicy) {
                            if (!((ClarionFocusTraversalPolicy)ftp).accept(c,null)) {
                                getWindowOwner().setRefocus(null);
                                c=null;
                            }
                        } else {
                            getWindowOwner().setRefocus(null);
                            c=null;
                        }
                    }
                }

                if (c != null) {
                    if (c == comp) {
                        getWindowOwner().setRefocus(null);
                    } else {
                        c.requestFocusInWindow();
                        return;
                    }
                }

                if (!comp.isEnabled()) return;
                
                AbstractControl cf = getWindowOwner().getCurrentFocus(); 
                
                if (cf != getUs()) {
                    getWindowOwner().setCurrentFocus(getUs());
                    post(Event.SELECTED);
                }
            }
            @Override
            public void focusLost(FocusEvent e) {
            }
        });
    }
    
    public void setKey(JComponent comp) {
        CWin.getInstance().setKey(
                getWindowOwner(),comp,this instanceof SimpleMnemonicAllowed,
                false,this);
    }

    public Icon getIcon(String name, int prefx, int prefy) {
        return CWin.getInstance().getIcon(name,prefx,prefy);
    }
    

    public void accept() 
    {
        if (getComponent()!=null) {
            getComponent().requestFocusInWindow();
            post(Event.ACCEPTED);
        }
    }
    
    public boolean isMouseAlertsEnabled()
    {
        return mouseAlertsEnabled;
    }

    public void setMouseAlertsEnabled(boolean mouseAlertsEnabled)
    {
        this.mouseAlertsEnabled=mouseAlertsEnabled;
    }
    
    public Insets getControlAdjustInsets()
    {
        return null;
    }

}
