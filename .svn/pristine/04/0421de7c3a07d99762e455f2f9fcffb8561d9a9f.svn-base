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
import java.awt.Dimension;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;

import javax.swing.JDialog;
import javax.swing.SwingUtilities;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class WindowTest extends SwingTC
{
    private static int TWAIT=500;
    
    public WindowTest(String name) {
        super(name);
    }
    
    private void insertRace() throws InterruptedException
    {
        if (Math.random()<0.3) {
            Thread.sleep(100);
        }
        if (Math.random()<0.3) {
            SwingUtilities.invokeLater(new Runnable() { public void run()
            {
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            });
        }
    }

    private void insertRace(int pos,int scan) throws InterruptedException
    {
        if (pos==scan) {
            Thread.sleep(200);
        }
        if (pos==-scan) {
            SwingUtilities.invokeLater(new Runnable() { public void run()
            {
                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            });
        }
    }
    
    public void testBufferedInput() throws InterruptedException 
    {
        ClarionWindow w = new ClarionWindow();
        w.setAt(0,0,200,100);
        w.setText("Test Window");
        
        EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(5,5,100,20);
        w.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s20");
        e2.setAt(5,30,100,20);
        w.add(e2);

        ButtonControl b3 = new ButtonControl();
        b3.setText("Go");
        b3.setAt(5,55,50,20);
        w.add(b3);
        
        w.open();
        CWin.alert(Constants.ENTERKEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        for (int scan=0;scan<50;scan++) {

            assertTrue(w.accept());
            assertEquals(Event.SELECTED, CWin.event());
            assertEquals(e1.getUseID(), CWin.field());
            w.consumeAccept();

            insertRace();
            getRobot().key('A');
            insertRace();
            getRobot().key('B');
            insertRace();
            getRobot().key('C');
            insertRace();
            getRobot().key(KeyEvent.VK_ENTER);
            insertRace();
            getRobot().key('1');
            insertRace();
            getRobot().key('2');
            insertRace();
            getRobot().key('3');
            insertRace();
            getRobot().key(KeyEvent.VK_ENTER);
            insertRace();

            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.PREALERTKEY, CWin.event());
            w.consumeAccept();

            insertRace();

            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.ALERTKEY, CWin.event());
            CWin.select(e2.getUseID());
            w.consumeAccept();

            insertRace();
            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.ACCEPTED, CWin.event());
            assertEquals(e1.getUseID(), CWin.field());
            assertEquals("abc", e1.getUseObject().toString());
            w.consumeAccept();

            insertRace();
            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.SELECTED, CWin.event());
            assertEquals(e2.getUseID(), CWin.field());
            w.consumeAccept();

            insertRace();
            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.PREALERTKEY, CWin.event());
            w.consumeAccept();

            insertRace();
            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.ALERTKEY, CWin.event());
            CWin.select(b3.getUseID());
            w.consumeAccept();

            insertRace();
            assertTrue(w.accept());
            insertRace();
            assertEquals(Event.ACCEPTED, CWin.event());
            assertEquals(e2.getUseID(), CWin.field());
            assertEquals("123", e2.getUseObject().toString());
            w.consumeAccept();

            assertTrue(w.accept());
            assertEquals(Event.SELECTED, CWin.event());
            assertEquals(b3.getUseID(), CWin.field());
            w.consumeAccept();

            w.setTimer(10);
            assertTrue(w.accept());
            assertEquals(Event.TIMER, CWin.event());
            w.consumeAccept();
            w.setTimer(0);

            assertEquals("abc", e1.getUseObject().toString());
            assertEquals("123", e2.getUseObject().toString());

            e1.getUseObject().setValue("");
            e2.getUseObject().setValue("");
            getRobot().key(KeyEvent.VK_TAB);
        }
        
        w.close();
    }

    public void testBufferedInput2() throws InterruptedException 
    {
        ClarionWindow w = new ClarionWindow();
        w.setAt(0,0,200,100);
        w.setText("Test Window");
        
        EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(5,5,100,20);
        w.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s20");
        e2.setAt(5,30,100,20);
        w.add(e2);

        ButtonControl b3 = new ButtonControl();
        b3.setText("Go");
        b3.setAt(5,55,50,20);
        w.add(b3);
        
        w.open();
        CWin.alert(Constants.ENTERKEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        for (int scan=-22;scan<=22;scan++) {

            assertTrue(w.accept());
            assertEquals(Event.SELECTED, CWin.event());
            assertEquals(e1.getUseID(), CWin.field());
            w.consumeAccept();

            insertRace(1,scan);
            getRobot().key('A');
            insertRace(2,scan);
            getRobot().key('B');
            insertRace(3,scan);
            getRobot().key('C');
            insertRace(4,scan);
            getRobot().key(KeyEvent.VK_ENTER);
            insertRace(5,scan);
            getRobot().key('1');
            insertRace(6,scan);
            getRobot().key('2');
            insertRace(7,scan);
            getRobot().key('3');
            insertRace(8,scan);
            getRobot().key(KeyEvent.VK_ENTER);
            insertRace(9,scan);

            assertTrue(w.accept());
            insertRace(10,scan);
            assertEquals(Event.PREALERTKEY, CWin.event());
            w.consumeAccept();

            insertRace(11,scan);

            assertTrue(w.accept());
            insertRace(12,scan);
            assertEquals(Event.ALERTKEY, CWin.event());
            CWin.select(e2.getUseID());
            w.consumeAccept();
            
            insertRace(13,scan);
            assertTrue(w.accept());
            insertRace(14,scan);
            assertEquals(Event.ACCEPTED, CWin.event());
            assertEquals(e1.getUseID(), CWin.field());
            assertEquals("abc", e1.getUseObject().toString());
            w.consumeAccept();

            insertRace(15,scan);
            assertTrue(w.accept());
            insertRace(16,scan);
            assertEquals(Event.SELECTED, CWin.event());
            assertEquals(e2.getUseID(), CWin.field());
            w.consumeAccept();

            insertRace(17,scan);
            assertTrue(w.accept());
            insertRace(18,scan);
            assertEquals(Event.PREALERTKEY, CWin.event());
            w.consumeAccept();

            insertRace(19,scan);
            assertTrue(w.accept());
            insertRace(20,scan);
            assertEquals(Event.ALERTKEY, CWin.event());
            CWin.select(b3.getUseID());
            w.consumeAccept();

            insertRace(21,scan);
            assertTrue(w.accept());
            insertRace(22,scan);
            assertEquals(Event.ACCEPTED, CWin.event());
            assertEquals(e2.getUseID(), CWin.field());
            assertEquals("123", e2.getUseObject().toString());
            w.consumeAccept();

            assertTrue(w.accept());
            assertEquals(Event.SELECTED, CWin.event());
            assertEquals(b3.getUseID(), CWin.field());
            w.consumeAccept();

            w.setTimer(10);
            assertTrue(w.accept());
            assertEquals(Event.TIMER, CWin.event());
            w.consumeAccept();
            w.setTimer(0);

            assertEquals("abc", e1.getUseObject().toString());
            assertEquals("123", e2.getUseObject().toString());

            e1.getUseObject().setValue("");
            e2.getUseObject().setValue("");
            getRobot().key(KeyEvent.VK_TAB);
        }
        
        w.close();
    }


    public void testBufferedInput3() throws InterruptedException 
    {
        ClarionWindow w = new ClarionWindow();
        w.setAt(0,0,200,100);
        w.setText("Test Window");
        
        EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(5,5,100,20);
        w.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s20");
        e2.setAt(5,30,100,20);
        w.add(e2);

        ButtonControl b3 = new ButtonControl();
        b3.setText("Go");
        b3.setAt(5,55,50,20);
        w.add(b3);
        
        w.open();
        CWin.alert(Constants.ENTERKEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(e1.getUseID(), CWin.field());
        w.consumeAccept();

        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        getRobot().key(KeyEvent.VK_ENTER);
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY, CWin.event());
        CWin.select(e2.getUseID());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(e1.getUseID(), CWin.field());
        assertEquals("abc", e1.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(e2.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY, CWin.event());
        CWin.select(b3.getUseID());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(e2.getUseID(), CWin.field());
        assertEquals("123", e2.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(b3.getUseID(), CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        assertEquals("abc", e1.getUseObject().toString());
        assertEquals("123", e2.getUseObject().toString());

        w.close();
    }


    
    
    public void testCtrlTAlert() 
    {
        ClarionWindow w = new ClarionWindow();
        w.setAt(0,0,200,100);
        w.setText("Test Window");
        
        EntryControl ec = new EntryControl();
        ec.setText("@s20");
        ec.setAt(5,5,100,20);
        
        w.add(ec);
        w.open();
        CWin.alert(0x254);

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();

        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key('T',KeyEvent.CTRL_MASK);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(0x254,CWin.keyCode());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(0x254,CWin.keyCode());
        w.consumeAccept();
        
        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        w.close();
    }
    
    public void testFieldDetailsNotLostWhenInChild()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setText("Parent");
        cw.setAt(20,20,50,50);
        ButtonControl cb = new ButtonControl();
        cb.setAt(5,5,40,null);
        cb.setText("Test");
        cw.add(cb);
        
        cw.open();
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        assertEquals(0,CWin.field());
        cw.consumeAccept();

        assertTrue(cw.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cb.getUseID(),CWin.field());
        cw.consumeAccept();
        
        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        assertEquals(0,CWin.field());
        cw.consumeAccept();
        cw.setTimer(0);

        cb.getButton().doClick();

        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cb.getUseID(),CWin.field());
        
        ClarionWindow child = new ClarionWindow();
        child.setText("Child");
        child.setAt(40,40,50,50);
        child.open();

        assertTrue(child.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        assertEquals(0,CWin.field());
        child.consumeAccept();

        child.setTimer(10);
        assertTrue(child.accept());
        assertEquals(Event.TIMER,CWin.event());
        assertEquals(0,CWin.field());
        child.consumeAccept();
        child.setTimer(0);
        
        CWin.post(Event.CLOSEWINDOW);

        assertTrue(child.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        assertEquals(0,CWin.field());
        child.consumeAccept();
        
        assertFalse(child.accept());
        child.close();

        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cb.getUseID(),CWin.field());
        cw.consumeAccept();
        
        cw.close();
    }
    
    public void testSimpleOpenAndClose()
    {
        try {
            Thread.sleep(500);
        } catch (InterruptedException e1) {
            e1.printStackTrace();
        }

        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        w.close();

        assertFalse(w.accept());
    }

    public void testFocusOnNextAvailable()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setResize();

        EntryControl e[] = new EntryControl[5];
        for (int scan=0;scan<5;scan++) {
            e[scan]=new EntryControl();
            e[scan].setAt(5,scan*30+5,100,25);
            e[scan].setPicture("@s20");
            if (scan%2==1) e[scan].setDisabled();
            w.add(e[scan]);
            e[scan].getUseID();
        }
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[0].getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(CWin.focus()+1);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[2].getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(e[3].getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[4].getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
        
    }

    public void testFocusOnNextAvailableHidden()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setResize();

        EntryControl e[] = new EntryControl[5];
        for (int scan=0;scan<5;scan++) {
            e[scan]=new EntryControl();
            e[scan].setAt(5,scan*30+5,100,25);
            e[scan].setPicture("@s20");
            if (scan%2==1) e[scan].setHidden();
            w.add(e[scan]);
            e[scan].getUseID();
        }
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[0].getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(CWin.focus()+1);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[2].getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(e[3].getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[4].getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
        
    }

    public void testFocusOnNextAvailableHiddenWithInterveningGroup()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setResize();

        EntryControl e[] = new EntryControl[5];
        PromptControl p[] = new PromptControl[5];
        for (int scan=0;scan<5;scan++) {

            GroupControl gc = new GroupControl();
            gc.setAt(0,0,180,scan*40+35);
            gc.setBoxed();
            w.add(gc);
            gc.getUseID();
            
            PromptControl pc = new PromptControl();
            pc.setText("hello");
            pc.setAt(140,scan*40,null,null);
            gc.add(pc);
            pc.getUseID();
            p[scan]=pc;
            
            e[scan]=new EntryControl();
            e[scan].setAt(5,scan*40+5,100,25);
            e[scan].setPicture("@s20");
            if (scan%2==1) e[scan].setDisabled();
            if (scan%2==1) gc.setHidden();
            w.add(e[scan]);
            e[scan].getUseID();
        }
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[0].getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(CWin.focus()+1);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[2].getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(p[3].getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e[4].getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
        
    }
    
    public void testResize() throws InterruptedException
    {
        try {
            Thread.sleep(500);
        } catch (InterruptedException e1) {
            e1.printStackTrace();
        }
        
        AbstractWindowTarget.suppressWindowSizingEvents=false;
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setResize();
        w.setImmediate();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        Container c = (Container)w.getWindow();
        Dimension d = c.getSize();
        
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        getRobot().mousePress(c,d.width-2,d.height-2,MouseEvent.BUTTON1_MASK);
        Thread.sleep(100);
        getRobot().mouseMove(c,d.width+w.getFontWidth()*10/4,d.height+w.getFontHeight()*15/8);
        Thread.sleep(100);
        getRobot().mouseRelease();


        assertTrue(w.accept());
        if (CWin.event()==Event.MOVED) {
            w.consumeAccept();
            assertTrue(w.accept());
        }
        
        assertEquals(Event.SIZED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(100);
        while (w.accept()) {
            if (CWin.event()==Event.TIMER) break;
            assertTrue(CWin.event() == Event.SIZED || CWin.event() == Event.MOVED);
            w.consumeAccept();
        }
        w.consumeAccept();
        w.setTimer(0);
        
        int wi = w.getProperty(Prop.WIDTH).intValue();
        int he = w.getProperty(Prop.HEIGHT).intValue();
        
        assertTrue(""+wi,Math.abs(wi-510)<=2);
        assertTrue(""+he,Math.abs(he-265)<=2);
        
        w.close();
        
    }

    public void testPreSelect()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        w.register(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        w.register(e);
        
        w.open();
        
        CWin.select(e.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }

    public void testSkipKeyFocus()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        b.setSkip();
        w.add(b);
        w.register(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        w.register(e);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    public void testOpenNewWindowOnSelect() throws InterruptedException
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        SheetControl sc = new SheetControl();
        sc.setAt(1,1,490,230);
        w.add(sc);
        
        TabControl t1 = new TabControl();
        t1.setText("tab 1");
        sc.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("tab 2");
        sc.add(t2);
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        t1.add(b);
        w.register(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        t2.add(e);
        w.register(e);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        Thread.sleep(TWAIT);
        
        CWin.select(e.getUseID());

        ClarionWindow w2 = new ClarionWindow();
        w2.setText("Child");
        w2.setAt(null,null,300,150);
        w2.setCenter();
        
        w2.open();

        assertTrue(w2.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w2.consumeAccept();

        Thread.sleep(TWAIT);
        
        getRobot().key(KeyEvent.VK_ESCAPE);

        assertTrue(w2.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w2.consumeAccept();
        
        w2.close();
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        Thread.sleep(TWAIT);

        getRobot().key(KeyEvent.VK_ESCAPE);

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();

        w.close();
    }    

    public void testMDIColor() throws InterruptedException
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,250,200);
        ca.setMaximize();
        
        Runnable r=new Runnable() {
            @Override
            public void run() {
                ca.open();
                while (Clarion.getWindowTarget().accept()) {
                    Clarion.getWindowTarget().consumeAccept();
                }
                ca.close();
            }
        };
        
        Thread t = new Thread(r);
        t.start();
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        ClarionWindow w = new ClarionWindow();
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setMDI();
        w.setColor(0xff0000,null,null);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        Thread.sleep(TWAIT);
        
        w.close();
        
        ca.post(Event.CLOSEWINDOW);
        
        try {
            t.join();
        } catch (InterruptedException ex) {
            // TODO Auto-generated catch block
            ex.printStackTrace();
        }
        
    }

    public void testOpenNewWindowOnSelectInMDIContext() throws InterruptedException
    {
        
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,250,200);
        //ca.setMaximize();
        
        Runnable r=new Runnable() {
            @Override
            public void run() {
                
                try {
                
                ca.open();
                while (Clarion.getWindowTarget().accept()) {
                    Clarion.getWindowTarget().consumeAccept();
                }
                ca.close();
                
                } catch (Throwable t) {
                    t.printStackTrace();
                }
            }
        };
        
        Thread t = new Thread(r);
        t.start();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        ClarionWindow w = new ClarionWindow();
        w.setMDI();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl m = new EntryControl();
        m.setPicture("@s2");
        m.setAt(2,2,100,10);
        w.add(m);
        
        SheetControl sc = new SheetControl();
        sc.setAt(1,20,490,230);
        w.add(sc);
        
        TabControl t1 = new TabControl();
        t1.setText("tab 1");
        sc.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("tab 2");
        sc.add(t2);

        EntryControl b = new EntryControl();
        b.setPicture("@s10");
        b.setAt(20,40,100,30);
        t1.add(b);
        w.register(b);

        EntryControl e = new EntryControl();
        e.setText("@s15");
        e.setAt(20,60,100,30);
        t2.add(e);
        w.register(e);

        EntryControl e2 = new EntryControl();
        e2.setText("@s5");
        e2.setAt(20,100,100,30);
        t2.add(e2);
        w.register(e2);

        EntryControl e3 = new EntryControl();
        e3.setText("@s6");
        e3.setAt(20,140,100,30);
        t2.add(e3);
        w.register(e3);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(m.getUseID(),CWin.field());
        w.consumeAccept();
        
        CWin.select(b.getUseID());

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        Thread.sleep(TWAIT);

        CWin.select(e.getUseID());

        ClarionWindow w2 = new ClarionWindow();
        w2.setMDI();
        w2.setText("Child");
        w2.setAt(null,null,300,150);
        w2.setCenter();

        EntryControl b1 = new EntryControl();
        b1.setPicture("@s20");
        b1.setAt(20,20,100,30);
        w2.add(b1);
        
        w2.open();

        assertTrue(w2.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w2.consumeAccept();

        assertTrue(w2.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w2.consumeAccept();
        
        Thread.sleep(TWAIT);
        
        
        getRobot().key(KeyEvent.VK_ESCAPE);

        assertTrue(w2.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w2.consumeAccept();

        w2.close();

        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        Thread.sleep(TWAIT);
        
        getRobot().key(KeyEvent.VK_ESCAPE);

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        
        w.close();
        
        ca.post(Event.CLOSEWINDOW);
        
        try {
            t.join();
        } catch (InterruptedException ex) {
            // TODO Auto-generated catch block
            ex.printStackTrace();
        }
        
    }

    public void testSheetRemembersFocusOnRegain() throws InterruptedException
    {
        
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,600,300);
        //ca.setMaximize();
        
        Runnable r=new Runnable() {
            @Override
            public void run() {
                
                try {
                
                ca.open();
                while (Clarion.getWindowTarget().accept()) {
                    Clarion.getWindowTarget().consumeAccept();
                }
                ca.close();
                
                } catch (Throwable t) {
                    t.printStackTrace();
                }
            }
        };
        
        Thread t = new Thread(r);
        t.start();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        ClarionWindow w = new ClarionWindow();
        w.setMDI();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl m = new EntryControl();
        m.setPicture("@s2");
        m.setAt(2,2,100,10);
        w.add(m);

        SheetControl sc = new SheetControl();
        sc.setAt(1,20,490,230);
        w.add(sc);
        
        TabControl t1 = new TabControl();
        t1.setText("tab 1");
        sc.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("tab 2");
        sc.add(t2);

        EntryControl b = new EntryControl();
        b.setPicture("@s10");
        b.setAt(20,40,100,30);
        t1.add(b);
        w.register(b);

        EntryControl b2 = new EntryControl();
        b2.setPicture("@s10");
        b2.setAt(20,75,100,30);
        t1.add(b2);
        w.register(b2);

        EntryControl e = new EntryControl();
        e.setText("@s15");
        e.setAt(20,60,100,30);
        t2.add(e);
        w.register(e);

        EntryControl e2 = new EntryControl();
        e2.setText("@s5");
        e2.setAt(20,100,100,30);
        t2.add(e2);
        w.register(e2);

        EntryControl e3 = new EntryControl();
        e3.setText("@s6");
        e3.setAt(20,140,100,30);
        t2.add(e3);
        w.register(e3);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(m.getUseID(),CWin.field());
        w.consumeAccept();
        
        CWin.select(b.getUseID());

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(e.getUseID());

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();
        
        ClarionWindow w2 = new ClarionWindow();
        w2.setMDI();
        w2.setText("Child");
        w2.setAt(null,null,300,150);
        w2.setCenter();

        EntryControl b1 = new EntryControl();
        b1.setPicture("@s20");
        b1.setAt(20,20,100,30);
        w2.add(b1);
        
        w2.open();

        assertTrue(w2.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w2.consumeAccept();

        assertTrue(w2.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w2.consumeAccept();
        
        Thread.sleep(TWAIT);
        
        
        getRobot().key(KeyEvent.VK_ESCAPE);

        assertTrue(w2.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w2.consumeAccept();

        w2.close();
        
        e.getUseObject().setValue("a");

        CWin.getTarget(); // force prior window to restore
        
        sleep(TWAIT);
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();
        
        java.awt.Container c = CWin.getWindowTarget().getWindow();
        java.awt.FocusTraversalPolicy f = c.getFocusTraversalPolicy();
        java.awt.Component start = f.getFirstComponent(c);
        java.awt.Component scan=start;
        javax.swing.JInternalFrame jif = (javax.swing.JInternalFrame)c;
        System.out.println(jif.getFocusOwner());
        while (scan!=null) {
            System.out.println(scan);
            scan=f.getComponentAfter(c,scan);
            if (scan==null || scan==start) break;
        }
        
        w.close();
        
        ca.post(Event.CLOSEWINDOW);
        
        try {
            t.join();
        } catch (InterruptedException ex) {
            // TODO Auto-generated catch block
            ex.printStackTrace();
        }
        
    }
    
    
    public void testPreSelectWhichTriggersTabChange()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        SheetControl sc = new SheetControl();
        sc.setAt(1,1,490,230);
        w.add(sc);
        
        TabControl t1 = new TabControl();
        t1.setText("tab 1");
        sc.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("tab 2");
        sc.add(t2);
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        t1.add(b);
        w.register(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        t2.add(e);
        w.register(e);
        
        w.open();
        
        CWin.select(e.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        
        if (CWin.event()==Event.SELECTED) {
            assertEquals(b.getUseID(),CWin.field());
            w.consumeAccept();
            assertTrue(w.accept());
        }
        
        assertEquals(Event.TABCHANGING,CWin.event());
        w.consumeAccept();

        if (CWin.event()==Event.SELECTED) {
            assertEquals(b.getUseID(),CWin.field());
            w.consumeAccept();
            assertTrue(w.accept());
        }
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }
    
    public void testRegisterEvent()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        final java.util.List<Integer> events=new java.util.ArrayList<Integer>();
        w.open();
        CWin.register(Event.TIMER,
        new Runnable() {
            @Override
            public void run() {
                events.add(1);
            } } 
        , 5);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        w.setTimer(10);
        
        for (int i=0;i<5;i++) {
            assertTrue(w.accept());
            assertEquals(Event.TIMER,CWin.event());
        }

        CWin.unregister(Event.TIMER,null,5);

        for (int i=0;i<5;i++) {
            assertTrue(w.accept());
            assertEquals(Event.TIMER,CWin.event());
        }
        
        w.close();
        assertFalse(w.accept());
        
        assertEquals(5,events.size());
    }
    
    public void testAbortedOpen()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        
        assertFalse(w.accept());
        
        w.close();
    }

    public void testTimer()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setTimer(1);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        
        w.close();

        assertFalse(w.accept());
    }

    public void testUserClose()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        sleep(TWAIT);
        
        Thread t = run(new Runnable() {
            @Override
            public void run() {
                getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);
                try {
                    Thread.sleep(20);
                } catch (InterruptedException ex) { }
            } 
        },300);
        
        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        
        assertFalse(w.accept());
        w.close();

        assertFalse(w.accept());
        
        try {
            t.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void testUserCloseAborted()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        sleep(TWAIT);

        Thread t1=run(new Runnable() {
            @Override
            public void run() {
                getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);
            } 
        },100);
        
        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());

        Thread t2=run(new Runnable() {
            @Override
            public void run() {
                getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);
            } 
            
        },500);
        
        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();

        assertFalse(w.accept());
        w.close();

        assertFalse(w.accept());
        
        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    public void testProgrammaticClose()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setTimer(10);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        CWin.post(Event.CLOSEWINDOW);

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();

        assertFalse(w.accept());
        w.close();

        assertFalse(w.accept());
    }

    public void testProgrammaticCloseAborted()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.setTimer(10);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        CWin.post(Event.CLOSEWINDOW);

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());

        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());

        w.close();

        assertFalse(w.accept());
    }

    public void testProgrammaticChangeTitle()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.setProperty(Prop.TEXT,"New Hello World");
        w.consumeAccept();
        
        waitForEventQueueToCatchup();

        assertEquals("New Hello World",((JDialog)w.getWindow()).getTitle());

        w.close();

        assertFalse(w.accept());
    }

    public void testProgrammaticChangeTitleAfterOpen()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        w.setProperty(Prop.TEXT,"New Hello World");

        waitForEventQueueToCatchup();
        
        assertEquals("New Hello World",((JDialog)w.getWindow()).getTitle());

        w.close();

        assertFalse(w.accept());
    }

    public void testClarionStaticMethods()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        w.register(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        w.register(e);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertSame(w,Clarion.getControl(0));
        assertSame(e,Clarion.getControl(e.getUseID()));
        assertSame(w,CWin.getTarget());
        assertEquals(2,CWin.getLastField());
        
        w.close();

    }

    public void testAlertDeleteDoesNotAffectDot()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        w.open();
        CWin.alert(Constants.DELETEKEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_DELETE);
        sleep(100);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(Constants.DELETEKEY,CWin.keyCode());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(Constants.DELETEKEY,CWin.keyCode());
        w.consumeAccept();

        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(100);
        getRobot().key('.');
        sleep(100);
        
        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(".",e.getProperty(Prop.SCREENTEXT).toString().trim());
        
        w.close();
    }

    public void testAlerKeys()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        
        w.open();
        
        CWin.alert(Constants.F5KEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_F5);

        assertEquals(500,w.getProperty(Prop.WIDTH).intValue());

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(Constants.F5KEY,CWin.keyCode());
        
        assertEquals(500,w.getProperty(Prop.WIDTH).intValue());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(Constants.F5KEY,CWin.keyCode());
        w.consumeAccept();

        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
        
    }


    public void testModifiedAlerKeys()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        
        w.open();
        
        CWin.alert(Constants.F5KEY+0x200);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_F5,KeyEvent.CTRL_MASK);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(Constants.F5KEY+0x200,CWin.keyCode());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(Constants.F5KEY+0x200,CWin.keyCode());
        w.consumeAccept();

        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
        
    }


    public void testAlertKeyAbortedOnPre()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        
        w.open();
        
        CWin.alert(Constants.F5KEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_F5);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(Constants.F5KEY,CWin.keyCode());

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(Constants.F5KEY,CWin.keyCode());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
        
    }

    
    public void testNoAlert()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        
        w.open();
        
        //CWin.alert(Constants.F5KEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_F5);

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
        
    }

    
    
    public void testWrongAlert()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        
        
        w.open();
        
        CWin.alert(Constants.F5KEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_F6);

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
        
    }

    public void testInterceptBlocksControl()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        
        w.open();
        
        CWin.alert(' ');

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');

        sleep(100);

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_SPACE);

        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        w.consumeAccept();

        sleep(100);
        
        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');

        sleep(100);

        getRobot().key(KeyEvent.VK_TAB);
        
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        assertEquals("123abc",e.getUseObject().toString());
        
        
        
        w.close();
        
    }

    public void testAlertsRememberKeycodesCorrectly()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        
        w.open();
        
        CWin.alert('A','Z');

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(200);
        
        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        getRobot().key('D');
        getRobot().key('Z');
        getRobot().key('Y');
        getRobot().key('X');
        getRobot().key('W');

        char keys[] = { 'A', 'B', 'C', 'D', 'Z', 'Y', 'X', 'W' };
        
        for (int scan=0;scan<keys.length;scan++) {
            assertTrue(w.accept());
            assertEquals(Event.PREALERTKEY,CWin.event());
            assertEquals(keys[scan]-'A'+'a',CWin.keyChar());
            assertEquals(keys[scan],CWin.keyCode());

            assertTrue(w.accept());
            assertEquals(Event.ALERTKEY,CWin.event());
            assertEquals(keys[scan]-'A'+'a',CWin.keyChar());
            assertEquals(keys[scan],CWin.keyCode());
            w.consumeAccept();
        }
        

        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        assertEquals("abcdzyxw",e.getUseObject().toString());
        
        w.close();
        
    }
    
    
    public void testInterceptAndCyclePassesToControl()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        
        w.open();
        
        CWin.alert(' ');

        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');

        sleep(100);

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        getRobot().key(' ');

        sleep(100);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.accept();

        sleep(100);
        
        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');

        sleep(100);
        
        getRobot().key(KeyEvent.VK_TAB);
        
        sleep(100);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        assertEquals("123 abc",e.getUseObject().toString());
        
        w.close();
        
    }

    public void testNestedWindows()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Parent");
        w.setAt(null,null,150,100);
        w.setCenter();
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        ClarionWindow w2 = new ClarionWindow();
        w2.setText("Child");
        w2.setAt(null,null,150,100);
        w2.setCenter();
        w2.open();

        assertSame(w2,Clarion.getWindowTarget());
        assertTrue(Clarion.getWindowTarget().accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        Clarion.getWindowTarget().consumeAccept();

        sleep(TWAIT);
        getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);

        assertTrue(Clarion.getWindowTarget().accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        Clarion.getWindowTarget().consumeAccept();
        assertSame(w2,Clarion.getWindowTarget());
        assertFalse(w2.accept());
        w2.close();

        sleep(1009);
        getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);

        
        assertSame(w,Clarion.getWindowTarget());
        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        assertFalse(w.accept());
        w.close();
        assertNull(Clarion.getWindowTarget());
    }

    public void testNestedWindowsNoExplicitClose() throws InterruptedException
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,150,100);
        w.setCenter();
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        Thread.sleep(100);
        
        ClarionWindow w2 = new ClarionWindow();
        w2.setText("Hello Child");
        w2.setAt(null,null,130,80);
        w2.setCenter();
        w2.open();

        assertSame(w2,Clarion.getWindowTarget());
        assertTrue(Clarion.getWindowTarget().accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        Clarion.getWindowTarget().consumeAccept();
        
        Thread.sleep(TWAIT);

        getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);

        assertTrue(Clarion.getWindowTarget().accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        Clarion.getWindowTarget().consumeAccept();
        assertSame(w2,Clarion.getWindowTarget());
        assertFalse(w2.accept());
//      w2.close();

        Thread.sleep(100);
        
        assertSame(w,Clarion.getWindowTarget());
        
        getRobot().sleep();
        Thread.sleep(TWAIT);
        getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);
    
        assertSame(w,Clarion.getWindowTarget());
        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        assertFalse(w.accept());
        assertNull(Clarion.getWindowTarget());
    }

    public void testPostSelectOnOpen()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        CWin.select(b.getUseID());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        CWin.select(e.getUseID());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        CWin.select(b.getUseID());
        w.consumeAccept();

        sleep(100);

        w.close();
    }

    public void testCloseAndReuse()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        ClarionString s=new ClarionString("");
        e.use(s);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        for (int scan=0;scan<4;scan++) {
            
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        CWin.select(e.getUseID());
        w.consumeAccept();

        s.setValue(scan);
        e.setProperty(Prop.XPOS,scan);
        
        sleep(TWAIT);
        getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();

        assertFalse(w.accept());
        
        w.close();

        }
    }

    public void testCloseAndChangeUseVars()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);
        ClarionString s=new ClarionString("");
        e.use(s);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        CWin.select(e.getUseID());
        w.consumeAccept();

        sleep(TWAIT);
        getRobot().key(KeyEvent.VK_F4,KeyEvent.ALT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();

        assertFalse(w.accept());
        
        w.close();
        
        sleep(100);
        
        s.setValue("HELLO");
        e.setProperty(Prop.DISABLE,true);

        
    }
    
    
    public void testGetNonExistantControl()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        EntryControl e = new EntryControl();
        e.setText("@s20");
        e.setAt(20,60,100,30);
        w.add(e);

        ButtonControl b = new ButtonControl();
        b.setText("Some crap");
        b.setAt(20,20,100,30);
        w.add(b);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        CWin.select(b.getUseID());
        w.consumeAccept();

        assertNotNull(Clarion.getControl(100));
        

        w.close();
    }
    
}
