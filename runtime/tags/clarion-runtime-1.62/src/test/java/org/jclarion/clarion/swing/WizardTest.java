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

import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;


public class WizardTest extends SwingTC {

    public WizardTest(String name) {
        super(name);
    }
    
    public void testChangeToTabWithEmptyListControl()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        sheet.setWizard();
        sheet.setBoxed();
        w.add(sheet);
        
        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        StringControl s1 = new StringControl();
        s1.setText("Name:");
        s1.setAt(5,10,null,null);
        t1.add(s1);

        StringControl s2 = new StringControl();
        s2.setText("Address:");
        s2.setAt(5,24,null,null);
        t1.add(s2);

        EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(40,10,null,null);
        t1.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s30");
        e2.setAt(40,24,null,null);
        t1.add(e2);
        
        
        TabControl t2 = new TabControl();
        t2.setText("T&ab 2");
        sheet.add(t2);
    	
        ListControl lc = new ListControl();
        //lc.setFrom("Apples|Oranges|Pairs");
        lc.setAt(10,20,180,90);
        t2.add(lc);
        
        ButtonControl bc1 = new ButtonControl();
        bc1.setAt(5,125,80,15);
        bc1.setText("Button A");
        t2.add(bc1);

        ButtonControl bc2 = new ButtonControl();
        bc2.setAt(100,125,80,15);
        bc2.setText("Button B");
        t2.add(bc2);

        TabControl t3 = new TabControl();
        t3.setText("T&ab 3");
        sheet.add(t3);

        ButtonControl bc3 = new ButtonControl();
        bc3.setAt(100,125,80,15);
        bc3.setText("Button C");
        bc3.setDisabled();
        t3.add(bc3);
        
        w.open();
        CWin.alert(Constants.F2KEY);
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(sheet.getUseID()));
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        assertEquals(1,CWin.choice(sheet.getUseID()));
        
        CWin.select(sheet.getUseID(),2);
        
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc1.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc2.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();
        
        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc1.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(bc2.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));        
        w.consumeAccept();
        
        lc.getFrom().who(1).setValue("Apples");
        lc.getFrom().add();
        CWin.display();
        waitForEventQueueToCatchup();

        getRobot().key(KeyEvent.VK_TAB);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(lc.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(lc.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(lc.getUseID(),CWin.field());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        
        CWin.select(sheet.getUseID(),3);

        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(3,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        assertEquals(3,CWin.choice(sheet.getUseID()));
        w.consumeAccept();
        
        w.setTimer(1);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        getRobot().key(KeyEvent.VK_F2);

        assertTrue(w.accept());
        assertEquals(Event.PREALERTKEY,CWin.event());
        assertEquals(Constants.F2KEY,CWin.keyCode());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ALERTKEY,CWin.event());
        assertEquals(Constants.F2KEY,CWin.keyCode());
        w.consumeAccept();

        getRobot().key(KeyEvent.VK_ESCAPE);
        
        assertTrue(w.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        w.consumeAccept();
        
        w.close();
    }
    
    public void testOnSelectGeneratesSelectAndSelectsAll()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        
        SheetControl sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        sheet.setWizard();
        sheet.setBoxed();
        w.add(sheet);
        
        TabControl t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        StringControl s1 = new StringControl();
        s1.setText("Name:");
        s1.setAt(5,10,null,null);
        t1.add(s1);

        StringControl s2 = new StringControl();
        s2.setText("Address:");
        s2.setAt(5,24,null,null);
        t1.add(s2);

        EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(40,10,null,null);
        t1.add(e1);

        EntryControl e2 = new EntryControl();
        e2.setText("@s30");
        e2.setAt(40,24,null,null);
        t1.add(e2);
        
        
        TabControl t2 = new TabControl();
        t2.setText("T&ab 2");
        sheet.add(t2);
        
        ButtonControl b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,5,null,null);
        t2.add(b);
        
        EntryControl eb = new EntryControl();
        eb.setText("@n$11.2");
        eb.setAt(50,5,null,null);
        t2.add(eb);
        
        TabControl t3 = new TabControl();
        t3.setText("Ta&b 3");
        sheet.add(t3);
        
        GroupControl g = new GroupControl();
        g.setText("Hello");
        g.setAt(5,5,190,100);
        g.setDisabled();
        g.setBoxed();
        //g.setBevel(1,1,null);
        t3.add(g);
        
        ButtonControl b3 = new ButtonControl();
        b3.setText("Press Me");
        b3.setAt(10,20,null,null);
        g.add(b3);

        ButtonControl b5 = new ButtonControl();
        b5.setText("Press Me 2");
        b5.setAt(50,20,null,null);
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
        
        sleep(100);
        getRobot().key('A');
        getRobot().key('N');
        getRobot().key('D');
        getRobot().key('Y');
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        
        CWin.select(t2.getUseID());
        
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
        getRobot().key(KeyEvent.VK_TAB,KeyEvent.SHIFT_MASK);
        
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

        getRobot().waitForIdle();
        waitForEventQueueToCatchup();

        CWin.select(t1.getUseID());

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

        assertNull(w.getRefocus());
        
        sleep(100);
        getRobot().key('1');
        getRobot().key('.');
        getRobot().key('2');
        
        sleep(100);
        
        CWin.select(t3.getUseID());

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

        sleep(100);
        CWin.select(t2.getUseID());
        
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
        assertEquals(r1.getUseID(),CWin.field());
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
