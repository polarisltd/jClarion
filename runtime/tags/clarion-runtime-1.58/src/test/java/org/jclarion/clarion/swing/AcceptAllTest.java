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

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.runtime.CWin;

public class AcceptAllTest  extends SwingTC
{

    public AcceptAllTest(String name) {
        super(name);
    }
    
    ClarionWindow w;
    SheetControl sheet;
    TabControl t1;
    StringControl s1;
    StringControl s2;
    EntryControl e1;
    EntryControl e2;
    TabControl t2;
    ButtonControl b;
    EntryControl eb;
    TabControl t3;
    GroupControl g;
    ButtonControl b3;
    ButtonControl b5;
    OptionControl oc;
    RadioControl r1;
    RadioControl r2;
    ButtonControl b4;
    
    public void init()
    {
        w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        w.setResize();
        
        sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);
        
        t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        s1 = new StringControl();
        s1.setText("Name:");
        s1.setAt(5,15,null,null);
        t1.add(s1);

        s2 = new StringControl();
        s2.setText("Address:");
        s2.setAt(5,29,null,null);
        t1.add(s2);

        e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(40,15,null,null);
        t1.add(e1);

        e2 = new EntryControl();
        e2.setText("@s30");
        e2.setAt(40,29,null,null);
        t1.add(e2);
        
        
        t2 = new TabControl();
        t2.setText("T&ab 2");
        sheet.add(t2);
        
        b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,15,null,null);
        t2.add(b);
        
        eb = new EntryControl();
        eb.setText("@n$11.2");
        eb.setAt(50,15,null,null);
        t2.add(eb);
        
        t3 = new TabControl();
        t3.setText("Ta&b 3");
        sheet.add(t3);
        
        g = new GroupControl();
        g.setText("Hello");
        g.setAt(5,15,190,100);
        g.setDisabled();
        g.setBoxed();
        //g.setBevel(1,1,null);
        t3.add(g);
        
        b3 = new ButtonControl();
        b3.setText("Press Me");
        b3.setAt(10,25,null,null);
        g.add(b3);

        b5 = new ButtonControl();
        b5.setText("Press Me 2");
        b5.setAt(70,25,null,null);
        b5.setHidden();
        g.add(b5);
        
        oc = new OptionControl();
        oc.setAt(20,40,null,null);
        oc.setText("Some Option");
        //oc.setBoxed();
        g.add(oc);
        
        r1 = new RadioControl();
        r1.setText("Selection A");
        r1.setAt(30,55,null,null);
        oc.add(r1);
        r2 = new RadioControl();
        r2.setText("Selection B");
        r2.setAt(30,70,null,null);
        oc.add(r2);
        
        b4 = new ButtonControl();
        b4.setText("Toggle");
        b4.setAt(10,110,null,null);
        t3.add(b4);

        
    }

    public void testAcceptAllSimple()
    {
        init();
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();
        
        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        w.close();
    }

    public void testAcceptAllTwice()
    {
        init();
        
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();
        
        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
        
    public void testAcceptNoDisable()
    {
        init();
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();
        
        g.setProperty(Prop.DISABLE,false);

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(oc.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }
    

    public void testRejectBecauseOfRequired()
    {
        init();
        eb.setRequired();
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        g.setProperty(Prop.DISABLE,false);

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }
    
    public void testAcceptAllRequiredIsOk()
    {
        init();
        eb.setRequired();
        eb.use(new ClarionNumber(2));
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }    

    public void testAcceptAllAbortOnExplicitClearAcceptAll_A()
    {
        init();
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        w.setProperty(Prop.ACCEPTALL,0);
        
        /**
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        */
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }    

    
    public void testAcceptAllAbortOnSelect_A()
    {
        init();
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        CWin.select(eb.getUseID());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.TABCHANGING,CWin.event());
        assertEquals(2,CWin.choice(sheet.getUseID()));
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.NEWSELECTION,CWin.event());
        assertEquals(sheet.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }    
    
    public void testAcceptAllAbortOnExplicitClearAcceptAll_B()
    {
        init();
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        CWin.select();
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();

        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(eb.getUseID(),CWin.field());
        w.consumeAccept();
        
        w.setProperty(Prop.ACCEPTALL,0);
        /*
        assertTrue(w.accept());
        assertEquals(Event.COMPLETED,CWin.event());
        w.consumeAccept();
        */
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        w.close();
    }    
    
}
