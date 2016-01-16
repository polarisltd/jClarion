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
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Rectangle;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;

import javax.swing.JTable;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class ListTest extends SwingTC 
{

    public ListTest(String name) {
        super(name);
    }
    
    private class Queue extends ClarionQueue
    {
        public ClarionString f1=new ClarionString(20);
        public ClarionString f2=new ClarionString(10);
        public ClarionNumber f3=new ClarionNumber();
        public ClarionDecimal f4=new ClarionDecimal(12,2);
        
        public Queue()
        {
            super();
            addVariable("f1",f1);
            addVariable("f2",f2);
            addVariable("f3",f3);
            addVariable("f4",f4);
        }
    }

    public void testEmptyListFocus()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        ButtonControl bc= new ButtonControl();
        bc.setAt(5,100,100,20);
        bc.setText("Landing button");
        w.add(bc);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
		for (int scan = 1; scan < 50; scan++) {
			q.f1.setValue("item " + scan);
			q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
			q.f3.setValue(10 + scan * 2);
			q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
			q.add();
		}

		CWin.display();

		/*
		while (w.accept()) {
			System.out.println(CWin.eventString());
			w.consumeAccept();
		}
		*/
		
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.COLUMNRESIZE,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
		
        
        w.close();
    }

    public void testEmptyListFocus2()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        ButtonControl bc= new ButtonControl();
        bc.setAt(5,100,100,20);
        bc.setText("Landing button");
        w.add(bc);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        q.free();
			q.f1.setValue("item x");
			q.f2.setValue("thing");
			q.f3.setValue(3);
			q.f4.setValue("61.23");
			q.add();

		CWin.display();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
		
        
        w.close();
    }
    

    public void testEmptyListFocus3()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        ButtonControl bc= new ButtonControl();
        bc.setAt(5,100,100,20);
        bc.setText("Landing button");
        w.add(bc);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        q.free();
			q.f1.setValue("item x");
			q.f2.setValue("thing");
			q.f3.setValue(3);
			q.f4.setValue("61.23");
			q.add();

		CWin.display();

		/*
		while (w.accept()) {
			System.out.println(CWin.eventString());
			w.consumeAccept();
		}
		*/
		
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
		
        
        w.close();
    }
    
    public void testAutoAdjustListHeight()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        ListControl l = new ListControl();
        l.setFrom("Ernie|Big Bird|Oscar the Grouch|Elmo|Bert");
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();

        w.add(l);
        
        w.open();

        l.setProperty(Propstyle.BACKCOLOR,1,5);
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(11,l.getProperty(Prop.ITEMS).intValue());
        int h1 = cc(l).getTable().getRowHeight();

        l.setProperty(Prop.FONTSIZE,20);

        assertTrue(w.accept());
        assertEquals(Event.COLUMNRESIZE,CWin.event());
        w.consumeAccept();
        
        
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(5,l.getProperty(Prop.ITEMS).intValue());
        assertFalse(h1==cc(l).getTable().getRowHeight());

        w.close();
    }
    
    public void testStringFrom()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        ListControl l = new ListControl();
        l.setFrom("Ernie|Big Bird|Oscar the Grouch|Elmo|Bert");
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();

        w.add(l);
        
        w.open();

        l.setProperty(Propstyle.BACKCOLOR,1,5);
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        w.setTimer(1);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
 
        getRobot().key(KeyEvent.VK_DOWN);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(2,l.getProperty(Prop.SELSTART).intValue());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(2,l.getProperty(Prop.SELSTART).intValue());
        w.consumeAccept();
        
        w.setTimer(1);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
 
        ClarionQueue cq = l.getFrom();
        assertEquals(5,cq.records());
        
        cq.get(1);
        assertEquals("Ernie",cq.what(1).toString());

        cq.get(2);
        assertEquals("Big Bird",cq.what(1).toString());

        cq.get(3);
        assertEquals("Oscar the Grouch",cq.what(1).toString());

        cq.get(4);
        assertEquals("Elmo",cq.what(1).toString());

        cq.get(5);
        assertEquals("Bert",cq.what(1).toString());
        
        w.close();
    }

    public void testColumnResize()
    {
		final ClarionWindow w = new ClarionWindow();
		w.setText("Hello World");
		w.setAt(null, null, 200, 130);

		Queue q = new Queue();
		for (int scan = 1; scan < 50; scan++) {
			q.f1.setValue("item " + scan);
			q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
			q.f3.setValue(10 + scan * 2);
			q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
			q.add();
		}

		ListControl l = new ListControl();
		l.setFrom(q);
		l.setAt(2, 2, 196, 96);
		l.setHVScroll();
		l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
		w.add(l);
		w.register(l);

		w.open();

		assertTrue(w.accept());
		assertEquals(Event.OPENWINDOW, CWin.event());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.SELECTED, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.ACCEPTED, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.NEWSELECTION, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();
		
		CWin.select(l.getUseID(),10);

		assertTrue(w.accept());
		assertEquals(Event.ACCEPTED, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.NEWSELECTION, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();
		
		w.setTimer(10);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
		
		waitForEventQueueToCatchup();
        Component c = cc(l).getComponent();
        
		getRobot().mouseMove(c,80,10);
		getRobot().mousePress(c,80,10);
		waitForEventQueueToCatchup();
		getRobot().mouseMove(c,130,10);
		waitForEventQueueToCatchup();
		getRobot().mouseRelease();
		waitForEventQueueToCatchup();
		
		assertTrue(w.accept());
		assertEquals(Event.COLUMNRESIZE, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		assertEquals("65L(2)|M~F1~L@s20@40L(2)|M~F2~L@s20@20R(2)|M~F3~L@n9@60R(2)|M~F4~L@n$12.2@",l.getProperty(Prop.FORMAT).toString());
		w.consumeAccept();
		
		w.setTimer(10);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);

		getRobot().mouseMove(c,130,10);
		getRobot().mousePress(c,130,10);
		waitForEventQueueToCatchup();
		getRobot().mouseMove(c,150,10);
		waitForEventQueueToCatchup();
		getRobot().mouseRelease();
		waitForEventQueueToCatchup();
		
		assertTrue(w.accept());
		assertEquals(Event.COLUMNRESIZE, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		assertEquals("75L(2)|M~F1~L@s20@40L(2)|M~F2~L@s20@20R(2)|M~F3~L@n9@50R(2)|M~F4~L@n$12.2@",l.getProperty(Prop.FORMAT).toString());
		w.consumeAccept();
		
		w.setTimer(10);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
		
		w.close();
    }

    
    public void testChangeFormatStructure()
    {
		final ClarionWindow w = new ClarionWindow();
		w.setText("Hello World");
		w.setAt(null, null, 200, 130);

		Queue q = new Queue();
		for (int scan = 1; scan < 50; scan++) {
			q.f1.setValue("item " + scan);
			q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
			q.f3.setValue(10 + scan * 2);
			q.f4.setValue("21" + scan + "." + (scan==10 ? 26 : (int) ( Math.random() * 100 )));
			q.add();
		}

		ListControl l = new ListControl();
		l.setFrom(q);
		l.setAt(2, 2, 196, 96);
		l.setHVScroll();
		//l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
		l.setFormat("40L(2)|M~F1~@s20@");
		w.add(l);
		w.register(l);

		w.open();

		assertTrue(w.accept());
		assertEquals(Event.OPENWINDOW, CWin.event());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.SELECTED, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.ACCEPTED, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.NEWSELECTION, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();
		
		CWin.select(l.getUseID(),10);

		assertTrue(w.accept());
		assertEquals(Event.ACCEPTED, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.NEWSELECTION, CWin.event());
		assertEquals(l.getUseID(), CWin.field());
		w.consumeAccept();
		
        JTable t = cc(l).getTable();

        w.setTimer(50);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
        waitForEventQueueToCatchup();
        assertEquals(1,t.getColumnCount());
        
		//l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
		l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@");

        w.setTimer(50);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
        waitForEventQueueToCatchup();
        assertEquals(2,t.getColumnCount());
        
        assertEquals("YYY",t.getModel().getValueAt(9,1).toString());
		
		l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");

        w.setTimer(50);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
        waitForEventQueueToCatchup();
        assertEquals(4,t.getColumnCount());
        assertEquals("30",t.getModel().getValueAt(9,2).toString());
        assertEquals("$2,110.26",t.getModel().getValueAt(9,3).toString());

		l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@");

        w.setTimer(50);
		assertTrue(w.accept());
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
        waitForEventQueueToCatchup();
        assertEquals(3,t.getColumnCount());
        
        w.close();
    }
    
    
    public void testImmColumnMode()
    {
            final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        Queue q = new Queue();
        for (int scan = 1; scan < 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(10 + scan * 2);
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();
        l.setColumn();
        l.setImmediate();
        l
                .setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertEquals(1, CWin.choice(l.getUseID()));
        assertEquals(1,l.getProperty(Prop.COLUMN).intValue());
        
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().key(KeyEvent.VK_RIGHT);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();
        
        assertEquals(2,l.getProperty(Prop.COLUMN).intValue());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_LEFT);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();
        
        assertEquals(1,l.getProperty(Prop.COLUMN).intValue());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        JTable t = cc(l).getTable();
        
        Rectangle rect = t.getCellRect(3,2,true);
        
        getRobot().mousePress(t, rect.x+rect.width/2,rect.y+rect.height/2);
        getRobot().mouseRelease();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();
        
        assertEquals(4, CWin.choice(l.getUseID()));
        assertEquals(3,l.getProperty(Prop.COLUMN).intValue());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        q.sort(q.ORDER().ascend(q.f2).ascend(q.f1));
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        w.consumeAccept();

        /*
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();
        */

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        assertEquals(4, CWin.choice(l.getUseID()));
        assertEquals(3,l.getProperty(Prop.COLUMN).intValue());
        
        w.close();
        
    }

    public void testFiddleWithScrollPosDoesNotTriggerTrackEvent()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        Queue q = new Queue();
        for (int scan = 1; scan < 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(10 + scan * 2);
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();
        l.setImmediate();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertEquals(1, CWin.choice(l.getUseID()));

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        l.setProperty(Prop.VSCROLLPOS, 0);
        l.setProperty(Prop.VSCROLLPOS, 80);

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER, CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        w.close();
    }
    
    public void testSelectListSelectsTheList() throws InterruptedException
    {
        final Object monitor = new Object();
        final boolean ready[] = new boolean[] { false };
        
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,250,200);
        
        Runnable r=new Runnable() {
            @Override
            public void run() {
                ca.open();
                
                Clarion.getWindowTarget().accept();
                Clarion.getWindowTarget().consumeAccept();
                
                synchronized(monitor) {
                    ready[0]=true;
                    monitor.notifyAll();
                }
                
                while (Clarion.getWindowTarget().accept()) {
                    Clarion.getWindowTarget().consumeAccept();
                }
                ca.close();
            }
        };

        Thread t = new Thread(r);
        
        synchronized(monitor) {
            t.start();
            while (!ready[0]) {
                monitor.wait();
            }   
        }
        
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        w.setMDI();
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ButtonControl b1 = new ButtonControl();
        b1.setDefault().setText("b1").setAt(1,0,null,10);
        w.add(b1);
        
        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,12,196,76);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        ButtonControl b2 = new ButtonControl();
        b2.setText("b2").setAt(1,90,null,10);
        w.add(b2);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        CWin.select(l.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());

        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();
        
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();

        CWin.select(l.getUseID(),q.records());

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(q.records(),l.getProperty(Prop.SELSTART).intValue());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(q.records(),l.getProperty(Prop.SELSTART).intValue());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(q.records(),l.getProperty(Prop.SELSTART).intValue());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        w.close();
        
        ca.post(Event.CLOSEWINDOW);
        
        try {
            t.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    } 

    public void testSelectListSelectsTheListWithImm() throws InterruptedException
    {
        final Object monitor = new Object();
        final boolean ready[] = new boolean[] { false };
        
        final ClarionApplication ca = new ClarionApplication();
        ca.setAt(0,0,250,200);
        
        Runnable r=new Runnable() {
            @Override
            public void run() {
                ca.open();
                
                Clarion.getWindowTarget().accept();
                Clarion.getWindowTarget().consumeAccept();
                
                synchronized(monitor) {
                    ready[0]=true;
                    monitor.notifyAll();
                }
                
                while (Clarion.getWindowTarget().accept()) {
                    Clarion.getWindowTarget().consumeAccept();
                }
                ca.close();
            }
        };

        Thread t = new Thread(r);
        
        synchronized(monitor) {
            t.start();
            while (!ready[0]) {
                monitor.wait();
            }   
        }
        
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        w.setMDI();
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ButtonControl b1 = new ButtonControl();
        b1.setDefault().setText("b1").setAt(1,0,null,10);
        w.add(b1);
        
        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,12,196,76);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        l.setImmediate();
        w.add(l);
        w.register(l);

        ButtonControl b2 = new ButtonControl();
        b2.setText("b2").setAt(1,90,null,10);
        w.add(b2);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        CWin.select(l.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());

        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(b1.getUseID(),CWin.field());
        w.consumeAccept();
        
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        
        w.close();
        
        ca.post(Event.CLOSEWINDOW);
        
        try {
            t.join();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    } 

    public void testKeepScrolling()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        Queue q = new Queue();
        for (int scan = 1; scan < 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(10 + scan * 2);
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196, 96);
        l.setVScroll();
        l.setImmediate();
        l
                .setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();
        
        l.setProperty(Prop.VSCROLLPOS,0);
        
        
        Component c = cc(l).getComponent();
        Dimension d = c.getSize();

        for (int scan=0;scan<10;scan++) {
            getRobot().mousePress(c,d.width-10,5,MouseEvent.BUTTON1_MASK);
            getRobot().mouseRelease();
        
            assertTrue(w.accept());
            assertEquals(Event.SCROLLUP,CWin.event());
            assertEquals(l.getUseID(),CWin.field());
            assertEquals(1,CWin.choice(l.getUseID()));
            w.consumeAccept();
        }
        
        l.setProperty(Prop.VSCROLLPOS,100);

        for (int scan=0;scan<10;scan++) {
            getRobot().mousePress(c,d.width-10,d.height-5,MouseEvent.BUTTON1_MASK);
            getRobot().mouseRelease();
        
            assertTrue(w.accept());
            assertEquals(Event.SCROLLDOWN,CWin.event());
            assertEquals(l.getUseID(),CWin.field());
            assertEquals(1,CWin.choice(l.getUseID()));
            w.consumeAccept();
        }

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();

        
    }
    
    public void testImmModeEvents() throws InterruptedException
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setVScroll();
        l.setImmediate();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertEquals(1,CWin.choice(l.getUseID()));
        
        assertEquals(11,l.getProperty(Prop.ITEMS).intValue());
        assertEquals(Create.LIST,l.getProperty(Prop.TYPE).intValue());
        
        getRobot().key(KeyEvent.VK_DOWN);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.SCROLLDOWN,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_UP);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.SCROLLUP,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_PAGE_UP);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.PAGEUP,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_PAGE_DOWN);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.PAGEDOWN,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_HOME);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.SCROLLTOP,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_END);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.SCROLLBOTTOM,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        Component c = cc(l).getComponent();
        Dimension d = c.getSize();
        
        getRobot().mousePress(c,d.width-10,5,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease();
        
        assertTrue(w.accept());
        assertEquals(Event.SCROLLUP,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().mousePress(c,d.width-10,40,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease();
        assertTrue(w.accept());
        assertEquals(Event.PAGEUP,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().mousePress(c,d.width-10,d.height-10,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease();
        assertTrue(w.accept());
        assertEquals(Event.SCROLLDOWN,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().mousePress(c,d.width-10,d.height-40,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease();
        assertTrue(w.accept());
        assertEquals(Event.PAGEDOWN,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().mousePress(c,d.width-10,d.height/2,MouseEvent.BUTTON1_MASK);
        getRobot().mouseMove(c,d.width-10,40);
        getRobot().mouseRelease();
        while ( true ) {
            assertTrue(w.accept());
            int event = CWin.event();
            if (event==Event.SCROLLDRAG) break;
            assertEquals(Event.SCROLLTRACK,CWin.event());
            assertEquals(l.getUseID(),CWin.field());
            assertEquals(1,CWin.choice(l.getUseID()));
            w.consumeAccept();
        }
        assertEquals(Event.SCROLLDRAG,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    public void testFullResize() throws InterruptedException
    {
            final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);
        w.setResize();

        Queue q = new Queue();
        for (int scan = 1; scan <= 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(10 + scan * 2);
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, null,null);
        l.setFull();
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertEquals(1, CWin.choice(l.getUseID()));

        waitForEventQueueToCatchup();
        
        Component c = cc(l).getComponent();
        ClarionWindow cw = cc(w);

        assertApproxSize(c,cw.widthDialogToPixels(200),cw.heightDialogToPixels(130));

        Container win = cw.getWindow();
        Dimension d = win.getSize();
        
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        getRobot().mousePress(win,d.width-2,d.height-2,MouseEvent.BUTTON1_MASK);
        Thread.sleep(100);
        getRobot().mouseMove(win,d.width+cw.getFontWidth()*20/4,d.height+cw.getFontHeight()*30/8);
        Thread.sleep(100);
        getRobot().mouseRelease();

        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        assertApproxSize(c,cw.widthDialogToPixels(220),cw.heightDialogToPixels(160));
        
        
        w.close();
    }

    public void testResizeListAltersItemsImmediately()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);
        w.setResize();

        Queue q = new Queue();
        for (int scan = 1; scan <= 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(10 + scan * 2);
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196,126);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION, CWin.event());
        assertEquals(l.getUseID(), CWin.field());
        w.consumeAccept();

        assertEquals(1, CWin.choice(l.getUseID()));
        
        assertEquals(CWin.getInstance().isNimbus()? 13 : 14,l.getProperty(Prop.ITEMS).intValue());

        waitForEventQueueToCatchup();
        
        l.setProperty(Prop.WIDTH,150);
        l.setProperty(Prop.HEIGHT,63);

        waitForEventQueueToCatchup();

        assertEquals(6,l.getProperty(Prop.ITEMS).intValue());

        w.setTimer(100);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    private void assertApproxSize(Component c, int width,int height) 
    {
        int diff;
        diff = Math.abs(c.getWidth()-width);
        assertTrue(c.getWidth()+" = "+width,diff<=10);
        diff = Math.abs(c.getHeight()-height);
        assertTrue(c.getHeight()+" = "+height,diff<=10);
    }

       
    
    public void testNormalModeEvents()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        


        assertEquals(1,CWin.choice(l.getUseID()));
        
        getRobot().key(KeyEvent.VK_DOWN);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_UP);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_PAGE_DOWN);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(11,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(11,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_PAGE_UP);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_END,KeyEvent.CTRL_MASK);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(50,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(50,CWin.choice(l.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_HOME,KeyEvent.CTRL_MASK);
        sleep(100);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
    public void testMouseAlerts()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        l.setAlrt(Constants.MOUSERIGHT);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        Component c = cc(l).getComponent();

        sleep(200);
        getRobot().mousePress(c,MouseEvent.BUTTON3_MASK);
        getRobot().mouseRelease(MouseEvent.BUTTON3_MASK);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(Constants.MOUSERIGHT,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(Constants.MOUSERIGHT,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
     
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(200);
        getRobot().mousePress(c,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease(MouseEvent.BUTTON1_MASK);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }

    public void testKeyAlerts()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        l.setAlrt(65); // 'A'
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        Component c = cc(l).getComponent();

        sleep(200);
        getRobot().key(KeyEvent.VK_A);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
     
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(200);
        getRobot().mousePress(c,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease(MouseEvent.BUTTON1_MASK);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }

    
    public void testKeyAlertsOnImm()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        l.setImmediate();
        w.add(l);
        w.register(l);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        Component c = cc(l).getComponent();

        sleep(200);
        getRobot().key(KeyEvent.VK_A);
        getRobot().key(KeyEvent.VK_B);
        getRobot().key(KeyEvent.VK_C);

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(66,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(67,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
     
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(200);
        getRobot().mousePress(c,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease(MouseEvent.BUTTON1_MASK);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }
    
    
    public void testKeyAlertsSetAfterOpen()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        w.open();

        l.setAlrt(65); // 'A'        

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        Component c = cc(l).getComponent();

        sleep(200);
        getRobot().key(KeyEvent.VK_A);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
     
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(200);
        getRobot().mousePress(c,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease(MouseEvent.BUTTON1_MASK);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }
    
    public void testKeyAlertsSetAfterOpenWindow()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,130);
        
        Queue q = new Queue();
        for (int scan=1;scan<=50;scan++) {
            q.f1.setValue("item "+scan);
            q.f2.setValue((scan&1)==1 ? "XXX" : "YYY");
            q.f3.setValue(10+scan*2);
            q.f4.setValue("21"+scan+"."+(int)(Math.random()*100));
            q.add();
        }

        ListControl l =  new ListControl();
        l.setFrom(q);
        l.setAt(2,2,196,96);
        l.setHVScroll();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        l.setAlrt(65); // 'A'        

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        Component c = cc(l).getComponent();

        sleep(200);
        getRobot().key(KeyEvent.VK_A);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(65,CWin.keyCode());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
     
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sleep(200);
        getRobot().mousePress(c,MouseEvent.BUTTON1_MASK);
        getRobot().mouseRelease(MouseEvent.BUTTON1_MASK);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }
    
    
    public void testTreeFunctions()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);	

        int pos[]=new int[] {1,2,3,3,3,2,3,3,4,4 };
        
        Queue q = new Queue();
        for (int scan = 1; scan < 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(pos[(scan-1)%10]*(scan%3>0?1:-1));
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();
        //l.setImmediate();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)T|M~F2~@s20@20R(2)|M~F4~@n$12.2@");
        //l.setFormat("40L(2)|M~F1~@s20@40L(2)T|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        
        CWin.select(l.getUseID(),11);
        waitForEventQueueToCatchup();
        assertEquals(6,cc(l).getTable().getSelectedRow());
        assertEquals(11,l.getProperty(Prop.SELSTART).intValue());

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        q.get(6);
        assertEquals(-2,q.f3.intValue());
        
        
        getRobot().mousePress(cc(l).getTable(),105,83);
        getRobot().mouseRelease();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(6,CWin.choice(l.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(6,CWin.choice(l.getUseID()));
        w.consumeAccept();

        waitForEventQueueToCatchup();
        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        q.get(6);
        assertEquals(2,q.f3.intValue());

        int cnt[] = new int[] { 7,8,9,10,11,12,16,17,18,21,31,32,33,34,35,36,41,42,46,47,48 };
        
        for (int scan=0;scan<cnt.length;scan++) {
        	getRobot().key(KeyEvent.VK_DOWN);
            assertTrue(w.accept());
            assertEquals(Event.ACCEPTED,CWin.event());
            assertEquals(l.getUseID(),CWin.field());
            assertEquals(cnt[scan],CWin.choice(l.getUseID()));
            w.consumeAccept();

            assertTrue(w.accept());
            assertEquals(Event.NEWSELECTION,CWin.event());
            assertEquals(l.getUseID(),CWin.field());
            assertEquals(cnt[scan],CWin.choice(l.getUseID()));
            w.consumeAccept();
        	
        }

        
    	getRobot().key(KeyEvent.VK_DOWN);
    	waitForEventQueueToCatchup();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);        
        
        w.close();        
    }
    
    
    public void testEmptyTree()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        int pos[]=new int[] {1,2,3,3,3,2,3,3,4,4 };
        
        Queue q = new Queue();
        /*
        */

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();
        l.setImmediate();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)T|M~F2~@s20@20R(2)|M~F4~@n$12.2@");
        //l.setFormat("40L(2)|M~F1~@s20@40L(2)T|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        ButtonControl bc = new ButtonControl();
        bc.setAt(2,100,100,20);
        bc.setText("test");
        w.add(bc);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);


        q.free();
        for (int scan = 1; scan < 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(pos[(scan-1)%10]*(scan%3>0?1:-1));
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);        

        w.close();
        
    }
    
    public void testEmptyTree2()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 130);

        int pos[]=new int[] {1,2,3,3,3,2,3,3,4,4 };
        
        Queue q = new Queue();
        /*
        */

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 2, 196, 96);
        l.setHVScroll();
        l.setImmediate();
        l.setFormat("40L(2)|M~F1~@s20@40L(2)T|M~F2~@s20@20R(2)|M~F4~@n$12.2@");
        //l.setFormat("40L(2)|M~F1~@s20@40L(2)T|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);
        
        ButtonControl bc = new ButtonControl();
        bc.setAt(2,100,100,20);
        bc.setText("test");
        w.add(bc);

        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);


        q.free();
        for (int scan = 1; scan < 50; scan++) {
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(pos[(scan-1)%10]*(scan%3>0?1:-1));
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(l.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(l.getUseID()));
        w.consumeAccept();

        w.setTimer(5);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);        

        w.close();
        
    }
    
    public void testMarkSelect() throws InterruptedException
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 200);

        Queue q = new Queue();
        ClarionNumber mark = new ClarionNumber();
        q.addVariable("mark",mark);
        for (int scan = 1; scan < 50; scan++) {
        	mark.setValue(scan<8 ? 1 : 0 );
            q.f1.setValue("item " + scan);
            q.f2.setValue((scan & 1) == 1 ? "XXX" : "YYY");
            q.f3.setValue(10 + scan * 2);
            q.f4.setValue("21" + scan + "." + (int) (Math.random() * 100));
            q.add();
        }

        ListControl l = new ListControl();
        l.setFrom(q);
        l.setAt(2, 22, 196, 96);
        l.setHVScroll();
        l.setMark(mark);
        l.setFormat("40L(2)|M~F1~@s20@40L(2)|M~F2~@s20@20R(2)|M~F3~@n9@20R(2)|M~F4~@n$12.2@");
        w.add(l);
        w.register(l);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(1);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        int sel[];
        sel=cc(l).getTable().getSelectedRows();
        assertEquals(sel,0,1,2,3,4,5,6);

        q.get(3);
        mark.setValue(0);
        q.put();
        
        waitForEventQueueToCatchup();

        w.setTimer(1);

        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sel=cc(l).getTable().getSelectedRows();
        assertEquals(sel,0,1,3,4,5,6);

        w.setTimer(1);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().mousePress(cc(l).getTable(),30,50);
        getRobot().mouseRelease();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();
        
        w.setTimer(1);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sel=cc(l).getTable().getSelectedRows();
        assertEquals(sel,3);

        getRobot().setModifiers(KeyEvent.SHIFT_MASK,true);
        Thread.sleep(100);
        getRobot().mousePress(cc(l).getTable(),30,90);
        Thread.sleep(100);
        getRobot().mouseRelease();
        Thread.sleep(100);
        getRobot().setModifiers(KeyEvent.SHIFT_MASK,false);
        
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        sel=cc(l).getTable().getSelectedRows();
        assertEquals(sel,3,4,5,6);
        
        for (int scan=1;scan<50;scan++) {
        	q.get(scan);
        	if (scan>=4 && scan<=7) {
        		assertEquals(1,mark.intValue());
        	} else {
        		assertEquals(0,mark.intValue());	
        	}
        }

        w.close();
    }

    private void assertEquals(int sel[],int ...comp)
    {
    	assertEquals(comp.length,sel.length);
    	for (int scan=0;scan<sel.length;scan++) {
    		assertEquals(comp[scan],sel[scan]);
    	}
    }
 
    private void assertEquals(int sel[],int comp)
    {
    	assertEquals(1,sel.length);
    	assertEquals(comp,sel[0]);
    }
    
}
