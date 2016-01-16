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


import java.awt.Container;
import java.awt.event.KeyEvent;
import java.lang.reflect.InvocationTargetException;

import javax.swing.JLabel;
import javax.swing.SwingUtilities;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.notify.EventNotifier;
import org.jclarion.clarion.constants.*;


public class ClarionApplicationTest extends SwingTC {

    public ClarionApplicationTest(String name) {
        super(name);
    }

    public void testNotify() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();
        
        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        waitForEventQueueToCatchup();
        
        EventNotifier.getInstance().info("There is some message");
        
        sleep(2500);
        
        EventNotifier.getInstance().shutdown();
        
        ca.close();
    }    
    
    public void testStatusBar() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setStatus(100,50,-1,20);
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();
        
        ca.setProperty(Prop.STATUSTEXT,1,"Hello");
        ca.setProperty(Prop.STATUSTEXT,2,"World");
        
        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();
        
        waitForEventQueueToCatchup();
        
        Container sb;
        
        sb = cc(ca).getStatusPane().getStatusBar();
        assertEquals(4,sb.getComponentCount());
        assertEquals("Hello",((JLabel)sb.getComponent(0)).getText());
        assertEquals("World",((JLabel)sb.getComponent(1)).getText());
        assertEquals(cc(ca).widthDialogToPixels(50),sb.getComponent(1).getWidth());

        ca.setProperty(Prop.STATUS,2,40);
        CWin.display();
        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(cc(ca).widthDialogToPixels(40),sb.getComponent(1).getWidth());

        ca.setProperty(Prop.STATUSTEXT,2,"Big World");
        CWin.display();
        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals("Big World",((JLabel)sb.getComponent(1)).getText());
        
        // try trimming it back
        ca.setProperty(Prop.STATUS,3,0);
        CWin.display();        
        waitForEventQueueToCatchup();
        CWin.display();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(2,sb.getComponentCount());
        
        final ClarionWindow w1 = new ClarionWindow();
        w1.setMDI();
        w1.setSystem();
        w1.setStatus(20,-1);
        w1.setAt(0,0,100,150);
        w1.setText("Window A");
        w1.setProperty(Prop.STATUSTEXT,2,"Status Window A");
        
        Runnable r1 = new Runnable() {

            @Override
            public void run() {
                w1.open();
                while (w1.accept()) {
                    w1.consumeAccept();
                }
                w1.close();
            }
        };
        Thread t1=new Thread(r1);
        t1.start();

        Thread.sleep(500);
        
        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(2,sb.getComponentCount());
        assertEquals("Status Window A",((JLabel)sb.getComponent(1)).getText());
        
        w1.post(Event.CLOSEWINDOW);
        t1.join();

        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(2,sb.getComponentCount());
        assertEquals("Big World",((JLabel)sb.getComponent(1)).getText());

        t1=new Thread(r1);
        t1.start();

        Thread.sleep(500);

        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(2,sb.getComponentCount());
        assertEquals("Status Window A",((JLabel)sb.getComponent(1)).getText());
        
        final ClarionWindow w2 = new ClarionWindow();
        w2.setMDI();
        w2.setSystem();
        w2.setStatus(20,-1);
        w2.setAt(150,0,100,150);
        w2.setText("Window B");
        w2.setProperty(Prop.STATUSTEXT,2,"Status Window B");
        
        Runnable r2 = new Runnable() {

            @Override
            public void run() {
                w2.open();
                while (w2.accept()) {
                    w2.consumeAccept();
                }
                w2.close();
            }
        };
        Thread t2=new Thread(r2);
        t2.start();

        Thread.sleep(500);

        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(2,sb.getComponentCount());
        assertEquals("Status Window B",((JLabel)sb.getComponent(1)).getText());
        
        getRobot().mousePress(cc(w1).getWindow());
        getRobot().mouseRelease();

        waitForEventQueueToCatchup();
        sb = cc(ca).getStatusPane().getStatusBar(); 
        assertEquals(2,sb.getComponentCount());
        assertEquals("Status Window A",((JLabel)sb.getComponent(1)).getText());
        
        ca.close();
        t1.join();
        t2.join();
    }

    public void testSelectChangeToAnotherWindow() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                ButtonControl bc = new ButtonControl();
                bc.setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                EntryControl ec = new EntryControl();
                ec.setText("@s20").setAt(0,0,100,20);
                ec.use(new ClarionString(20));
                cw.add(ec);
                

                cw.open();
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();
                
                CWin.select(ec.getUseID());

                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(ec.getUseID(),CWin.field());
                cw.consumeAccept();
                
                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }

    public void xtestMultipleButtonPressesAreEaten() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                ButtonControl bc = new ButtonControl();
                bc.setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                cw.open();
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                getRobot().key(KeyEvent.VK_ENTER);
                getRobot().key(KeyEvent.VK_ENTER);
                getRobot().sleep();
                sleep(100);
                
                assertTrue(cw.accept());
                assertEquals(Event.ACCEPTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();


                sleep(100);
                
                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);

                assertTrue(bc.getComponent().hasFocus());

                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }

    public void xtestMultipleAlertsAreEaten() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                ButtonControl bc = new ButtonControl();
                bc.setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                cw.open();
                
                CWin.alert(Constants.F4KEY);
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                sleep(100);
                getRobot().key(KeyEvent.VK_F4);
                getRobot().key(KeyEvent.VK_F4);
                getRobot().key(KeyEvent.VK_F4);
                getRobot().sleep();
                sleep(100);
                
                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(Constants.F4KEY,CWin.keyCode());
                cw.consumeAccept();
                
                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(Constants.F4KEY,CWin.keyCode());
                cw.consumeAccept();


                sleep(100);
                
                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);

                assertTrue(bc.getComponent().hasFocus());

                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }
    
    
    public void testDefaultButtonIsRemembered() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                EntryControl ec = new EntryControl();
                ec.setText("@s20").setAt(0,0,100,20);
                ec.use(new ClarionString(20));
                cw.add(ec);
                
                ButtonControl bc = new ButtonControl();
                bc.setDefault().setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                cw.open();
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(ec.getUseID(),CWin.field());
                cw.consumeAccept();

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);
                
                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ACCEPTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                
                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                
                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);

                assertTrue(cc(bc).getComponent().hasFocus());

                sleep(100);
                getRobot().key(KeyEvent.VK_TAB);
                sleep(100);

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(ec.getUseID(),CWin.field());
                cw.consumeAccept();
                
                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ACCEPTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }

    
    public void testDefaultButtonIsRememberedWithAlertedEnterKey() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                EntryControl ec = new EntryControl();
                ec.setText("@s20").setAt(0,0,100,20);
                ec.use(new ClarionString(20));
                cw.add(ec);
                
                ButtonControl bc = new ButtonControl();
                bc.setDefault().setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                cw.open();
                
                CWin.alert(Constants.ENTERKEY);
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(ec.getUseID(),CWin.field());
                cw.consumeAccept();

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);
                
                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                //cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ACCEPTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                
                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);

                assertTrue(cc(bc).getComponent().hasFocus());

                sleep(100);
                getRobot().key(KeyEvent.VK_TAB);
                sleep(100);

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(ec.getUseID(),CWin.field());
                cw.consumeAccept();
                
                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);

                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                //cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();
                
                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ACCEPTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }

    public void testDefaultButtonSupressedWithAlert() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                EntryControl ec = new EntryControl();
                ec.setText("@s20").setAt(0,0,100,20);
                ec.use(new ClarionString(20));
                cw.add(ec);
                
                ButtonControl bc = new ButtonControl();
                bc.setDefault().setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                cw.open();
                
                CWin.alert(Constants.ENTERKEY);
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(ec.getUseID(),CWin.field());
                cw.consumeAccept();

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);
                
                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                
                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);

                assertTrue(cc(ec).getComponent().hasFocus());

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);

                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();
                
                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }

    public void testButtonSupressedWithAlert() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                
                ButtonControl bc = new ButtonControl();
                bc.setText("Button").setAt(0,30,null,null);
                cw.add(bc);

                cw.open();
                
                CWin.alert(Constants.ENTERKEY);
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.SELECTED,CWin.event());
                assertEquals(bc.getUseID(),CWin.field());
                cw.consumeAccept();

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);
                
                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                
                ClarionWindow cw2 = new ClarionWindow();
                cw2.setAt(30,40,100,100);
                cw2.setText("Sub window");
                cw2.setMDI();
                
                cw2.open();
                
                assertTrue(cw2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw2.consumeAccept();
                
                sleep(100);
                
                cw2.close();

                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);

                sleep(100);
                getRobot().key(KeyEvent.VK_ENTER);
                sleep(100);

                assertTrue(cw.accept());
                assertEquals(Event.PREALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();

                assertTrue(cw.accept());
                assertEquals(Event.ALERTKEY,CWin.event());
                assertEquals(0,CWin.field());
                cw.consumeAccept();
                
                cw.setTimer(10);
                assertTrue(cw.accept());
                assertEquals(Event.TIMER,CWin.event());
                cw.consumeAccept();
                cw.setTimer(0);
                
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }
    
    
    public void testMaximizeRace() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                ClarionWindow cw = new ClarionWindow();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                cw.open();
                cw.add((new ButtonControl()).setText("Button").setAt(0,0,null,null));
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();
                

                for (int scan=0;scan<20;scan++) {
                    Thread.sleep(50);
                    
                    Thread t = new Thread() {
                        public void run()
                        {
                            for (int scan=0;scan<20;scan++) {
                                getRobot().key(KeyEvent.VK_ENTER);
                                try {
                                    Thread.sleep(5);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    };
                    t.start();
                    

                    ClarionWindow cw2 = new ClarionWindow();
                    cw2.setAt(20,30,100,100);
                    cw2.setText("Sub window");
                    cw2.setMDI();
                    cw2.setMaximize();
                    cw2.add((new ButtonControl()).setText("Button").setAt(0,0,null,null));
                    cw2.open();
                    CWin.alert(Constants.ENTERKEY);
                
                    assertTrue(cw2.accept());
                    assertEquals(Event.OPENWINDOW,CWin.event());
                    cw2.consumeAccept();
                
                    Thread.sleep(50);
                    cw2.close();
                    
                    t.join();
                }
                
                Thread.sleep(100);
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }

    private boolean sync;
    
    public void testPaintRace() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        Thread.sleep(500);
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() throws InterruptedException 
            {
                final ClarionWindow cw = new ClarionWindow();
                cw.setSystem();
                cw.setAt(20,30,100,100);
                cw.setText("Sub window");
                cw.setMDI();
                final ButtonControl bc = new ButtonControl();
                bc.setText("Button").setAt(0,75,70,null); 
                cw.add(bc);
                
                SheetControl sc = new SheetControl();
                sc.setAt(5,5,90,70);
                cw.add(sc);
                sc.addChild( (new TabControl()).setText("Hello"));
                sc.addChild( (new TabControl()).setText("World"));

                cw.open();
                
                assertTrue(cw.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                cw.consumeAccept();
                

                for (int scan=0;scan<20;scan++) {
                    Thread.sleep(50);
                    sync=false;
                    
                    Thread t = new Thread() {
                        public void run()
                        {
                            int scan=0;
                            while (true ) {
                                scan++;
                                //synchronized(monitor) {
                                    if (sync) break;
                                //}
                                cw.setProperty(Prop.TEXT,"Win# "+scan);
                                bc.setProperty(Prop.TEXT,"Butt# "+scan);
                                bc.setProperty(Prop.WIDTH,70+(scan%5));
                                cc(cw).getWindow().repaint();
                                try {
                                    SwingUtilities.invokeAndWait(new Runnable(){ public void run() { } });
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                } catch (InvocationTargetException e) {
                                    e.printStackTrace();
                                }
                            }
                            
                            /*
                            for (int scan=0;scan<50*5;scan++) {
                                for (int s2=0;s2<20;s2++) {
                                    cw.setProperty(Prop.TEXT,"Win# "+scan+"#"+s2);
                                    cw.getWindow().repaint();
                                }
                                try {
                                    Thread.sleep(1);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                            */
                        }
                    };
                    t.start();
                    
                    Thread.sleep(50);

                    ClarionWindow cw2 = new ClarionWindow();
                    cw2.setSystem();
                    cw2.setAt(40,80,100,100);
                    cw2.setText("Sub window");
                    cw2.setMDI();
                    cw2.add((new ButtonControl()).setText("Button").setAt(0,0,null,null));
                    cw2.open();
                    CWin.alert(Constants.ENTERKEY);
                
                    assertTrue(cw2.accept());
                    assertEquals(Event.OPENWINDOW,CWin.event());
                    cw2.consumeAccept();
                
                    Thread.sleep(200);
                    cw2.close();
                    
                    Thread.sleep(50);
                    //synchronized(monitor) {
                    sync=true;
                    //}
        
                    //assertTrue(t.isAlive());
                    
                    t.join();
                }
                
                Thread.sleep(100);
                cw.close();

                Thread.sleep(100);
                
                
            } };

        CRun.start(r);
        r.join();
        
        ca.close();
    }
    
    
    public void testMultiThreadsDifferentTargets()
    {
        final Thread t = Thread.currentThread(); 
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setMax();
        ca.setResize();
        ca.setText("Clarion App Frame");
        ca.open();
        
        assertSame(ca,Clarion.getWindowTarget());
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() {
                assertNull(Clarion.getWindowTarget());
                assertSame(ca,CWin.getInstance().getTarget(t));
            }
        };
        
        CRun.start(r);
        r.join();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        assertSame(ca,Clarion.getWindowTarget());
        
        ca.close();
    }
    

    public void testPostCrossThreadEvents()
    {
        final int tid = CRun.getThreadID();
        
        ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setMax();
        ca.setResize();
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();
        
        assertSame(ca,Clarion.getWindowTarget());
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() {
                assertNull(Clarion.getWindowTarget());
                CWin.post(Event.CLOSEWINDOW,null,tid);
            }
        };
        
        CRun.start(r);
        r.join();

        assertTrue(ca.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        ca.consumeAccept();
        
        assertFalse(ca.accept());
    }

    public void testPostCrossThreadEventsCloseDown()
    {
        final int tid = CRun.getThreadID();
        
        ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,300,300);
        ca.setMax();
        ca.setResize();
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();
        
        assertSame(ca,Clarion.getWindowTarget());
        
        TestRunnable r = new TestRunnable() {
            @Override
            public void test() {
                assertNull(Clarion.getWindowTarget());
                CWin.post(Event.CLOSEDOWN,null,tid);
            }
        };
        
        CRun.start(r);
        r.join();

        assertTrue(ca.accept());
        assertEquals(Event.CLOSEDOWN,CWin.event());
        ca.consumeAccept();
        
        assertFalse(ca.accept());
    }
    
    private ClarionApplication ca;
    
    private class RunFinish extends RuntimeException
    {
        private static final long serialVersionUID = -3159832765744842453L;
    }
    
    private class ThreadedTasks extends Thread
    {
        private RuntimeException e;
        private boolean nextStage;
        private boolean stageCompleted;
        private Runnable segment;
        
        public void next(Runnable r) throws InterruptedException
        {
            send(r);
            finish();
        }
        
        public void send(Runnable r) {
            synchronized(this) {
                nextStage=true;
                stageCompleted=false;
                segment=r;
                notifyAll();
            }
        }
        
        public void finish() throws InterruptedException 
        {
            synchronized(this) {
                while (!stageCompleted) {
                    if (e!=null) throw(e);
                    wait();
                }
            }
        }
        
        private Runnable waitForNext()
        {
            synchronized(this) {
                while (!nextStage) {
                    try {
                        wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                return segment; 
            }
        }
        
        private void notifyDoneNext()
        {
            synchronized(this) {
                nextStage=false;
                stageCompleted=true;
                notifyAll();
            }
        }
        
        public void run()
        {
            try {
         
                while ( true ) {
                    Runnable r = waitForNext();
                    try {
                        r.run();
                    } finally {
                        notifyDoneNext();
                    }
                }
                
            } catch (RuntimeException e) {
                synchronized(this) { 
                    if (e instanceof RunFinish) {
                    } else {
                        this.e=e;
                    }
                    notifyAll();
                }
            }
        }
    }

    public void testCloseWindowWaitsForWindowlessThreads()
    {
    	final int[] test=new int[] { 0,1 } ;
    	
        ca = new ClarionApplication();
        ca.setAt(0,0,500,250);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

        CRun.start(new Runnable() { 
        	public void run() {
        		synchronized(test) {
        			test[0]=CRun.getThreadID();
        			test.notifyAll();
        		}
        		try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				synchronized(test) {
					test[1]=test[1]*2;
				}
        	}
        } 
        );
        
        synchronized(test) {
        	while (test[0]==0) {
        		try {
					test.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
        	}
        }
        
        ca.post(Event.CLOSEWINDOW);
        ca.accept();
        ca.consumeAccept();
        assertEquals(2,test[1]);
        ca.close();
    }

    public void testCloseWindowWaitsForWindowlessThreadsOpensAWindow()
    {
    	final int[] test=new int[] { 0,1 } ;
    	
        ca = new ClarionApplication();
        ca.setAt(0,0,500,250);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();

                
        CRun.start(new Runnable() { 
        	public void run() {
        		synchronized(test) {
        			test[0]=CRun.getThreadID();
        			test.notifyAll();
        		}
        		try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				ClarionWindow cw = new ClarionWindow();
				cw.setText("test");
				cw.setMDI();
				cw.setAt(10,10,100,100);
				cw.open();
				while (cw.accept()) {
					cw.consumeAccept();
				}
				cw.close();

        		try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				synchronized(test) {
					test[1]=test[1]*2;
				}
        	}
        } 
        );
        
        synchronized(test) {
        	while (test[0]==0) {
        		try {
					test.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
        	}
        }
        
        ca.post(Event.CLOSEWINDOW);
        ca.accept();
        ca.consumeAccept();
        assertEquals(2,test[1]);
        ca.close();
    }
    
    public void testCloseWindowTriggersChildCloseDown() throws InterruptedException
    {
        ca = new ClarionApplication();
        ca.setAt(0,0,500,250);
        ca.setText("Clarion App Frame");
        ca.open();

        assertTrue(ca.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        ca.consumeAccept();
        
        ThreadedTasks t = new ThreadedTasks();
        t.start();
        
        ThreadedTasks t2 = new ThreadedTasks();
        t2.start();

        final ClarionWindow w1 = new ClarionWindow();
        w1.setAt(10,10,100,100);
        w1.setText("Child A");
        w1.setMDI();
        
        t.next(new Runnable() {
            @Override
            public void run() {
                w1.open();
                assertTrue(w1.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                w1.consumeAccept();
            } 
         } );

        final ClarionWindow w2 = new ClarionWindow();
        w2.setAt(30,30,100,100);
        w2.setText("Child B");
        w2.setMDI();
        
        t.next(new Runnable() {
            @Override
            public void run() {
                w2.open();
                assertTrue(w2.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                w2.consumeAccept();
            } 
         } );

        final ClarionWindow w3 = new ClarionWindow();
        w3.setAt(100,150,200,100);
        w3.setText("Thread #2");
        w3.setMDI();
        
        t2.next(new Runnable() {
            @Override
            public void run() {
                w3.open();
                assertTrue(w3.accept());
                assertEquals(Event.OPENWINDOW,CWin.event());
                w3.consumeAccept();
            } 
         } );
        
        Thread.sleep(1000);
        
        CWin.post(Event.CLOSEWINDOW);

        assertTrue(ca.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());

        
        // test that no close down is sent right away
        
        t2.next(new Runnable() {
            @Override
            public void run() {
                w3.setTimer(20);
                assertTrue(w3.accept());
                assertEquals(Event.TIMER,CWin.event());
                w3.consumeAccept();
                w3.setTimer(0);
            } 
         } );

        t.next(new Runnable() {
            @Override
            public void run() {
                w2.setTimer(20);
                assertTrue(w2.accept());
                assertEquals(Event.TIMER,CWin.event());
                w2.consumeAccept();
                w2.setTimer(0);
            } 
         } );

        t2.send(new Runnable() {
            @Override
            public void run() {
                assertTrue(w3.accept());
                assertEquals(Event.CLOSEDOWN,CWin.event());
                w3.consumeAccept();
                assertFalse(w3.accept());
                w3.close();
                throw new RunFinish();
            } 
         } );

        t.send(new Runnable() {
            @Override
            public void run() {
                assertTrue(w2.accept());
                assertEquals(Event.CLOSEDOWN,CWin.event());
                w2.consumeAccept();
                assertFalse(w2.accept());

                assertTrue(w1.accept());
                assertEquals(Event.CLOSEDOWN,CWin.event());
                w1.consumeAccept();
                assertFalse(w1.accept());
                throw new RunFinish();
            } 
         } );
        
        Thread.sleep(500);
        
        ca.consumeAccept();
        long start=System.currentTimeMillis();

        t.join();
        t2.join();

        t.finish();
        t2.finish();
        
        t.send(null);
        t2.send(null);
        
        t.join();
        t2.join();
        
        ca.close();
        
        assertTrue(System.currentTimeMillis()-start<500);
    }
}
