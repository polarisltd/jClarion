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
package org.jclarion.clarion.swing;


import java.awt.Component;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.Point;
import java.lang.reflect.InvocationTargetException;

import abbot.tester.Robot;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.RemoteWidget;

import junit.framework.AssertionFailedError;
import junit.framework.TestCase;

public class SwingTC extends TestCase 
{
    public SwingTC(String name) {
        super(name);
    }
    
    public <K extends RemoteWidget> K cc(K in)
    {
    	if (factory==null) return in;
    	return factory.getNetworkClient().getWidget(in);
    }
    
    protected TestGUIFactory factory;
    protected boolean		 createFactory;
    
    public void setUp() throws Exception
    {
        super.setUp();
        if (createFactory) factory=new TestGUIFactory();
        GUIModel.setFactory(factory);
        AbstractWindowTarget.suppressWindowSizingEvents=true;
    }

    public void tearDown() throws Exception
    {
        super.tearDown();
        if (factory!=null) {
            GUIModel.setFactory(null);
        	boolean err = factory.shutdown();
        	waitForEventQueueToCatchup();
        	if (err) throw new RuntimeException("Memory Usage!");
        }
        AbstractWindowTarget.suppressWindowSizingEvents=false;
    }
    
    public abstract class TestRunnable implements Runnable
    {
        private AssertionFailedError e;
        
        private boolean running=true;
        
        public final void run()
        {
            try {
                test();
            } catch (AssertionFailedError e) {
                e.printStackTrace();
                this.e=e;
            } catch (Throwable e) {
                e.printStackTrace();
                e=new AssertionFailedError("Exception:"+e);
            } finally {
                synchronized(this) {
                    running=false;
                    notifyAll();
                }
            }
        }
        
        public void join()
        {
            synchronized(this) {
                while(running) {
                    try {
                        wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
            testAsserts();
        }
        
        public void testAsserts()
        {
            if (e!=null) throw(e);
        }
        
        public abstract void test() throws Throwable; 
    }
    
    private Robot r;
    
    public void sleep(int time)
    {
        try {
            Thread.sleep(time);
        } catch (InterruptedException ex) { }
    }

    public void teatDown()
    {
    }
    
    public Point getAbsolute(AbstractControl l,boolean w,boolean h)
    {
        return getAbsolute(l,w?1.0:0.0,h?1.0:0.0);
    }

    public Point getAbsolute(AbstractControl l,double w,double h)
    {
        Component c = l.getComponent();
        Point p =c.getLocationOnScreen();
        Dimension d = c.getSize();
        p.x+=d.width*w;
        p.y+=d.height*h;
        return p;
    }
    
    public Robot getRobot()
    {
        if (r==null) {
            r = new Robot();
        }
        return r;
    }

    public static class DelayedRunnable implements Runnable
    {
        private int delay;
        private Runnable task;
       
        
        public DelayedRunnable(int delay,Runnable task) {
            this.delay=delay;
            this.task=task;
        }

        @Override
        public void run() {
            try {
                Thread.sleep(delay);
            } catch (InterruptedException ex) { }
            task.run();
        }
    }

    public Thread run(Runnable r,int delay) {
        return run(new DelayedRunnable(delay,r));
    }
    
    public Thread run(Runnable r) {
        Thread t = new Thread(r);
        t.start();
        return t;
    }
    
    public void waitForEventQueueToCatchup()
    {
        ClarionEventQueue.getInstance().setRecordState(false,"test");
        try {
            Thread.sleep(100);
            EventQueue.invokeAndWait(new Runnable() {
                @Override
                public void run() {
                } } );
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    	if (factory!=null) factory.waitIdle();
    }
    
}
