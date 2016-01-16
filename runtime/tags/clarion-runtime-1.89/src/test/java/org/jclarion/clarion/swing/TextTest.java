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

import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;


import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.runtime.CWin;

public class TextTest extends SwingTC {

    public TextTest(String name) {
        super(name);
    }

    public void testRightClick()
    {
		final ClarionWindow w = new ClarionWindow();
		w.setText("Hello World");
		w.setAt(null, null, 200, 100);
		w.setCenter();

		ClarionString cs = new ClarionString(400);
		cs.setValue("For want of a better sthick\nThere is a dodo in the attic.");
		// cs.setValue("Hello");
		TextControl e1 = new TextControl();
		e1.use(cs);
		e1.setAt(5, 5, 150, 50);
		//e1.setText("@s400");
		w.add(e1);

		ButtonControl b = new ButtonControl();
		b.setText("Focus");
		b.setAt(160, 5, 40, 20);
		w.add(b);

		w.open();

		assertTrue(w.accept());
		assertEquals(Event.OPENWINDOW, CWin.event());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.SELECTED, CWin.event());
		assertEquals(e1.getUseID(), CWin.field());
		w.consumeAccept();

		rightClick(e1,150,15,30);
		
		getRobot().key(KeyEvent.VK_TAB);

		assertTrue(w.accept());
		assertEquals(Event.ACCEPTED, CWin.event());
		assertEquals(e1.getUseID(), CWin.field());
		assertEquals("For want of a better stick\nThere is a dodo in the attic.",cs.toString().trim());
		w.consumeAccept();

		assertTrue(w.accept());
		assertEquals(Event.SELECTED, CWin.event());
		assertEquals(b.getUseID(), CWin.field());
		w.consumeAccept();
		
		getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
		assertEquals(Event.SELECTED, CWin.event());
		assertEquals(e1.getUseID(), CWin.field());
		w.consumeAccept();
		
		rightClick(e1,5,5,10);
        assertEquals("For want of a better stick\nThere is a dodo in the attic.",e1.getProperty(Prop.SCREENTEXT).toString());

                
		w.setTimer(5);
		assertTrue(w.accept());		
		assertEquals(Event.TIMER, CWin.event());
		w.consumeAccept();
		w.setTimer(0);
		
		w.close();
    }

    private void rightClick(AbstractControl s2,int x,int y,int yofs)
    {
        waitForEventQueueToCatchup();
        getRobot().mousePress(cc(s2).getComponent(),x,y,InputEvent.BUTTON3_MASK);
        getRobot().mouseRelease(InputEvent.BUTTON3_MASK);
        waitForEventQueueToCatchup();
        getRobot().mousePress(cc(s2).getComponent(),x+10,y+yofs);
        getRobot().mouseRelease();
        waitForEventQueueToCatchup();
    }
    
    public void testReadTouched()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();
    	
        ClarionString cs = new ClarionString(20);
        //cs.setValue("Hello");
        TextControl e1 = new TextControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@s20");
        w.add(e1);

        ButtonControl b = new ButtonControl();
        b.setText("Focus");
        b.setAt(160,5,40,20);
        w.add(b);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(0,e1.getProperty(Prop.TOUCHED).intValue());
        
        getRobot().key('1');
    
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(1,e1.getProperty(Prop.TOUCHED).intValue());
        
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals(0,e1.getProperty(Prop.TOUCHED).intValue());

        w.close();
    }


    public void testWriteTouched()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();
    	
        ClarionString cs = new ClarionString(20);
        //cs.setValue("Hello");
        TextControl e1 = new TextControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@s20");
        w.add(e1);

        ButtonControl b = new ButtonControl();
        b.setText("Focus");
        b.setAt(160,5,40,20);
        w.add(b);

        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        e1.setProperty(Prop.TOUCHED,1);
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals("",cs.toString().trim());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals(0,e1.getProperty(Prop.TOUCHED).intValue());

        w.close();
    }
    
    public void testWrap()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(500);
        s.setValue("crimpity crimpity now now. "+
        		"crimpity crimpity ask me how. "+
        		"crimpity crimpity humble pie. "+
        		"crimpity crimpity. "+
        		"boing ding boing boing ting; "+
        		"crimpity crimpity ping pong.");
        TextControl e =  new TextControl();
        e.setAt(20,20,150,80);
        e.use(s);
        w.add(e);
        int id = w.register(e);

        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,110,150,30);
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
        
        waitForEventQueueToCatchup();

        assertTrue(cc(e).getField().getWidth()<=cc(e).getScrollPane().getWidth());
        
        w.close();
    }

    public void testNoWrap()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(500);
        s.setValue("crimpity crimpity now now. "+
        		"crimpity crimpity ask me how. "+
        		"crimpity crimpity humble pie. "+
        		"crimpity crimpity. "+
        		"boing ding boing boing ting; "+
        		"crimpity crimpity ping pong.");
        TextControl e =  new TextControl();
        e.setAt(20,20,150,80);
        e.use(s);
        e.setHVScroll();
        w.add(e);
        int id = w.register(e);

        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,110,150,30);
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
        
        waitForEventQueueToCatchup();

        assertTrue(cc(e).getField().getWidth()>cc(e).getScrollPane().getWidth());
        
        w.close();
    }
    
    public void testSelectRange()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(20);
        s.setValue("Some text");
        TextControl e =  new TextControl();
        e.setPicture("@s20").setAt(20,20,150,80);
        e.use(s);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,110,150,30);
        w.add(b);
        w.register(b);
        w.open();
        
        CWin.select(e.getUseID(),1,6);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        waitForEventQueueToCatchup();

        assertEquals(0,cc(e).getField().getSelectionStart());
        assertEquals(6,cc(e).getField().getSelectionEnd());

        assertEquals(1,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(6,e.getProperty(Prop.SELEND).intValue());
        
        w.close();
    }
    
    
    public void testTextArea()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(20);
        TextControl e =  new TextControl();
        e.setPicture("@s20").setAt(20,20,150,80);
        e.use(s);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,110,150,30);
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
        getRobot().key(KeyEvent.VK_ENTER);
        getRobot().key('X');
        getRobot().key('Y');
        getRobot().key('Z');

        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();

        assertEquals("abc\nxyz",s.toString().trim());
        
        w.close();
    }

    public void testTextAreaNoPicture()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(20);
        TextControl e =  new TextControl();
        e.setAt(20,20,150,80);
        e.use(s);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,110,150,30);
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
        getRobot().key(KeyEvent.VK_ENTER);
        getRobot().key('X');
        getRobot().key('Y');
        getRobot().key('Z');

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(id,CWin.field());
        w.consumeAccept();
        
        assertEquals("abc\nxyz",s.toString().trim());
        
        w.close();
    }
    
    public void testTabInAndOutPreservesCarotPos() throws InterruptedException
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        ClarionString s = new ClarionString(20);
        TextControl e =  new TextControl();
        e.setPicture("@s20").setAt(20,20,150,80);
        e.use(s);
        w.add(e);
        int id = w.register(e);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(20,110,150,30);
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
        getRobot().key(KeyEvent.VK_ENTER);
        getRobot().key('X');
        getRobot().key('Y');
        getRobot().key('Z');
        
        getRobot().sleep();
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        
        assertEquals(8,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());

        getRobot().key(KeyEvent.VK_LEFT);
        getRobot().key(KeyEvent.VK_LEFT);

        getRobot().sleep();
        waitForEventQueueToCatchup();
        
        assertEquals(6,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertEquals(8,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());

        getRobot().key(KeyEvent.VK_LEFT);
        getRobot().key(KeyEvent.VK_LEFT);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertEquals(6,e.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e.getProperty(Prop.SELEND).intValue());

        w.close();

        //assertFalse(w.accept());
    }
    
    
}
