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
import java.awt.event.KeyEvent;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.SpinControl;
import org.jclarion.clarion.runtime.CWin;


public class SpinTest extends SwingTC {

    public SpinTest(String name) {
        super(name);
    }

    
    public void testSimple()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(40,40,100,100);
        cw.setText("test");
        
        ClarionNumber val = new ClarionNumber(200);
        SpinControl sc = new SpinControl();
        sc.setAt(5,5,40,20);
        sc.setText("@n4");
        sc.use(val);
        sc.setStep(5);
        sc.setRange(100,1000);
        cw.add(sc);
        
        ButtonControl ok = new ButtonControl();
        ok.setAt(5,30,50,null);
        ok.setText("&Ok");
        cw.add(ok);
        
        
        cw.open();
        
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();

        assertTrue(cw.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        cw.consumeAccept();

        getRobot().key('1');
        getRobot().key('5');
        getRobot().key('1');
        getRobot().key(KeyEvent.VK_TAB);
        getRobot().waitForIdle();

        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(151,val.intValue());
        cw.consumeAccept();

        assertTrue(cw.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(ok.getUseID(),CWin.field());
        cw.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);
        getRobot().waitForIdle();
        
        assertTrue(cw.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        cw.consumeAccept();
        
        getRobot().key('2');
        getRobot().key('2');
        getRobot().key(KeyEvent.VK_TAB);
        getRobot().waitForIdle();

        assertTrue(cw.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        cw.consumeAccept();
        
        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);

        getRobot().key('1');
        getRobot().key('2');
        getRobot().key('3');
        getRobot().key('4');
        getRobot().key(KeyEvent.VK_TAB);
        getRobot().waitForIdle();

        assertTrue(cw.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(151,val.intValue());
        cw.consumeAccept();
        
        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);
        
        assertEquals(151,val.intValue());
        
        Component c = cc(sc).getComponent();
        Dimension d = c.getSize();

        assertEquals("151",cc(sc).getField().getText());
        
        getRobot().mousePress(c,d.width-5,5);
        getRobot().mouseRelease();
        
        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(156,val.intValue());
        assertEquals("156",cc(sc).getField().getText());
        cw.consumeAccept();
        
        getRobot().mousePress(c,d.width-5,5);
        getRobot().mouseRelease();
        
        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(161,val.intValue());
        assertEquals("161",cc(sc).getField().getText());
        cw.consumeAccept();

        getRobot().mousePress(c,d.width-5,d.height-5);
        getRobot().mouseRelease();
        
        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(156,val.intValue());
        assertEquals("156",cc(sc).getField().getText());
        cw.consumeAccept();
        
        val.setValue(106);

        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);
        
        assertEquals(106,sc.getProperty(Prop.SCREENTEXT).intValue());

        getRobot().mousePress(c,d.width-5,d.height-5);
        getRobot().mouseRelease();
        
        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(101,val.intValue());
        cw.consumeAccept();
        
        getRobot().mousePress(c,d.width-5,d.height-5);
        getRobot().mouseRelease();

        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);

        assertEquals(101,val.intValue());


        val.setValue(992);

        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);
        
        assertEquals(992,sc.getProperty(Prop.SCREENTEXT).intValue());

        getRobot().mousePress(c,d.width-5,5);
        getRobot().mouseRelease();
        
        assertTrue(cw.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(sc.getUseID(),CWin.field());
        assertEquals(997,val.intValue());
        cw.consumeAccept();
        
        getRobot().mousePress(c,d.width-5,5);
        getRobot().mouseRelease();

        cw.setTimer(10);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);

        assertEquals(997,val.intValue());
        
        cw.close();
    }

    public void testReadTouched()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        w.setCenter();
    	
        ClarionNumber cs = new ClarionNumber(0);
        //cs.setValue("Hello");
        SpinControl e1 = new SpinControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@n5");
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
    	
        ClarionNumber cs = new ClarionNumber(0);
        //cs.setValue("Hello");
        SpinControl e1 = new SpinControl();
        e1.use(cs);
        e1.setAt(5,5,150,15);
        e1.setText("@n5");
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
        assertEquals("0",cs.toString().trim());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        w.consumeAccept();

        assertEquals(0,e1.getProperty(Prop.TOUCHED).intValue());

        w.close();
    }
    
}
