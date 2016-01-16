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
package org.jclarion.clarion.runtime;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.logging.Logger;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileFilter;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.filechooser.FileSystemView;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionPrinter;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ControlIterator;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.file.ClarionFileFactory;
import org.jclarion.clarion.swing.ClarionEventQueue;
import org.jclarion.clarion.swing.SimpleComboQueue;

public class CWin {
    private static Logger log = Logger.getLogger(CWin.class.getName());
    
    private static CWinImpl sInstance;
    
    private static Map<Integer,String> eventStrings;
    
    static {
        eventStrings=new HashMap<Integer, String>();
        eventStrings.put(1,"Accepted");
        eventStrings.put(2,"NewSelection");
        eventStrings.put(3,"ScrollUp");
        eventStrings.put(4,"ScrollDown");
        eventStrings.put(5,"PageUp");
        eventStrings.put(6,"PageDown");
        eventStrings.put(7,"ScrollTop");
        eventStrings.put(8,"ScrollBottom");
        eventStrings.put(9,"Locate");
        //eventStrings.put(1,"MouseDown");
        eventStrings.put(10,"MouseUp");
        eventStrings.put(11,"MouseIn");
        eventStrings.put(12,"MouseOut");
        eventStrings.put(13,"MouseMove");
        eventStrings.put(14,"VBXevent");
        eventStrings.put(15,"AlertKey");
        eventStrings.put(16,"PreAlertKey");
        eventStrings.put(17,"Dragging");
        eventStrings.put(18,"Drag");
        eventStrings.put(19,"Drop");
        eventStrings.put(20,"ScrollDrag");
        eventStrings.put(21,"TabChanging");
        eventStrings.put(22,"Expanding");
        eventStrings.put(23,"Contracting");
        eventStrings.put(24,"Expanded");
        eventStrings.put(25,"Contracted");
        eventStrings.put(26,"Rejected");
        eventStrings.put(27,"DroppingDown");
        eventStrings.put(28,"DroppedDown");
        eventStrings.put(29,"ScrollTrack");
        eventStrings.put(30,"ColumnResize");
        eventStrings.put(31,"Selecting");
        eventStrings.put(257,"Selected");
        eventStrings.put(513,"CloseWindow");
        eventStrings.put(514,"CloseDown");
        eventStrings.put(515,"OpenWindow");
        eventStrings.put(516,"OpenFailed");
        eventStrings.put(517,"LoseFocus");
        eventStrings.put(518,"GainFocus");
        eventStrings.put(520,"Suspend");
        eventStrings.put(521,"Resume");
        eventStrings.put(523,"Timer");
        eventStrings.put(524,"DDErequest");
        eventStrings.put(525,"DDEadvise");
        eventStrings.put(526,"DDEdata");
        eventStrings.put(527,"DDEcommand");
        eventStrings.put(527,"DDEexecute");
        eventStrings.put(528,"DDEpoke");
        eventStrings.put(529,"DDEclosed");
        eventStrings.put(544,"Move");
        eventStrings.put(545,"Size");
        eventStrings.put(546,"Restore");
        eventStrings.put(547,"Maximize");
        eventStrings.put(548,"Iconize");
        eventStrings.put(549,"Completed");
        eventStrings.put(560,"Moved");
        eventStrings.put(561,"Sized");
        eventStrings.put(562,"Restored");
        eventStrings.put(563,"Maximized");
        eventStrings.put(564,"Iconized");
        eventStrings.put(565,"Docked");
        eventStrings.put(566,"Undocked");
        eventStrings.put(576,"BuildFile");
        eventStrings.put(577,"BuildKey");
        eventStrings.put(578,"BuildDone");
        eventStrings.put(1024,"User");
        eventStrings.put(4095,"Last");
    }

    static {
        addDefaultFonts();
    }
    
    public static CWinImpl getInstance()
    {
        if (sInstance==null) {
            synchronized(CWin.class) {
                if (sInstance==null) {
                    sInstance=new CWinImpl();
                    CRun.addShutdownHook(new Runnable() {
                        @Override
                        public void run() {
                            sInstance=null;
                        } 
                    } );
                }
            }
        }
        return sInstance;
    }

    /**
     *  Display modal message
     *  
     * @param message
     * @return
     */
    public static int message(ClarionString message)
    {
        return message(message,null);
    }

    /**
     * Display modal message
     * 
     * @param message
     * @param header
     * @return
     */
    public static int message(ClarionString message,ClarionString header)
    {
        return message(message,header,Icon.NONE);
    }

    /**
     *  Display modal message
     *  
     * @param message
     * @param header
     * @param icon
     * @return
     */
    public static int message(ClarionString message,ClarionString header,String icon)
    {
        return message(message,header,icon,Button.OK);
    }

    /**
     * Display modal message
     * 
     * @param message
     * @param header
     * @param icon
     * @param button
     * @return
     */
    public static int message(ClarionString message,ClarionString header,String icon,int button)
    {
        return message(message,header,icon,button,Button.OK);
    }

    /**
     * Display modal message
     * 
     * @param message
     * @param header
     * @param icon
     * @param button
     * @param defButton
     * @return
     */
    public static int message(ClarionString message,ClarionString header,String icon,int button,int defButton)
    {
        return message(message,header,icon,button,defButton,0);
    }

    /**
     * Display modal message
     * 
     * @param message
     * @param header
     * @param icon
     * @param button
     * @param defButton
     * @param style - 1 = system modal. 0 = app model. Ignored by swing implementation
     * @return
     */
    public static int message(ClarionString message,ClarionString header,String icon,int button,int defButton,int style)
    {
        return getInstance().message(message,header,icon,button,defButton,style);
    }
    
    
    /**
     * Update and Redraw all controls
     */
    public static void display()
    {
        AbstractWindowTarget awt = getWindowTarget();
        awt.runAcceptTasks();
    }

    /**
     * Update and Redraw specified control
     * 
     * @param field
     */
    public static void display(int field)
    {
        display();
    }

    /**
     * Update and Redraw specified controls
     * 
     * @param field
     */
    public static void display(int lo,int hi)
    {
        display();
    }
    
    
    /**
     * Change Control object's value
     * 
     * @param field
     */
    public static void change(int field,ClarionObject value)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    
    /**
     * Disable a control
     * 
     * @param field
     */
    public static void disable(int field)
    {
        getControl(field).setProperty(Prop.DISABLE,true);
    }

    /**
     * Disable range of controls
     * 
     * @param field
     */
    public static void disable(int lo,int hi)
    {
        for (int scan=lo;scan<=hi;scan++) {
            disable(scan);
        }
    }

    /**
     * Enable a control
     * 
     * @param field
     */
    public static void enable(int field)
    {
        getControl(field).setProperty(Prop.DISABLE,false);
    }

    /**
     * Enable all controls in range
     * 
     * @param lo
     * @param hi
     */
    public static void enable(int low,int hi)
    {
        for (int scan=low;scan<=hi;scan++) {
            enable(scan);
        }
    }

    /**
     * Hide a control
     * 
     * @param field
     */
    public static void hide(int field)
    {
        getControl(field).setProperty(Prop.HIDE,true);
    }

    /**
     * Unhide a control
     * 
     * @param field
     */
    public static void unhide(int field)
    {
        getControl(field).setProperty(Prop.HIDE,false);
    }

    /**
     * Unhide all controls in specified range
     * 
     * @param from
     * @param to
     */
    public static void unhide(int from,int to)
    {
        for (int scan=from;scan<=to;scan++) {
            unhide(scan);
        }
    }

    /**
     * Update use field with control value
     * 
     * @param field
     */
    public static void update(int field)
    {
        AbstractControl ac = getInstance().getTarget().getControl(field);
        if (ac!=null) ac.update();
    }

    /**
     * Update all use fields with control values
     * 
     */
    public static void update()
    {
        ControlIterator ci = new ControlIterator(getInstance().getTarget());
        while (ci.hasNext()) {
            ci.next().update();
        }
    }

    /**
     * Select a control
     * 
     * @param control
     */
    public static void select(int control) {

        AbstractTarget target = getTarget();
        AbstractControl ac = target.getControl(control);
        if (ac!=null) {
            ControlIterator ci = new ControlIterator(ac,true);
            ci.setLoop(false);
            ci.setScanDisabled(false);
            ci.setScanHidden(false);
            ci.setScanSheets(true);
            ac=ci.next();
        }
            
        if (ac!=null) {
            
            
            if (target.isProperty(Prop.ACCEPTALL)) {
                ClarionEvent ev = ((AbstractWindowTarget)target).getPendingEvent();
                if (ev!=null && ev.getField()==ac.getUseID()) {
                    target.setProperty(Prop.ACCEPTALL,0);
                }
            }
            getInstance().select(ac);
        }
    }

    /**
     * Enter acceptall mode
     * 
     */
    public static void select() {
        getTarget().setProperty(Prop.ACCEPTALL,1);
    }
    
    /**
     *  Get current control based on target setting
     * @param control
     * @return
     */
    public static PropertyObject getControl(ClarionObject control)
    {
        return getControl(control.intValue());
    }

    public static PropertyObject getControl(int indx)
    {
        if (indx==0) return CWin.getTarget();
        PropertyObject po = CWin.getTarget().getControl(indx);
        if (po!=null) return po;
        return new PropertyObject() {
            public PropertyObject getParentPropertyObject() {
                return null;
            }

            @Override
            protected void debugMetaData(StringBuilder sb) {
            } };
    }
    

    /**
     * Select a control at a given start position. i.e. list or entry etc
     * 
     * @param control
     * @param start
     */
    public static void select(int control,int start) {
        AbstractControl c = getInstance().getTarget().getControl(control);
        if (c instanceof SheetControl) {
            c.setProperty(Prop.SELSTART,start);
        } else if (c instanceof OptionControl) {
            c.setProperty(Prop.SELSTART,start);
        } else {
            select(control);
            c.setProperty(Prop.SELSTART,start);
        }
    }

    /**
     * Select a control at a given start position. Try and figure out
     * what control based on Object instead of control id
     * 
     * @param o
     * @param start
     */
    public static void select(Object o,int start) {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * Select control and mark start/end range. i.e. text select
     * 
     * @param control
     * @param start
     * @param end
     */
    public static void select(int control,int start,int end) {
        AbstractControl c = getInstance().getTarget().getControl(control);
        select(control);
        c.setProperty(Prop.SELSTART,start);
        c.setProperty(Prop.SELEND,end);
    }
    
    /**
     * Determine selection in a control - i.e. selected rownum in a list
     * 
     * @param control
     * @return
     */
    public static int choice(int control) {
        ClarionObject o = getControl(control).getProperty(Prop.SELECTED);
        if (o==null) return 0;
        return o.intValue();
    }

    /**
     *  Get selected item in current field. 
     * @return
     */
    public static int choice()
    {
        return choice(field());
    }
    
    
    /**
     * Post event to current window
     * 
     * @param event
     */
    public static void post(int event) {
        getInstance().getTarget().post(event);
    }

    /**
     * Post event to specific control in current window
     * 
     * @param event
     * @param control
     */
    public static void post(int event,int control) {
        
        AbstractWindowTarget awt = getInstance().getTarget();
        if (awt==null) return;
        
        if (control==0) {
            awt.post(event);
        } else {
            AbstractControl ac = awt.getControl(control);
            if (ac!=null) {
                ac.post(event);
            } else {
                awt.post(ClarionEvent.test(event,control,false));    
            }
        }
    }

    /**
     * Post event to specific control in a specific window
     * 
     * @param event
     * @param control
     * @param window
     */
    public static void post(Integer event,Integer control,ClarionNumber window) {

        if (window.intValue()==Thread.currentThread().getId()) {
            post(event,control);
        }
        
        Thread t = CRun.getThread(window.intValue());
        if (t!=null) {
            AbstractWindowTarget target = getInstance().getTarget(t);
            if (target==null) {
                log.warning("Target is null for ID:"+window+" Thread:"+t);
            } else {

                if (control==null || control==0) {
                    target.post(event);
                } else {
                    AbstractControl ac  = target.getControl(control);
                    if (ac!=null) {
                        ac.post(event);
                    } else {
                        target.post(ClarionEvent.test(event,control,false));    
                    }
                }
            }
            return;
        }
        throw new RuntimeException("Thread not found");
    }
    
    /**
     * Return contents, in string form for the specified control
     *
     * @param control
     * @return
     */
    public static ClarionString contents(int control)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * Return cntrol id of the control that generated current event
     * 
     * @return
     */
    public static int field()
    {
        ClarionEvent ev = getInstance().getTarget().getPendingEvent();
        if (ev==null) return 0;
        return ev.getField();
    }

    /**
     * Return control id that currently has focus
     * 
     * @return
     */
    public static int focus()
    {
        return getInstance().focus();
    }

    /**
     * Return current event
     * 
     * @return
     */
    public static int event()
    {
        ClarionEvent ev = getInstance().getTarget().getPendingEvent();
        if (ev==null) return 0;
        return ev.getEvent();
    }
    
    public static String eventString()
    {
        return eventStrings.get(event());
    }

    public static String eventString(int event)
    {
        return eventStrings.get(event);
    }

    /**
     * Return control that posted accepted event
     * 
     * @return
     */
    public static int accepted()
    {
        if (event()==Event.ACCEPTED) return field();
        return 0;
    }

    /**
     *  Return key code generated on last event, or key code set by
     *  function setkeycode
     *  
     * @return
     */
    public static int keyCode()
    {
        AbstractWindowTarget t = getInstance().getTarget(0);
        if (t==null) return 0;
        return t.getKeyCode();
    }

    /**
     * setup alert notification for the specified key
     * 
     * @param key
     */
    public static void alert(int key) {
        getInstance().getTarget().addAlert(key);
    }

    /**
     * setup alert notification for the specified key range
     * 
     * @param key
     */
    public static void alert(int lo,int hi) {
        for (int scan=lo;scan<=hi;scan++) {
            alert(scan);
        }
    }
    
    public static class OverrideTarget
    {
        public AbstractTarget base;
        public AbstractTarget target;

        public OverrideTarget(AbstractTarget base,AbstractTarget target)
        {
            this.base=base;
            this.target=target;
        }
    }
    
    private static ThreadLocal<OverrideTarget> target=new ThreadLocal<OverrideTarget>();
    
    /**
     * set control target to a different abstracttarget
     * 
     * @param key
     */
    public static void setTarget(AbstractTarget target)
    {
        if (target==getInstance().getTarget()) {
            setTarget();
        } else {
            CWin.target.set(new OverrideTarget(getInstance().getTarget(),target));
        }
    }
    
    /**
     * set control target to default open target 
     * 
     * @param key
     */
    public static void setTarget()
    {
        CWin.target.set(null);
    }

    /**
     * Get current abstract target  - report or window
     */
    public static AbstractTarget getTarget()
    {
        OverrideTarget target = CWin.target.get();
        AbstractTarget result = getInstance().getTarget();

        if (target!=null && target.base==result) result=target.target;
        return result;
    }

    public static void closeTarget(AbstractTarget t)
    {
        OverrideTarget target = CWin.target.get();
        if (target!=null && target.base==t) setTarget();
    }

    /**
     * Get current abstract target  - report or window
     */
    public static AbstractWindowTarget getWindowTarget()
    {
        OverrideTarget target = CWin.target.get();
        AbstractTarget result = getInstance().getTarget();
        
        if (target!=null && target.base==result && (target.target instanceof AbstractWindowTarget)) result=target.target;
        return (AbstractWindowTarget)result;
    }
    
    public static void addDefaultFonts()
    {
        InputStream is =  CWin.class.getClassLoader().getResourceAsStream("resources/fonts/catalog");
        if (is==null) return;

        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            while (true) {
                String name = br.readLine();
                if (name == null)
                    break;
                name = name.trim();
                if (name.length() == 0)
                    continue;
                addFont(name);
            }
            br.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    public static void addFont(String name)
    {
        try {
            name="resources/fonts/"+(name.toLowerCase().trim());
            InputStream fontStream = CWin.class.getClassLoader().getResourceAsStream(name);
            if (fontStream==null) throw new IOException("No stream: "+name);
            java.awt.Font f = java.awt.Font.createFont(java.awt.Font.TRUETYPE_FONT, fontStream);
            GraphicsEnvironment.getLocalGraphicsEnvironment().registerFont(f);
        } catch (IOException e) {  
            e.printStackTrace();
        } catch (FontFormatException e) {
            e.printStackTrace();
        }
    }
    
    
    /**
     * Create a new control object
     * 
     * @param id
     * @param type
     * @param parent
     * @return
     */
    public static int createControl(int id,int type,Integer parent)
    {
        return createControl(id,type,parent,null);
    }
    
    public static int createControl(int id,int type,Integer parent,Integer position)
    {
        final AbstractControl ac;
        
        switch(type) {
            case Create.LINE:
                ac = new LineControl();
                break;
            case Create.BOX:
                ac = new BoxControl();
                break;
            case Create.TAB:
                ac = new TabControl();
                break;
            case Create.SSTRING: // picture + use
            case Create.STRING:  // constant
                ac = new StringControl();
                break;
            default:     
                throw new RuntimeException("Not yet implemented:"+type);
        }

        ac.setConstructOnUnhide();
        
        AbstractTarget awt = (AbstractTarget)getTarget();
     
        if (parent!=null && parent.intValue()!=0) {
            awt.getControl(parent.intValue()).addChild(ac);
        } else {
            awt.add(ac);
        }
        
        ac.setProperty(Prop.HIDE,true);

        if (id!=0) {
            awt.register(ac,id);
        } else {
            awt.register(ac);
        }
        
        return ac.getUseID();
    }
    
    /**
     * delete a control object
     * 
     * @param id
     */
    public static void removeControl(int id)
    {
        AbstractTarget target = getTarget();
        AbstractControl ac = target.getControl(id);
        if (ac!=null) {
            if (ac.getParent()!=null) {
                ac.getParent().removeChild(ac);
            } else {
                target.remove(ac);
            }
            Component c = ac.getComponent();
            if (c!=null) {
                c.getParent().remove(c);
            }
            ac.clearMetaData();
            ac.removeAllListeners();
        }
    }

    /**
     * Delete control objects in specified range
     * 
     * @param from
     * @param to
     */
    public static void removeControl(int from,int to)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    /**
     * Set position of a control object
     * 
     * @param control
     * @param x
     * @param y
     * @param width
     * @param height
     */
    public static void setPosition(int control,Integer x,Integer y,Integer width,Integer height) {
        
        PropertyObject ac = getControl(control);
        if (x!=null) ac.setProperty(Prop.XPOS,x);
        if (y!=null) ac.setProperty(Prop.YPOS,y);
        if (width!=null) ac.setProperty(Prop.WIDTH,width);
        if (height!=null) ac.setProperty(Prop.HEIGHT,height);
    }

    /**
     * Extract positional information for a given control and insert data into supplied fields
     * 
     * @param control
     * @param x
     * @param y
     * @param width
     * @param height
     */
    public static void getPosition(int control,ClarionNumber x,ClarionNumber y,ClarionNumber width,ClarionNumber height) {
        
        PropertyObject ac =getControl(control);
        x.setValue(ac.getProperty(Prop.XPOS));
        y.setValue(ac.getProperty(Prop.YPOS));
        width.setValue(ac.getProperty(Prop.WIDTH));
        height.setValue(ac.getProperty(Prop.HEIGHT));
    }

    /**
     * Set control object font
     * 
     * @param control
     * @param typeface
     * @param size
     * @param color
     * @param style
     * @param charset
     */
    public static void setFont(int control,String typeface,Integer size,Integer color,Integer style,Integer charset)
    {
        PropertyObject ac = getControl(control);
        if (typeface!=null) ac.setProperty(Prop.FONTNAME,typeface);
        if (size!=null) ac.setProperty(Prop.FONTSIZE,size);
        if (color!=null) ac.setProperty(Prop.FONTCOLOR,color);
        if (style!=null) ac.setProperty(Prop.FONTSTYLE,style);
        if (charset!=null) ac.setProperty(Prop.FONTCHARSET,charset);
    }


    /**
     * Set mouse cursor look
     * 
     * @param cursor
     */
    public static void setCursor(String cursor)
    {
        getInstance().setCursor(cursor);
    }

    /**
     *  Set mouse cursor look to default
     *  
     */
    public static void setCursor()
    {
        getInstance().setCursor(null);
    }

    /**
     * Make default system noise
     */
    public static void beep()
    {
        Toolkit.getDefaultToolkit().beep();
    }

    /**
     * Make specified system noise
     * @param tone
     */
    public static void beep(int tone)
    {
        Toolkit.getDefaultToolkit().beep();
    }

    /**
     *  Set key code to be returned by calls to keycode
     * @param code
     */
    public static void setKeyCode(int code)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     *  set ASCII char value of keycode pressed 
     * @param code
     */
    public static void setKeyChar(int code)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * Insert keycode into keyboard buffer. Hopefully SWT will allow
     * us to do this
     * 
     * @param code
     */
    public static void pressKey(int code)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * set ASCII char value of keycode pressed
     * @return
     */
    public static int keyChar()
    {
        AbstractWindowTarget t = getInstance().getTarget();
        if (t==null) return 0;
        return t.getKeyChar();
    }
    
    /**
     * Pass key code to another control.
     * Hopefully SWT will permit this
     * 
     * @param control
     */
    public static void forwardKey(int control)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     *  Draw a popup window
     *  
     * @param message window to draw. 
     *  | delimiter separates items
     *  ~ prefix disables an option
     *  + prefix draws check mark
     *  - prefix no draw check mark
     *  {} in option defines sub options. Can be deeply nested
     *  <tab> right aligns proceeding text
     *  [ PROP:ICON + ( name ) ] = draw icon first
     * 
     * @return
     */
    public static int popup(String message)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    public static int popup(String message,Integer x,Integer y)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * Select a printer
     * 
     * @param title
     * @param mode
     * @return
     */
    public static boolean printerDialog(ClarionString title,Integer mode)
    {
        return ClarionPrinter.getInstance().printerDialog(title,mode);
    }

    /**
     * Select a file
     * 
     * @param title   Title to display
     * @param target  Target string to receive result
     * @param files   
     * @param options Following bits apply:
     *     1  = 'Save' instead of 'Open'
     *     2  = save and restore path
     *     4  = suppress error if on save file exists and if on open does not exist
     *     8  = allow multiple selections
     *     16 = use long filenames 
     *     32 = select directories 
     * @return
     */
    /*
    public static boolean fileDialog(String title,ClarionString target,String files,int options)
    {
        while ( true ) {
            try {
                return doFileDialog(title,target,files,options);
            } catch (Exception ex) { 
                ex.printStackTrace();
            }
        }
    }
    */

    private static FileSystemView view;
    
    public static FileSystemView getView()
    {
        FileSystemView result = view;
        view=null;
        if (result==null) result=FileSystemView.getFileSystemView();
        return result;
    }
    
    public static void setFileSystemView(FileSystemView view)
    {
        CWin.view=view;
    }
    
    public static boolean fileDialog(final String title,final ClarionString target,final String ifiles,final int options)
    {
        final boolean[] f_result = new boolean[] { true };
        final AbstractWindowTarget parent = CWin.getWindowTarget();
        if (parent!=null) {
            parent.setActiveState(false);
        }
        
        Runnable r = new Runnable() {
        public void run()
        {

                File sf = CFile.pwd;
                if (!target.equals("")) {
                    sf = ClarionFileFactory.getInstance().getFile(
                            target.toString().trim());
                }

                File d = sf;
                while (d != null && !d.isDirectory()) {
                    d = d.getParentFile();
                }
                if (d == null)
                    d = CFile.pwd;

                JFileChooser chooser = new JFileChooser(d, getView());
                chooser.setDialogTitle(title.trim());

                if (!sf.isDirectory()) {
                    chooser.setSelectedFile(sf);
                }
                
                String files=ifiles;

                if (files == null || files.trim().length() == 0) {
                    files = "All Files|*.*";
                }

                StringTokenizer tok = new StringTokenizer(files, "|");
                while (tok.hasMoreTokens()) {
                    final String name = tok.nextToken().trim();
                    if (!tok.hasMoreTokens())
                        break;
                    String pattern = tok.nextToken().trim();

                    if (pattern.equals("*.*")) {
                        chooser.addChoosableFileFilter(new FileFilter() {

                            @Override
                            public boolean accept(File f) {
                                return true;
                            }

                            @Override
                            public String getDescription() {
                                return name;
                            }

                        });

                        continue;
                    }

                    List<String> bits = new ArrayList<String>();

                    StringTokenizer bits_tok = new StringTokenizer(pattern, ";");
                    while (bits_tok.hasMoreTokens()) {
                        String filter = bits_tok.nextToken().trim();
                        if (!filter.startsWith("*."))
                            throw new IllegalArgumentException("Filter Invalid");
                        bits.add(filter.substring(2));
                    }
                    chooser.addChoosableFileFilter(new FileNameExtensionFilter(
                            name, (String[]) bits.toArray(new String[bits
                                    .size()])));
                }

                if ((options & 1) == 1) {
                    chooser.setDialogType(JFileChooser.SAVE_DIALOG);
                } else {
                    chooser.setDialogType(JFileChooser.OPEN_DIALOG);
                }

                if ((options & 4) == 4) {
                } else {
                    // setup open to warn/error if file does not exist
                    // setup save to warn/error if file does exist
                }

                if ((options & 8) == 8) {
                    chooser.setMultiSelectionEnabled(true);
                } else {
                    chooser.setMultiSelectionEnabled(false);
                }

                if ((options & 64) == 0) { // extension - files or directories
                    if ((options & 32) == 32) {
                        chooser
                                .setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
                    } else {
                        chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
                    }
                } else {
                    chooser
                            .setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);
                }

                int result;

                GraphicsConfiguration gc = null;
                AbstractWindowTarget parent = CWin.getWindowTarget();
                if (parent != null) {
                    parent.setActiveState(false);
                    if (CWin.getInstance().getApp() != null) {
                        gc = ((java.awt.Window) CWin.getInstance().getApp()
                                .getWindow()).getGraphicsConfiguration();
                    }
                    if (parent.getWindow() != null
                            && (parent.getWindow() instanceof java.awt.Window)) {
                        gc = ((java.awt.Window) parent.getWindow())
                                .getGraphicsConfiguration();
                    }
                }

                if (gc == null) {
                    gc = GraphicsEnvironment.getLocalGraphicsEnvironment()
                            .getDefaultScreenDevice().getDefaultConfiguration();
                }
                Rectangle r = gc.getBounds();

                chooser.setPreferredSize(new Dimension((r.width - r.x) * 2 / 3,
                        (r.height - r.y) * 2 / 3));
                
                ClarionEventQueue.getInstance().setRecordState(false,"Entering fileDialog");
                
                if ((options & 1) == 1) {
                    result = chooser.showSaveDialog(null);
                } else {
                    result = chooser.showOpenDialog(null);
                }

                ClarionEventQueue.getInstance().setRecordState(true,"Exiting fileDialog");

                if (result != JFileChooser.APPROVE_OPTION) {
                    f_result[0] = false;
                    return;
                }

                File pwd = null;

                StringBuilder out = new StringBuilder();
                if (chooser.isMultiSelectionEnabled()) {
                    File f[] = chooser.getSelectedFiles();
                    if (f.length > 0) {
                        pwd = f[0].getAbsoluteFile();
                        out.append(f[0].getAbsolutePath());
                    }
                    if (f.length > 1) {
                        for (int scan = 1; scan < f.length; scan++) {
                            out.append('|');
                            out.append(f[scan].getName());
                        }
                    }
                } else {
                    pwd = chooser.getSelectedFile().getAbsoluteFile();
                    out.append(chooser.getSelectedFile().getAbsolutePath());
                }
                target.setValue(out.toString());

                if ((options & 2) == 2) {
                } else {
                    if (pwd != null) {
                        CFile.pwd = pwd.getParentFile();
                    }
                }
        }
        };
        CWinImpl.runNow(r);
        
        if (parent!=null) {
            parent.setActiveState(true);
        }
        
        return f_result[0];
    }

    /**
     * Popup a color chooser dialog. Place result in Number rgb
     *
     * @param title
     * @param rbg
     * @param suppress - if set to one then suppress selection of standard colors
     * @return
     */
    public static boolean colorDialog(String title,ClarionNumber rgb,Integer suppress)
    {
        throw new RuntimeException("not yet implemented");
    }

    /**
     * Popup a dialog that allows user to select font
     * 
     * @param title - dialog title 
     * @param typeFace - typeface to display
     * @param size - font size
     * @param color - font color
     * @param style - font style. Italic, bold etc
     * @param added - null = truetype fonts only. 0 = window fonts. 1 = printer fonts. 2 = both  
     * @return
     */
    public static boolean fontDialog(String title,ClarionString typeFace,ClarionNumber size,ClarionNumber color,ClarionNumber style,ClarionNumber added)
    {
        ClarionWindow fd = new ClarionWindow();
        fd.setMDI();
        fd.setSystem();
        fd.setAt(0,0,150,105);
        fd.setCenter();
        fd.setText(title);
        fd.setFont("Serif",10,null,null,null);
       
        ClarionString tempFace=null;
        ClarionNumber tempSize=null;
        
        Map<Integer,ClarionObject> remap = new HashMap<Integer, ClarionObject>();
        
        if (typeFace!=null) {
            tempFace=new ClarionString();
            tempFace.setValue(typeFace);
            fd.add((new StringControl()).setAt(5,5,null,null).setText("Font:"));
            
            EntryControl ec = new EntryControl();
            ec.setText("@s40");
            ec.setAt(5,15,100,10);
            ec.use(tempFace);
            fd.add(ec);

            SimpleComboQueue scq = new SimpleComboQueue();
            ListControl lc = new ListControl();
            lc.setAt(5,27,100,60);
            lc.setVScroll();
            lc.setFrom(scq);
            fd.add(lc);
            Set<String> unique = new HashSet<String>();
            for ( Font f : GraphicsEnvironment.getLocalGraphicsEnvironment().getAllFonts()) {
                String name = f.getFontName();
                if (unique.contains(name)) continue;
                unique.add(name);
                scq.item.setValue(name);
                scq.add(scq.ORDER().ascend(scq.item));
            }
            remap.put(lc.getUseID(),tempFace);
        }

        if (size!=null) {
            tempSize=new ClarionNumber();
            tempSize.setValue(size);
            fd.add((new StringControl()).setAt(110,5,null,null).setText("Size:"));
            
            EntryControl ec = new EntryControl();
            ec.setText("@n3");
            ec.setAt(110,15,35,10);
            ec.use(tempSize);
            fd.add(ec);

            SimpleComboQueue scq = new SimpleComboQueue();
            ListControl lc = new ListControl();
            lc.setAt(110,27,35,60);
            lc.setVScroll();
            lc.setFrom(scq);
            fd.add(lc);
            for ( int sizes : new int[] { 8,9,10,11,12,14,16,18,20,22,24,26,28,36,48,72 } ) {
                scq.item.setValue(sizes);
                scq.add();
            }
            remap.put(lc.getUseID(),tempSize);
        }

        ButtonControl ok = new ButtonControl();
        ok.setAt(30,88,40,15);
        ok.setText("&Ok");
        ok.setDefault();
        fd.add(ok);

        ButtonControl cancel = new ButtonControl();
        cancel.setAt(80,88,50,15);
        cancel.setText("&Cancel");
        cancel.setStandard(Std.CLOSE);
        fd.add(cancel);
        
        fd.open();
        
        for ( Map.Entry<Integer,ClarionObject> me : remap.entrySet() )
        {
            ListControl lc = (ListControl)CWin.getControl(me.getKey());

            String ts = me.getValue().toString().trim();
            ClarionQueue cq = lc.getFrom();
            for (int scan=1;scan<=cq.records();scan++) {
                cq.get(scan);
                if (cq.what(1).toString().trim().equalsIgnoreCase(ts)) {
                    lc.setProperty(Prop.SELSTART,scan);
                    break;
                }
            }
        }
        
        boolean result=false;
        
        while (fd.accept()) {

            if (CWin.accepted()==ok.getUseID()) {
                if (tempFace!=null) {
                    typeFace.setValue(tempFace);
                }
                if (tempSize!=null) {
                    size.setValue(tempSize);
                }
                result=true;
                CWin.post(Event.CLOSEWINDOW);
            }
            
            if (CWin.event()==Event.NEWSELECTION) {
    
                ClarionObject obj = remap.get(CWin.field());
                if (obj!=null) {
                    ListControl lc = (ListControl)CWin.getControl(CWin.field());
                    lc.getFrom().get(lc.getProperty(Prop.SELSTART));
                    obj.setValue(lc.getFrom().what(1));
                }
            }
            
            fd.consumeAccept();
        }
        fd.close();
        
        return result;
    }
    
    /**
     *  Reset alias on a specified key
     */
    public static void clearAliasKey(int key)
    {
    }

    /**
     *  Reset all aliased keys
     */
    public static void clearAllAliasKeys()
    {
    }
    
    
    /**
     * Map one key to another
     * 
     * @param from
     * @param to
     */
    public static void aliasKey(int from,int to)
    {
        throw new RuntimeException("not yet implemented");
    }
    
    /**
     *  Get keystate of control keys, shift, control etc
     */
    public static int keyState()
    {
        AbstractWindowTarget t = getInstance().getTarget();
        if (t==null) return 0;
        return t.getKeyState();
    }

    public static ClarionString getClipboard()
    {
        Object o=null;
        try {
            o = Toolkit.getDefaultToolkit().getSystemClipboard().getData(DataFlavor.stringFlavor);
        } catch (HeadlessException e) {
        } catch (UnsupportedFlavorException e) {
        } catch (IOException e) {
        }
        if (o==null) return new ClarionString("");
        return new ClarionString(o.toString());
    }

    public static void setClipboard(ClarionString content)
    {
        StringSelection ss = new StringSelection(content.toString());
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss,ss);
    }

    /**
     * Return last control code in current target
     * @return
     */
    public static int getLastField()
    {
        return getTarget().getLastID();
    }
    /**
     * Return first control code in current target
     * @return
     */
    public static int getFirstField()
    {
        throw new RuntimeException("not yet implemented");
    }

    /** 
     * get Mouse X pos relative to ???
     * @return
     */
    public static int getMouseX()
    {
        throw new RuntimeException("not yet implemented");
    }

    /** 
     * get Mouse Y pos relative to ???
     * @return
     */
    public static int getMouseY()
    {
        throw new RuntimeException("not yet implemented");
    }

    /**
     *  Register an event listener
     *  
     * @param event
     * @param trigger
     * @return
     */
    public static void register(int event,Runnable trigger,int key)
    {
        (getWindowTarget()).registerEvent(event,trigger,key);
    }
    
    /**
     *  Deregister an event listener
     */
    public static void unregister(int event,Runnable trigger,int key)
    {
        AbstractWindowTarget awt = getWindowTarget();
        if (awt!=null) {
            awt.deregisterEvent(event,trigger,key);
        }
    }

    public static void box(int x,int y,int width,int height)
    {
        int ctl = createControl(0,Create.BOX,0);
        setPosition(ctl,x,y,width,height);
        getControl(ctl).setProperty(Prop.BOXED,1);
        unhide(ctl);
    }
}
