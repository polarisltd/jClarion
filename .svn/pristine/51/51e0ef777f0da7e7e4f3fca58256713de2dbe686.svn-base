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
import java.awt.event.KeyEvent;

import javax.swing.JFrame;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;


public class SheetTest extends SwingTC {

    public SheetTest(String name) {
        super(name);
    }
    
    public void testDefaultButtonsInASheet()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,170);

        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);

        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("&Tab 2");
        sheet.add(t2);

        TabControl t3 = new TabControl();
        t3.setText("&Tab 3");
        sheet.add(t3);
        
        EntryControl e1 = new EntryControl();
        e1.setText("@n10.2");
        e1.setAt(5,35,100,20);
        t1.add(e1);

        ButtonControl b1 = new ButtonControl();
        b1.setText("Next >>>");
        b1.setAt(5,60,100,20);
        b1.setDefault();
        t1.add(b1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s20");
        e2.setAt(5,35,100,20);
        t2.add(e2);

        ButtonControl b2 = new ButtonControl();
        b2.setText("Next >>>");
        b2.setAt(5,60,100,20);
        b2.setDisabled();
        b2.setDefault();
        t2.add(b2);
        

        ButtonControl e3 = new ButtonControl();
        e3.setText("Select Child Record");
        e3.setAt(5,35,100,20);
        t3.add(e3);

        ButtonControl b3 = new ButtonControl();
        b3.setText("Finish");
        b3.setAt(5,60,100,20);
        b3.setDefault();
        t3.add(b3);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals("",e1.getUseObject().toString().toString());
        w.consumeAccept();

        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('.');
        getRobot().key('3');
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals("12.3",e1.getUseObject().toString().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        CWin.select(t2.getUseID());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        CWin.enable(b2.getUseID());
        w.consumeAccept();

        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        getRobot().key(KeyEvent.VK_ENTER);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        assertEquals("abc",e2.getUseObject().toString().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b2.getUseID(),CWin.field());
        CWin.select(t3.getUseID());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e3.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.consumeAccept();

        getRobot().key(' ');
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e3.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b3.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b3.getUseID(),CWin.field());
        w.consumeAccept();

        b3.setProperty(Prop.DEFAULT,0);

        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e3.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        getRobot().key(KeyEvent.VK_ENTER);
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e3.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testUnHideInvisibleItem()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,170);
        w.setResize();
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);

        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("&Tab 2");
        sheet.add(t2);
        
        ButtonControl b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,10,null,null);
        t1.add(b);
        
        EntryControl e = new EntryControl();
        e.setPicture("@s20");
        e.setAt(30,10,null,null);
        e.setHidden();
        t2.add(e);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertFalse(((Component)cc(e).getComponent()).isVisible());
        CWin.unhide(e.getUseID());
        assertFalse(((Component)cc(e).getComponent()).isVisible());
        
        w.close();
    }

    public void testChangeAndCloseRace()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,170);
        w.setResize();
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);

        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);

        TabControl t2 = new TabControl();
        t2.setText("&Tab 2");
        sheet.add(t2);
        
        ButtonControl b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,10,null,null);
        t1.add(b);
        
        EntryControl e = new EntryControl();
        e.setPicture("@s20");
        e.setAt(30,10,null,null);
        e.setHidden();
        t2.add(e);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select(sheet.getUseID(),2);
        
        w.close();
    }
    
    public void testFocusBehaviourOnEmptySheets()
    {
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,250,200);
        
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
        ca.waitForActiveState(true,3000);
        
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,170);
        w.setMDI();
        w.setResize();
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);

        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        TabControl t2 = new TabControl();
        t2.setText("&Tab 2");
        sheet.add(t2);

        TabControl t3 = new TabControl();
        t3.setText("&Tab 3");
        sheet.add(t3);

        ClarionString s = new ClarionString("Some crap\nSome more crap\n");
        TextControl tc = new TextControl();
        tc.use(s);
        tc.setAt(5,20,150,100);
        tc.setReadOnly();
        
        ButtonControl b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,150,null,null);
        w.add(b);
        
        w.open();
        
        CWin.alert(Constants.F4KEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        assertSame( ((JFrame) cc(ca).getWindow()).getFocusOwner(),cc(b).getComponent());
        
        CWin.select(t2.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        try {
            Thread.sleep(500);
        } catch (InterruptedException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        
        assertSame( ((JFrame) cc(ca).getWindow()).getFocusOwner(),cc(b).getComponent());

        w.close();
     
        ca.post(Event.CLOSEWINDOW);
        
        try {
            t.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void testSheetWithActiveUseVar()
    {
        try {
            Thread.sleep(200);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(5,5,200,170);
        w.setResize();
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);

        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        TabControl t2 = new TabControl();
        t2.setText("&Tab 2");
        sheet.add(t2);

        TabControl t3 = new TabControl();
        t3.setText("&Tab 3");
        sheet.add(t3);

        ClarionString s = new ClarionString("Some crap\nSome more crap\n");
        TextControl tc = new TextControl();
        tc.use(s);
        tc.setAt(5,20,150,100);
        tc.setReadOnly();
        
        ButtonControl b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,150,null,null);
        w.add(b);
        
        ClarionNumber tab=new ClarionNumber();;
        sheet.use(tab);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        tab.setValue(2);
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        assertEquals(2,sheet.getProperty(Prop.SELSTART).intValue());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        CWin.select(sheet.getUseID(),3);
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();
        
        assertEquals(3,tab.intValue());
        
        w.close();
     
    }
    
    public void testOnSelectGeneratesSelectAndSelectsAll()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        w.setResize();
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);
        
        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        StringControl s1 = new StringControl();
        s1.setText("Name:");
        s1.setAt(5,15,null,null);
        t1.add(s1);

        StringControl s2 = new StringControl();
        s2.setText("Address:");
        s2.setAt(5,29,null,null);
        t1.add(s2);

        EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(40,15,null,null);
        t1.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s30");
        e2.setAt(40,29,null,null);
        t1.add(e2);
        
        
        TabControl t2 = new TabControl();
        t2.setText("T&ab 2");
        sheet.add(t2);
        
        ButtonControl b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,15,null,null);
        t2.add(b);
        
        EntryControl eb = new EntryControl();
        eb.setText("@n$11.2");
        eb.setAt(50,15,null,null);
        t2.add(eb);
        
        TabControl t3 = new TabControl();
        t3.setText("Ta&b 3");
        sheet.add(t3);
        
        GroupControl g = new GroupControl();
        g.setText("Hello");
        g.setAt(5,15,190,100);
        g.setDisabled();
        g.setBoxed();
        //g.setBevel(1,1,null);
        t3.add(g);
        
        ButtonControl b3 = new ButtonControl();
        b3.setText("Press Me");
        b3.setAt(10,25,null,null);
        g.add(b3);

        ButtonControl b5 = new ButtonControl();
        b5.setText("Press Me 2");
        b5.setAt(70,25,null,null);
        b5.setHidden();
        g.add(b5);
        
        OptionControl oc = new OptionControl();
        oc.setAt(20,40,null,null);
        oc.setText("Some Option");
        //oc.setBoxed();
        g.add(oc);
        
        RadioControl r1 = new RadioControl();
        r1.setText("Selection A");
        r1.setAt(30,55,null,null);
        oc.add(r1);
        RadioControl r2 = new RadioControl();
        r2.setText("Selection B");
        r2.setAt(30,70,null,null);
        oc.add(r2);
        
        ButtonControl b4 = new ButtonControl();
        b4.setText("Toggle");
        b4.setAt(10,110,null,null);
        t3.add(b4);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(sheet.getUseID()));
        w.consumeAccept();
        
        assertTrue(e1.getProperty(Prop.VISIBLE).boolValue());
        assertTrue(e2.getProperty(Prop.VISIBLE).boolValue());
        assertTrue(t1.getProperty(Prop.VISIBLE).boolValue());
        assertFalse(t2.getProperty(Prop.VISIBLE).boolValue());
        assertFalse(b4.getProperty(Prop.VISIBLE).boolValue());

        sleep(100);
        getRobot().key('A');
        getRobot().key('N');
        getRobot().key('D');
        getRobot().key('Y');
        
        sleep(100);
        getRobot().key('A',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals("andy",e1.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key('X');
        getRobot().key('Y');
        getRobot().key('Z');
        
        sleep(100);
        getRobot().key('T',KeyEvent.ALT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        assertEquals("",eb.getUseObject().toString());
        assertEquals(1,eb.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,eb.getProperty(Prop.SELEND).intValue());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(100);
        getRobot().key('1');
        getRobot().key('.');
        getRobot().key('2');
        
        sleep(100);
        getRobot().key('B',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        assertEquals("1.2",eb.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(3,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(3,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b4.getUseID(),CWin.field());
        w.consumeAccept();

        
        assertTrue(b4.getProperty(Prop.VISIBLE).boolValue());
        assertTrue(g.getProperty(Prop.VISIBLE).boolValue());
        assertFalse(b5.getProperty(Prop.VISIBLE).boolValue());
        
        sleep(100);
        getRobot().key('A',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice());
        // w.consumeAccept(); force cycle to abort tab change
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        assertEquals(b4.getUseID(),CWin.focus());
        assertEquals(3,CWin.choice(sheet.getUseID()));
        w.consumeAccept();
        w.setTimer(0);

        g.setProperty(Prop.DISABLE,false);
        
        assertTrue(g.getProperty(Prop.VISIBLE).boolValue());
        assertFalse(b5.getProperty(Prop.VISIBLE).boolValue());

        b5.setProperty(Prop.HIDE,false);

        assertTrue(b5.getProperty(Prop.VISIBLE).boolValue());

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b5.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b3.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b4.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b3.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b5.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b4.getUseID(),CWin.field());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b3.getUseID(),CWin.field());
        w.consumeAccept();

        
        sleep(100);
        CWin.select(t2.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        sleep(100);
        CWin.select(r1.getUseID());

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(3,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(3,CWin.choice());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(CWin.getControl(CWin.field()).toString(),r1.getUseID(),CWin.field());
        assertEquals(3,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        CWin.select(sheet.getUseID());

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b3.getUseID(),CWin.field());
        assertEquals(3,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        CWin.select(sheet.getUseID(),2);

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        
        w.close();
    }

    
}
