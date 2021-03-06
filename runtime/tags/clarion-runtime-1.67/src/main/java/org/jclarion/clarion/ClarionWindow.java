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
package org.jclarion.clarion;

import java.awt.Container;
import java.awt.Frame;
import java.awt.Insets;
import java.beans.PropertyVetoException;

import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;

import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.AWTPropertyGetter;
import org.jclarion.clarion.swing.AbstractAWTPropertyGetter;
import org.jclarion.clarion.constants.*;

/**
 * Model clarion window
 * 
 * @author barney
 *
 */
public class ClarionWindow extends AbstractWindowTarget implements AbstractAWTPropertyGetter
{
    /**
     * Set system window top left on window
     * 
     * @return
     */
    public ClarionWindow setSystem()
    {
        setProperty(Prop.SYSTEM,true);
        return this;
    }

    public ClarionWindow setAlrt(int value)
    {
        addAlert(value);
        return this;
    }
    
    /**
     * Window wallpaper is centered
     * 
     * @return
     */
    public ClarionWindow setCentered()
    {
        setProperty(Prop.CENTERED,true);
        return this;
    }

    /**
     * Set window to be maximised
     * 
     * @return
     */
    public ClarionWindow setMaximize()
    {
        setProperty(Prop.MAXIMIZE,true);
        return this;
    }

    /**
     * Window style is toolbox style
     * 
     * @return
     */
    public ClarionWindow setToolbox()
    {
        setProperty(Prop.TOOLBOX,true);
        return this;
    }
    
    public ClarionWindow setStatus(int ...status)
    {
        doSetStatus(status);
        return this;
    }

    /**
     * Set window style/color - grey
     * 
     * @return
     */
    public ClarionWindow setGray()
    {
        setProperty(Prop.GRAY,true);
        return this;
    }

    /**
     * Set help option when F1/help is selected
     * 
     * @param help
     * @return
     */
    public ClarionWindow setHelp(String help)
    {
        setProperty(Prop.HLP,help);
        return this;
    }

    /**
     * Indicate window is to tile in realestate
     * 
     * @return
     */
    public ClarionWindow setTiled()
    {
        setProperty(Prop.TILED,true);
        return this;
    }

    /**
     * Window has no frame
     * 
     * @return
     */
    public ClarionWindow setNoFrame()
    {
        setProperty(Prop.NOFRAME,true);
        return this;
    }

    /**
     * Indicate that window is a child in a MDI style application
     * 
     * @return
     */
    public ClarionWindow setMDI()
    {
        setProperty(Prop.MDI,true);
        return this;
    }

    /**
     * Locate window in center of realestate
     * @return
     */
    public ClarionWindow setCenter()
    {
        setProperty(Prop.CENTER,true);
        return this;
    }

    /** 
     * Set window timer event. in 100s of a second
     * 
     * @param timer
     * @return
     */
    public ClarionWindow setTimer(int timer)
    {
        setProperty(Prop.TIMER,timer);
        return this;
    }

    /**
     * Set window position
     * 
     * @param x
     * @param w
     * @param width
     * @param height
     * @return
     */
    public ClarionWindow setAt(Integer x,Integer y,Integer width,Integer height)
    {
        setProperty(Prop.XPOS,x);
        setProperty(Prop.YPOS,y);
        setProperty(Prop.WIDTH,width);
        setProperty(Prop.HEIGHT,height);
        return this;
    }

    /**
     * Set default window font
     * 
     * @param typeface
     * @param size
     * @param color
     * @param style
     * @param charset
     * @return
     */
    public ClarionWindow setFont(String typeface,Integer size,Integer color,Integer style,Integer charset)
    {
        setProperty(Prop.FONTNAME,typeface);
        setProperty(Prop.FONTSIZE,size);
        setProperty(Prop.FONTCOLOR,color);
        setProperty(Prop.FONTSTYLE,style);
        return this;
    }

    /**
     * Set default color
     * 
     * @param back
     * @param selectFor
     * @param selectBack
     * @return
     */
    public ClarionWindow setColor(Integer back,Integer selectFor,Integer selectBack)
    {
        setProperty(Prop.BACKGROUND,back);
        setProperty(Prop.SELECTEDCOLOR,selectFor);
        setProperty(Prop.SELECTEDFILLCOLOR,selectFor);
        return this;
    }
    
    /**
     * Set double window frame style
     * 
     * @return
     */
    public ClarionWindow setDouble()
    {
        setProperty(Prop.DOUBLE,true);
        return this;
    }

    /**
     * Indicate window is scrollable - vertical only
     * 
     * @return
     */
    public ClarionWindow setVScroll()
    {
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    /**
     * Indicate window is resizable
     * 
     * @return
     */
    public ClarionWindow setResize()
    {
        setProperty(Prop.RESIZE,true);
        return this;
    }

    /**
     * Generated events on resizing.
     *      Move - window moved
     *      Size - window sized
     *      restore - window restored
     *      maximise - window maximised
     *      iconize - window iconized
     * 
     * @return
     */
    public ClarionWindow setImmediate()
    {
        setProperty(Prop.IMM,true);
        return this;
    }

    public ClarionWindow setMask()
    {
        return this;
    }
    
    /**
     * Window is scrollable - horiz and vert
     * 
     * @return
     */
    public ClarionWindow setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    /**
     * Window has maximise button on top right
     * 
     * @return
     */
    public ClarionWindow setMax()
    {
        setProperty(Prop.MAX,true);
        return this;
    }

    /**
     * Window is application model
     * 
     * @return
     */
    public ClarionWindow setModal()
    {
        setProperty(Prop.MODAL,true);
        return this;
    }
    
    /**
     * Set window header 
     * 
     * @param text
     * @return
     */
    public ClarionWindow setText(String text)
    {
        setProperty(Prop.TEXT,text);
        return this;
    }

    /**
     * Set window icon
     * 
     * @param text
     * @return
     */
    public ClarionWindow setIcon(String text)
    {
        setProperty(Prop.ICON,text);
        return this;
    }
    
    /**
     * Open window
     * 
     */
    public void open()
    {
        CWin.getInstance().open(this);
    }

    /**
     * Open window in context of another window
     * 
     * @param parent
     */
    public void open(ClarionWindow parent)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * Close window
     * 
     */
    public void close()
    {
        CWin.getInstance().programmaticClose(this);
    }

    
    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        Container win = getWindow();
        if (win==null) return null;
        
        switch(index) {
            case Prop.MAXIMIZE: {
                if (win instanceof JFrame) {
                    int result = (((JFrame)win).getExtendedState()&JFrame.MAXIMIZED_BOTH)!=0?1:0;
                    return new ClarionNumber(result);
                }
                if (win instanceof JInternalFrame) {
                    int result = ((JInternalFrame)win).isMaximum()?1:0;
                    return new ClarionNumber(result);
                }
                break;
            }
            case Prop.XPOS:
                return Clarion.newNumber(widthPixelsToDialog(win.getX()));
                
            case Prop.YPOS:
                return Clarion.newNumber(heightPixelsToDialog(win.getY()));
        
            case Prop.WIDTH:
            case Prop.CLIENTWIDTH: {
                Insets i = getInsets();
                int w = win.getWidth();
                if (i != null) w = w - i.left - i.right;
                return Clarion.newNumber(widthPixelsToDialog(w));
            }

            case Prop.HEIGHT:
            case Prop.CLIENTHEIGHT: {
                Insets i = getInsets();
                int h = win.getHeight();
                if (i != null) h = h - i.top - i.bottom;
                return Clarion.newNumber(heightPixelsToDialog(h));
            }
        }
        return null;
    }

    @Override
    public ClarionObject getLocalProperty(int index) 
    {
        switch(index) {
            case Prop.MAXIMIZE: 
            case Prop.XPOS:
            case Prop.YPOS:
            case Prop.WIDTH:
            case Prop.HEIGHT:
            case Prop.CLIENTWIDTH:
            case Prop.CLIENTHEIGHT:
                return AWTPropertyGetter.getInstance().get(index,this);
                
        }
        return super.getLocalProperty(index);
    }

    @Override
    protected boolean canNotifyLocalChange(int indx)
    {
        return getClarionThread()!=null;
    }
    
    @Override
    protected void notifyLocalChange(final int indx,final ClarionObject value) 
    {
        boolean awtChange=false;
        
        switch(indx) {
            case Prop.HIDE:
            case Prop.XPOS:
            case Prop.YPOS:
            case Prop.WIDTH:
            case Prop.HEIGHT:
            case Prop.CLIENTWIDTH:
            case Prop.CLIENTHEIGHT:
            case Prop.TEXT:
            case Prop.ICON:
            case Prop.BACKGROUND:
            case Prop.MAXIMIZE:
                awtChange=true;
        }
        
        if (awtChange) {
            
            Runnable chg = new Runnable()
            {
                public void run()
                {
                    Container win = getWindow();
                    Container contentPane = getContentPane();
                    if (win==null || contentPane==null) return;
                    
                    switch(indx) {
                        case Prop.HIDE:
                            win.setVisible(!value.boolValue());
                            break;
                        case Prop.XPOS:
                            win.setLocation(widthDialogToPixels(value.intValue()),win.getY());
                            break;
                        case Prop.YPOS:
                            win.setLocation(win.getX(),heightDialogToPixels(value.intValue()));
                            break;
                        case Prop.WIDTH:
                        case Prop.CLIENTWIDTH: {
                            Insets i =getInsets();
                            win.setSize(widthDialogToPixels(value.intValue())+i.left+i.right,win.getWidth());
                            break;
                        }
                        case Prop.HEIGHT:
                        case Prop.CLIENTHEIGHT: {
                            Insets i =getInsets();
                            win.setSize(win.getWidth(),heightDialogToPixels(value.intValue())+i.top+i.bottom);
                            break;
                        }
                        case Prop.BACKGROUND: 
                            contentPane.setBackground(CWin.getInstance().getColor(value.intValue()));
                            break;
                        case Prop.ICON:
                            if (win instanceof JDialog) {
                                ((JDialog) win).setIconImage(CWin.getInstance().getImage(value.toString(),-1,-1));
                            }
                            if (win instanceof JFrame) {
                                //((JFrame) win).setIconImage(getImage(value.toString(),-1,-1));
                            }
                            if (win instanceof JInternalFrame) {
                                String name = value.toString().trim();
                                ((JInternalFrame) win).setFrameIcon(CWin.getInstance().scale(CWin.getInstance().getIcon(name,16,16),name,16,16));
                            }
                            break;
                        case Prop.TEXT:
                            if (win instanceof JDialog) {
                                ((JDialog) win).setTitle(value.toString());
                            }
                            if (win instanceof JFrame) {
                                ((JFrame) win).setTitle(value.toString());
                            }
                            if (win instanceof JInternalFrame) {
                                ((JInternalFrame) win).setTitle(value.toString());
                            }
                            break;
                        case Prop.MAXIMIZE: 
                            if ((win instanceof Frame) && value.boolValue()) {
                                ((Frame) win).setExtendedState(Frame.MAXIMIZED_BOTH);
                            }
                            
                            if ((win instanceof JInternalFrame) && value.boolValue()) {
                                try {
                                    ((JInternalFrame) win).setMaximum(true);
                                } catch (PropertyVetoException e) {
                                }
                            }
                    }
                }
            };
            CWinImpl.run(chg);
        }
        super.notifyLocalChange(indx, value);
    }
}


