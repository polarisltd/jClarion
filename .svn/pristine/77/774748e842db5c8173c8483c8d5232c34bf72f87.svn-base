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

import javax.swing.JDesktopPane;

import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.primative.ActiveThreadMap;

/**
 *  Model application window
 *  
 * @author barney
 *
 */
public class ClarionApplication extends ClarionWindow {

    /**
     *  Set window position/dimenstions
     *  
     * @param x
     * @param w
     * @param width
     * @param height
     * @return
     */
    public ClarionApplication setAt(Integer x,Integer y,Integer width,Integer height)
    {
        setProperty(Prop.XPOS,x);
        setProperty(Prop.YPOS,y);
        setProperty(Prop.WIDTH,width);
        setProperty(Prop.HEIGHT,height);
        return this;
    }

    /**
     *  Indicate that window is resizable
     * @return
     */
    public ClarionApplication setResize()
    {
        setProperty(Prop.RESIZE,true);
        return this;
    }

    /**
     * Set window text
     * @param aString
     * @return
     */
    public ClarionApplication setText(String aString)
    {
        setProperty(Prop.TEXT,aString);
        return this;
    }

    /**
     * set window icon
     * @param aString
     * @return
     */
    public ClarionApplication setIcon(String aString)
    {
        setProperty(Prop.ICON,aString);
        return this;
    }

    /**
     * If set then following events will be generated
     *      Move - window moved
     *      Size - window sized
     *      restore - window restored
     *      maximise - window maximised
     *      iconize - window iconized
     * @return
     */
    public ClarionApplication setImmediate()
    {
        setProperty(Prop.IMM,true);
        return this;
    }

    /**
     * Allow rendering of window system menu. i.e. top left of window
     * @return
     */
    public ClarionApplication setSystem()
    {
        setProperty(Prop.SYSTEM,true);
        return this;
    }

    /**
     * Display button (on top right) that allows window to be maximised.
     * @return
     */
    public ClarionApplication setMax()
    {
        setProperty(Prop.MAX,true);
        return this;
    }

    /**
     *  Allow window to be scrolled
     * @return
     */
    public ClarionApplication setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    //private int status[];
    
    /**
     * Define status bars for the window on bottom of window
     * 
     * @param bars - size of the bars
     * @return
     */
    public ClarionApplication setStatus(int... bars)
    {
        doSetStatus(bars);
        return this;
    }
    
    private JDesktopPane desktopPane;
    
    @Override
    public void clearMetaData()
    {
        desktopPane=null;
        super.clearMetaData();
    }
    
    public JDesktopPane getDesktopPane()
    {
        return desktopPane;
    }
    
    public void setDesktopPane(JDesktopPane desktopPane)
    {
        this.desktopPane=desktopPane;
    }

    private ActiveThreadMap<ClarionApplication> threads=new ActiveThreadMap<ClarionApplication>();
    
	public void registerThread(Thread t) {
		threads.put(t,this);
	}
	
	public Iterable<Thread> getThreads()
	{
		return threads.keys();
	}
    
}
