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
import java.awt.event.MouseEvent;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;


public class EntryTest extends SwingTC {

    public EntryTest(String name) {
        super(name);
    }

    public void testChangeOnSelect()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();
        
        ClarionString cs = new ClarionString(15);
        cs.setValue("Hello");
        EntryControl e1 = new EntryControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@s15");
        w.add(e1);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        cs.setValue("This");

        CWin.display();

        assertEquals(1,e1.getProperty(Prop.SELSTART).intValue());
        assertEquals(4,e1.getProperty(Prop.SELEND).intValue());
        
        w.close();
    }
    
    public void testOvertype()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();
        
        ClarionString cs = new ClarionString(15);
        EntryControl e1 = new EntryControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@s15");
        w.add(e1);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();
        
        for (int scan=0;scan<15;scan++) {
            getRobot().key((char)(65+scan));
        }
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        

        assertEquals("abcdefghijklmno",e1.getProperty(Prop.SCREENTEXT).toString());

        for (int scan=0;scan<15;scan++) {
            getRobot().key((char)(65+scan));
        }
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();

        assertEquals("abcdefghijklmno",e1.getProperty(Prop.SCREENTEXT).toString());
        
        getRobot().key(KeyEvent.VK_BACK_SPACE);
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        assertEquals("abcdefghijklmn",e1.getProperty(Prop.SCREENTEXT).toString());
        
        getRobot().key(KeyEvent.VK_LEFT);
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();

        getRobot().key(KeyEvent.VK_LEFT);
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();

        getRobot().key('V');
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        assertEquals("abcdefghijklvmn",e1.getProperty(Prop.SCREENTEXT).toString());

        getRobot().key('W');
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        assertEquals("abcdefghijklvmn",e1.getProperty(Prop.SCREENTEXT).toString());
        
        getRobot().key(KeyEvent.VK_RIGHT,KeyEvent.SHIFT_MASK);
        getRobot().key('X');
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        assertEquals("abcdefghijklvxn",e1.getProperty(Prop.SCREENTEXT).toString());
        
        getRobot().key('Y');
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        assertEquals("abcdefghijklvxn",e1.getProperty(Prop.SCREENTEXT).toString());
        
        w.close();
    }
    
    public void testClickInString()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();

        ButtonControl b = new ButtonControl();
        b.setAt(10,60,100,15);
        b.setText("Button");
        w.add(b);

        ClarionString cs = new ClarionString("abcdefghijklmnopqrstuvwxyz");
        EntryControl e1 = new EntryControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@s30");
        w.add(e1);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().mousePress(e1.getComponent(),100,10);
        getRobot().mouseRelease();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals(15,e1.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e1.getProperty(Prop.SELEND).intValue());
        w.consumeAccept();

        w.close();
    }
    public void testErrorOnInaccessibleComponent()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();


        EntryControl e1 = new EntryControl();
        e1.setAt(5,5,150,15);
        e1.setText("@n$12.2");
        w.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setAt(5,30,150,15);
        e2.setText("@n$12.2");
        w.add(e2);
        
        ButtonControl b = new ButtonControl();
        b.setAt(10,60,100,15);
        b.setText("Button");
        w.add(b);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key('X');
        getRobot().key('X');
        getRobot().key('X');

        sleep(500);
        
        getRobot().sleep();
        waitForEventQueueToCatchup();
        
        e1.setProperty(Prop.HIDE,1);
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key('1');
        getRobot().key('2');
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        e1.setProperty(Prop.HIDE,0);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testErrorOnInaccessibleComponent2()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();


        EntryControl e1 = new EntryControl();
        e1.setAt(5,5,150,15);
        e1.setText("@n$12.2");
        w.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setAt(5,30,150,15);
        e2.setText("@n$12.2");
        w.add(e2);
        
        ButtonControl b = new ButtonControl();
        b.setAt(10,60,100,15);
        b.setText("Button");
        w.add(b);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key('X');
        getRobot().key('X');
        getRobot().key('X');

        sleep(500);
        
        getRobot().sleep();
        waitForEventQueueToCatchup();
        
        e1.setProperty(Prop.DISABLE,1);
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key('1');
        getRobot().key('2');
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        e1.setProperty(Prop.DISABLE,0);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    public void testWidthIsAFunctionOfPictureRepresentation()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        EntryControl s1 = new EntryControl();
        s1.setText("@n$13.2").setAt(20,20,null,null);
        ClarionString cs1 = new ClarionString("1234.56      ");
        s1.setRight(0);
        s1.use(cs1);

        EntryControl s2 = new EntryControl();
        s2.setText("@s13").setAt(20,40,null,null);
        ClarionString cs2 = new ClarionString("0            ");
        s2.setRight(0);
        s2.use(cs2);
        
        StringControl v1 = new StringControl();
        v1.setText("@n$13.2").setAt(20,60,null,null);
        v1.use(cs1);
        v1.setRight(0);
        
        w.add(s1);
        w.add(s2);
        w.add(v1);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(s1.getProperty(Prop.WIDTH).intValue()!=s2.getProperty(Prop.WIDTH).intValue());

        assertTrue(s1.getProperty(Prop.WIDTH).intValue()>20);
        
        assertEquals(s1.getComponent().getWidth(),v1.getComponent().getWidth()+4);
        
        w.close();
    }

    public void testNeg()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal(11,2);
        EntryControl e =  new EntryControl();
        e.setPicture("@n$-11.2b").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        ButtonControl bc = new ButtonControl(); 
        w.add(bc.setText("Button").setAt(20,50,null,null));

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        getRobot().key('-');
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('.');
        getRobot().key('7');

        sleep(100);
        
        getRobot().sleep();
        waitForEventQueueToCatchup();

        getRobot().key(KeyEvent.VK_TAB);

        getRobot().sleep();
        waitForEventQueueToCatchup();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("-12.70",d.toString().trim());
        assertEquals("$-12.70",e.getProperty(Prop.SCREENTEXT).toString());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc.getUseID(),CWin.field());
        w.consumeAccept();

        w.close();
    }
    
    public void testUpper()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(10);
        EntryControl e =  new EntryControl();
        e.setPicture("@s20").setAt(20,20,150,25);
        e.use(s);
        e.setUpper();
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        
        getRobot().sleep();
        waitForEventQueueToCatchup();

        CWin.update(e.getUseID());
        waitForEventQueueToCatchup();
           
        assertEquals("ABC",s.toString().trim());
        
        w.close();
    }

    public void testChangePicture()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal cd = new ClarionDecimal(10,2);
        EntryControl e =  new EntryControl();
        e.setPicture("@s20").setAt(20,20,150,25);
        e.use(cd);

        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        w.register(b);
        w.open();
        
        assertTrue(w.accept());
        
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());

        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals("0.00",e.getProperty(Prop.SCREENTEXT).toString());
        
        e.setText("@n$12.2");
        
        assertEquals("$0.00",e.getProperty(Prop.SCREENTEXT).toString());
        
        w.close();
    }
    
    
    
    public void testSetUnderlyingObjectDoesNotFlagFieldAsModified()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(10);

        ButtonControl pb =  new ButtonControl();
        pb.setText("All Good").setAt(20,2,150,20);
        w.add(pb);
        w.register(pb);
        
        EntryControl e =  new EntryControl();
        e.setPicture("@s20").setAt(20,30,150,25);
        e.use(s);
        w.add(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,60,150,30);
        w.add(b);
        w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(pb.getUseID(),CWin.field());
        w.consumeAccept();
        
        s.setValue("Hello");

        waitForEventQueueToCatchup();
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    
    public void testReadOnly()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(10);
        EntryControl e =  new EntryControl();
        e.setPicture("@s20").setAt(20,20,150,25);
        e.use(s);
        e.setReadOnly();
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');

        CWin.update(e.getUseID());
        
        assertEquals("",s.toString().trim());
        
        w.close();
    }

    public void testOnSelectGeneratesSelectAndSelectsAll()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
    
        w.close();
    }

    public void testTypeInSomeStuffAndAcceptUpdatesField()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key('.');
        getRobot().key('5');
        
        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("1234.5",d.toString());
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        w.consumeAccept();

        assertEquals(10,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        w.close();
    }


    public void testDateType()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionNumber d = new ClarionNumber();
        EntryControl e =  new EntryControl();
        e.setPicture("@d6.").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());

        
        sleep(100);
        getRobot().key('2');
        getRobot().key(' ');
        getRobot().key('N');
        getRobot().key('O');
        getRobot().key('V');
        getRobot().key(' ');
        getRobot().key('2');
        getRobot().key('0');
        getRobot().key('0');
        getRobot().key('9');

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals(CDate.date(11,2,2009),d.intValue());
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        w.consumeAccept();

        assertEquals(10,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        assertEquals("2.11.2009",e.getProperty(Prop.SCREENTEXT).toString());
        
        w.close();
    }

    public void testUpdateFieldAutomaticallyUpdatesScreen()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        assertEquals("0",d.toString());
        d.setValue("124");
        w.consumeAccept();

        CWin.display();
        
        assertEquals("$124.00",e.getProperty(Prop.SCREENTEXT).toString());
        
        w.close();
    }
    
    
    public void testIssueSelect()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        
        CWin.select(id);
        
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals(id,CWin.focus());
        w.consumeAccept();

        CWin.select(bid);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);

        CWin.select(bid);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        w.setTimer(0);
        
        assertEquals(bid,CWin.focus());
        
        w.close();
    }
    
    public void testInvalidEntry()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key('.');
        getRobot().key('5');
        getRobot().key('X');

        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("0",d.toString());
        w.consumeAccept();

        assertEquals("$0.00",e.getProperty(Prop.SCREENTEXT).toString());
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        assertEquals("0",d.toString());
        w.consumeAccept();
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testInvalidEntryViaSelection()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key('.');
        getRobot().key('5');
        getRobot().key('X');
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        
        sleep(200);
        
        Component c = b.getComponent();

        getRobot().mousePress(c,MouseEvent.BUTTON1_MASK);
        sleep(100);
        getRobot().mouseRelease();
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("0",d.toString());
        w.consumeAccept();

        assertEquals("$0.00",e.getProperty(Prop.SCREENTEXT).toString());
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        assertEquals("0",d.toString());
        w.consumeAccept();
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testUpdate()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = new ClarionDecimal();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key('.');
        getRobot().key('5');

        w.setTimer(10);
        w.accept();
        w.consumeAccept();
        w.setTimer(0);
        
        CWin.update(id);
        CWin.display();
        
        assertEquals("1234.5",d.toString());
        
        assertEquals(7,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('X');
        
        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("1234.5",d.toString());
        w.consumeAccept();

        assertEquals("$1,234.50",e.getProperty(Prop.SCREENTEXT).toString());
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(9,e.getProperty(Prop.SELEND).intValue());
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        assertEquals("1234.5",d.toString());
        w.consumeAccept();
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    public void testUpdate2()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString cs = new ClarionString();
        EntryControl e =  new EntryControl();
        e.setPicture("@s10").setAt(20,20,150,25);
        e.use(cs);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key('.');
        getRobot().key('5');

        w.setTimer(10);
        w.accept();
        w.consumeAccept();
        w.setTimer(0);
        
        CWin.update(id);
        assertEquals("1234.5",cs.toString());
        assertEquals(7,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('X');

        w.setTimer(10);
        w.accept();
        w.consumeAccept();
        w.setTimer(0);
        
        CWin.update(id);
        assertEquals("1234.5x",cs.toString());
        assertEquals(8,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        assertEquals("1234.5x",cs.toString());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals("1234.5x",cs.toString());
        w.consumeAccept();

        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("1234.5x",cs.toString());
        w.consumeAccept();
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testThreadedEntry()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionDecimal d = (new ClarionDecimal()).setThread();
        EntryControl e =  new EntryControl();
        e.setPicture("@n$11.2").setAt(20,20,150,25);
        e.use(d);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,90,150,30);
        w.add(b);
        int bid = w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(5,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key('.');
        getRobot().key('5');

        w.setTimer(10);
        w.accept();
        w.consumeAccept();
        w.setTimer(0);
        
        CWin.update(id);
        CWin.display();
        
        assertEquals("1234.5",d.toString());
        
        assertEquals(7,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key('X');
        
        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(id,CWin.field());
        assertEquals("1234.5",d.toString());
        w.consumeAccept();

        assertEquals("$1,234.50",e.getProperty(Prop.SCREENTEXT).toString());
        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(9,e.getProperty(Prop.SELEND).intValue());
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bid,CWin.field());
        assertEquals("1234.5",d.toString());
        w.consumeAccept();
        
        w.setTimer(10);
        w.accept();
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
}
