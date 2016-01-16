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


import java.awt.Dimension;
import java.awt.event.KeyEvent;


import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class RadioTest  extends SwingTC {

    public RadioTest(String name) {
        super(name);
    }
    
    
    protected boolean isFlat()
    {
        return false;
    }
    
    protected boolean isBoxed()
    {
        return true;
    }

    public void testDynamic1()
    {
    	dynamicTest(1);
    }

    public void testDynamic2()
    {
    	dynamicTest(2);
    }
    
    public void testDynamic3()
    {
    	dynamicTest(3);
    }
    
    public void dynamicTest(int method)
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,200);

        w.open();
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();        
        
        ClarionString cs = new ClarionString(10);
        
        OptionControl oc = new OptionControl();
        oc.setConstructOnUnhide();
        oc.setHidden();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        oc.use(cs);
        w.add(oc);
        if (method==2) {
        	oc.setProperty(Prop.HIDE,0);
        }
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setConstructOnUnhide();
        r1.setHidden();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);
        if (method==2 || method==3) {
        	r1.setProperty(Prop.HIDE,0);
        }

        RadioControl r2 = newRadioControl();
        r2.setConstructOnUnhide();
        r2.setHidden();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);
        if (method==2 || method==3) {
        	r2.setProperty(Prop.HIDE,0);
        }

        RadioControl r3 = newRadioControl();
        r3.setConstructOnUnhide();
        r3.setHidden();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        if (method==2 || method==3) {
        	r3.setProperty(Prop.HIDE,0);
        }
        
        if (method==1) {
        	oc.setProperty(Prop.HIDE,0);
        	r1.setProperty(Prop.HIDE,0);
        	r2.setProperty(Prop.HIDE,0);
        	r3.setProperty(Prop.HIDE,0);
        }
        if (method==3) {
        	oc.setProperty(Prop.HIDE,0);
        }
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_SPACE);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals("v1",cs.toString().trim());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_DOWN);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals("v2",cs.toString().trim());
        w.consumeAccept();

        getRobot().key('R');
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals("v1",cs.toString().trim());
        w.consumeAccept();
        
        w.close();

    	
    }

    public void testTabBehaviourMultiOption()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,200);

        ClarionString cs = new ClarionString(10);
        ClarionString cs2 = new ClarionString(10);
        
        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        oc.use(cs);
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        
        OptionControl oc2 = new OptionControl();
        oc2.setText("&Options 2");
        oc2.setAt(5,65,null,null);
        oc2.setBoxed();
        oc2.use(cs2);
        
        RadioControl r4 = newRadioControl();
        r4.setAt(10,70,null,null);
        r4.setText("&Radio 1");
        r4.setValue("v1");
        oc2.add(r4);

        RadioControl r5 = newRadioControl();
        r5.setAt(10,80,null,null);
        r5.setText("R&adio 2");
        r5.setValue("v2");
        oc2.add(r5);

        RadioControl r6 = newRadioControl();
        r6.setAt(10,90,null,null);
        r6.setText("Ra&dio 3");
        r6.setValue("v3");
        oc2.add(r6);
        
        w.add(oc2);    	
        
        ClarionString es = new ClarionString();
        EntryControl ec = new EntryControl();
        ec.setAt(10,110,100,20);
        ec.use(es);
        ec.setPicture("@S20");
        w.add(ec);
        
        w.open();
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_SPACE);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r4.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_SPACE);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc2.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(ec.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r4.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.close();
    }
    
    public void testSelStartAndChoice()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        ClarionString cs = new ClarionString(10);
        
        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        oc.use(cs);
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,80,null,null);
        w.add(b);
        
        w.open();
        
        try {
            Thread.sleep(200);
        } catch (InterruptedException ex) { }
        
        CWin.select(oc.getUseID(),2);

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        /*
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(oc.getUseID()));
        assertEquals("v2",cs.toString().trim());
        w.consumeAccept();
        */
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        w.consumeAccept();
        
        w.setTimer(20);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
        
        cs.setValue("v3");
    }

    public void testToggle()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        ClarionString cs = new ClarionString(10);
        
        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        oc.use(cs);
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,80,null,null);
        w.add(b);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("          ",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_SPACE);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("v1        ",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        assertTrue( ((javax.swing.JToggleButton) cc(r1).getComponent()).isSelected() );
        
        getRobot().key(KeyEvent.VK_SPACE);

        assertEquals(1,CWin.choice(oc.getUseID()));
        assertTrue( ((javax.swing.JToggleButton) cc(r1).getComponent()).isSelected() );

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        assertEquals(1,CWin.choice(oc.getUseID()));
        assertTrue( ((javax.swing.JToggleButton) cc(r1).getComponent()).isSelected() );
        
        w.close();
    }


    public void testInitial()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        ClarionString cs = new ClarionString(10);
        
        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        oc.use(cs);
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,80,null,null);
        w.add(b);
        
        w.register(b);
        cs.setValue("v2");
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("v2        ",oc.getUseObject().toString());
        assertEquals(2,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_LEFT);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals("v1        ",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        w.close();
    }
    
    public void testSimple()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,80,null,null);
        w.add(b);
        
         w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r3.getUseID(),CWin.field());
        assertEquals(r3.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(b.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(' ');
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("v1",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_DOWN);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("v2",oc.getUseObject().toString());
        assertEquals(2,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        oc.getUseObject().setValue("v3");
        assertEquals(3,CWin.choice(oc.getUseID()));
        
        sleep(100);
        getRobot().key(KeyEvent.VK_UP);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("v1",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(b.getUseID(),CWin.focus());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        w.consumeAccept();
        
        w.close();
    }

    public void testDefaults()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,2,null,null);
        if (isBoxed()) oc.setBoxed();
        //oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        //r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        //r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,80,null,null);
        w.add(b);
        
         w.register(b);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r3.getUseID(),CWin.field());
        assertEquals(r3.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(b.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(' ');
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("1",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_DOWN);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("v2",oc.getUseObject().toString());
        assertEquals(2,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        oc.getUseObject().setValue("3");
        assertEquals(3,CWin.choice(oc.getUseID()));
        
        sleep(100);
        getRobot().key(KeyEvent.VK_UP);
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("1",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(b.getUseID(),CWin.focus());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        w.consumeAccept();
        
        w.close();
    }
    
    public void testDisabledOnStart()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5,5,null,null);
        if (isBoxed()) oc.setBoxed();
        
        RadioControl r1 = newRadioControl();
        r1.setAt(10,10,null,null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        r1.setDisabled();
        //r1.setHidden();
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10,20,null,null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10,30,null,null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);
        
        w.add(oc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,80,null,null);
        w.add(b);
        
        w.register(b);
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r3.getUseID(),CWin.field());
        assertEquals(r3.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        CWin.select(r1.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        r1.setProperty(Prop.DISABLE,false);
        CWin.select(r1.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r1.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("",oc.getUseObject().toString());
        assertEquals(0,CWin.choice(oc.getUseID()));
        w.consumeAccept();
 
        getRobot().key(' ');
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r1.getUseID(),CWin.focus());
        assertEquals("v1",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();

        oc.setProperty(Prop.DISABLE,true);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(b.getUseID(),CWin.field());
        assertEquals(b.getUseID(),CWin.focus());
        assertEquals("v1",oc.getUseObject().toString());
        w.consumeAccept();

        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        r1.setProperty(Prop.DISABLE,true);
        oc.setProperty(Prop.DISABLE,false);
        
        sleep(100);
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("v1",oc.getUseObject().toString());
        assertEquals(1,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        w.close();
    }
    
    public void testChangeText()
    {
            final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null, null, 200, 100);

        OptionControl oc = new OptionControl();
        oc.setText("&Options");
        oc.setAt(5, 2, null, null);
        if (isBoxed())
            oc.setBoxed();
        // oc.setBoxed();

        RadioControl r1 = newRadioControl();
        r1.setAt(10, 10, null, null);
        r1.setText("&Radio 1");
        r1.setValue("v1");
        oc.add(r1);

        RadioControl r2 = newRadioControl();
        r2.setAt(10, 20, null, null);
        r2.setText("R&adio 2");
        r2.setValue("v2");
        oc.add(r2);

        RadioControl r3 = newRadioControl();
        r3.setAt(10, 30, null, null);
        r3.setText("Ra&dio 3");
        r3.setValue("v3");
        oc.add(r3);

        w.add(oc);

        ButtonControl b = new ButtonControl();
        b.setText("All Good").setAt(10, 80, null, null);
        w.add(b);

        w.register(b);
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW, CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED, CWin.event());
        assertEquals(r1.getUseID(), CWin.field());
        assertEquals(r1.getUseID(), CWin.focus());
        assertEquals("", oc.getUseObject().toString());
        assertEquals(0, CWin.choice(oc.getUseID()));
        w.consumeAccept();

        assertEquals("Radio 1",cc(r1).getButton().getText());
        assertEquals("Radio 2",cc(r2).getButton().getText());
        assertEquals("Radio 3",cc(r3).getButton().getText());

        Dimension d = cc(r1).getButton().getSize();
        
        r1.setProperty(Prop.TEXT,"New Radio 1");
        r2.setProperty(Prop.TEXT,"More &Config");
        r3.setProperty(Prop.TEXT,"Even More Config");
        waitForEventQueueToCatchup();

        assertEquals("New Radio 1",cc(r1).getButton().getText());
        assertEquals("More Config",cc(r2).getButton().getText());
        assertEquals("Even More Config",cc(r3).getButton().getText());

        assertFalse(cc(r1).getButton().getSize().equals(d));
        
        getRobot().key('C');

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(r2.getUseID(),CWin.field());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        assertEquals(r2.getUseID(),CWin.focus());
        assertEquals("v2",oc.getUseObject().toString());
        assertEquals(2,CWin.choice(oc.getUseID()));
        w.consumeAccept();
        
        w.close();
    }


	private RadioControl newRadioControl() {
		RadioControl rc=  new RadioControl();
		if (isFlat()) rc.setFlat();
		return rc;
	}
}
