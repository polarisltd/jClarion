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

import java.awt.event.KeyEvent;


import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.runtime.CWin;

public class TextTest extends SwingTC {

    public TextTest(String name) {
        super(name);
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

        assertEquals(0,e.getField().getSelectionStart());
        assertEquals(6,e.getField().getSelectionEnd());

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
