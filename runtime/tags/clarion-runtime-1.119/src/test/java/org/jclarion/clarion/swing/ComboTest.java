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

import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.ComboControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.runtime.CWin;

public class ComboTest extends SwingTC 
{

    public ComboTest(String name) {
        super(name);
    }

    private static class CQ extends ClarionQueue
    {
        public ClarionString name=new ClarionString(20);
        
        public CQ()
        {
            addVariable("name",name);
        }
    }

    public void testComboInitValue()
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("Item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cs.setValue("Item #5");
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals("Item #5",cs.toString());
        assertEquals("Item #5",cc.getProperty(Prop.SCREENTEXT).toString());

        w.close();
    }

    public void testComboInitValueNotInList()
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("Item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cs.setValue("Item X");
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals("Item X",cs.toString());
        assertEquals("Item X",cc.getProperty(Prop.SCREENTEXT).toString());

        w.close();
    }

    public void testComboInitValueListBuiltLater()
    {
        CQ cq = new CQ();
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cs.setValue("Item X");
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        for (int scan=0;scan<1;scan++) {
            cq.name.setValue("Item #"+scan);
            cq.add();
        }
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals("Item X",cs.toString());
        assertEquals("Item X",cc.getProperty(Prop.SCREENTEXT).toString());

        w.close();
    }
    
    public void testComboDropDown() throws InterruptedException
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("Item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        Thread.sleep(500);
        getRobot().key(KeyEvent.VK_DOWN);
        Thread.sleep(500);
        getRobot().key(KeyEvent.VK_DOWN);
        Thread.sleep(500);
        getRobot().key(KeyEvent.VK_ENTER);

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("Item #0",cs.toString().trim());

        assertEquals(1,cc.getProperty(Prop.SELSTART).intValue());

        w.setTimer(50);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        cc.setProperty(Prop.SELSTART,5);

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("Item #4",cs.toString().trim());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }

    
    public void testComboTypeKnownItem() throws InterruptedException
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        Thread.sleep(500);
        
        getRobot().key('I');
        getRobot().key('T');
        getRobot().key('E');
        getRobot().key('M');
        getRobot().key(' ');
        getRobot().key('3',KeyEvent.SHIFT_MASK);
        getRobot().key('6');
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("item #6",cs.toString().trim());
        assertEquals(7,cc.getProperty(Prop.SELSTART).intValue());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        w.close();

    }

    public void testComboTypeUnknownItem() throws InterruptedException
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        Thread.sleep(500);
        
        getRobot().key('M');
        getRobot().key('R');
        getRobot().key(' ');
        getRobot().key('B');
        getRobot().key('L');
        getRobot().key('A');
        getRobot().key('H');
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("mr blah",cs.toString().trim());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();

    }

    public void testSetText() throws InterruptedException
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ComboControl cc =  new ComboControl();
        ClarionString cs = new ClarionString();
        cc.setPicture("@s20");
        cc.use(cs);
        cc.setDrop(5);
        cc.setFrom(cq);
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        cs.setValue("item #5");

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();


        assertEquals("item #5",cs.toString().trim());
        assertEquals(6,cc.getProperty(Prop.SELSTART).intValue());
        assertEquals("item #5",cc.getProperty(Prop.SCREENTEXT).toString());
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();

    }
    
    
    public void testDropDownList() throws InterruptedException
    {
        CQ cq = new CQ();
        for (int scan=0;scan<10;scan++) {
            cq.name.setValue("Item #"+scan);
            cq.add();
        }
        
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        ListControl cc =  new ListControl();
        cc.setPicture("@s20");
        cc.setDrop(5);
        cc.setFrom(cq);
        cc.setAt(5,5,100,30);
        ClarionString cs = new ClarionString();
        cc.use(cs);
        
        w.add(cc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("",cs.toString().trim());

        Thread.sleep(500);
        getRobot().key(KeyEvent.VK_DOWN);
        Thread.sleep(500);
        getRobot().key(KeyEvent.VK_DOWN);

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("Item #0",cs.toString().trim());

        assertEquals(1,cc.getProperty(Prop.SELSTART).intValue());
        
        Thread.sleep(500);
        getRobot().key(KeyEvent.VK_DOWN);

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("Item #1",cs.toString().trim());

        assertEquals(2,cc.getProperty(Prop.SELSTART).intValue());

        Thread.sleep(500);
        
        cc.setProperty(Prop.SELSTART,5);

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals("Item #4",cs.toString().trim());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
        
    }

    
}
