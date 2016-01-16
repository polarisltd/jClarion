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
package org.jclarion.clarion.control;

import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.*;

import junit.framework.TestCase;

public class ControlIteratorTest extends TestCase {

    ClarionWindow w;
    SheetControl sheet;
    TabControl t1;
    StringControl s1;
    ButtonControl b4;
    RadioControl r2;
    RadioControl r1;
    OptionControl oc;
    ButtonControl b5;
    ButtonControl b3;
    GroupControl g;
    TabControl t3;
    EntryControl eb;
    ButtonControl b;
    TabControl t2;
    EntryControl e2;
    EntryControl e1;
    StringControl s2;
    
    
    
    public void setUp()
    {
        w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        
        sheet = new SheetControl();
        sheet.setAt(1,1,198,148);
        w.add(sheet);
        
        t1 = new TabControl();
        t1.setText("&Tab 1");
        sheet.add(t1);
        
        s1 = new StringControl();
        s1.setText("Name:");
        s1.setAt(5,10,null,null);
        t1.add(s1);

        s2 = new StringControl();
        s2.setText("Address:");
        s2.setAt(5,24,null,null);
        t1.add(s2);

        e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(40,10,null,null);
        t1.add(e1);

        e2 = new EntryControl();
        e2.setText("@s30");
        e2.setAt(40,24,null,null);
        t1.add(e2);
        
        
        t2 = new TabControl();
        t2.setText("T&ab 2");
        sheet.add(t2);
        
        b = new ButtonControl();
        b.setText("Hello");
        b.setAt(5,5,null,null);
        t2.add(b);
        
        eb = new EntryControl();
        eb.setText("@n$11.2");
        eb.setAt(50,5,null,null);
        t2.add(eb);
        
        t3 = new TabControl();
        t3.setText("Ta&b 3");
        sheet.add(t3);
        
        g = new GroupControl();
        g.setText("Hello");
        g.setAt(5,5,190,100);
        g.setDisabled();
        g.setBoxed();
        //g.setBevel(1,1,null);
        t3.add(g);
        
        b3 = new ButtonControl();
        b3.setText("Press Me");
        b3.setAt(10,20,null,null);
        g.add(b3);

        b5 = new ButtonControl();
        b5.setText("Press Me 2");
        b5.setAt(70,20,null,null);
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

    public void testIsAllowedChecksEntireTree()
    {
        g.setDisabled();
        
        ControlIterator ci = new ControlIterator(g,true);
        assertFalse(ci.isAllowed(g));
        assertFalse(ci.isAllowed(oc));
    }

    public void testNextFieldIterator()
    {
        int array[] = { 
                sheet.getUseID(),
                t1.getUseID(),
                s1.getUseID(),
                s2.getUseID(),
                e1.getUseID(),
                e2.getUseID(),
                t2.getUseID(),
                b.getUseID(),
                eb.getUseID(),
                t3.getUseID(),
                g.getUseID(),
                b3.getUseID(),
                b5.getUseID(),
                oc.getUseID(),
                r1.getUseID(),
                r2.getUseID(),
                b4.getUseID(),
        };
        
        int scan=0;
        int count=0;
        
        while ( true ) {
            int nscan = w.getProperty(Prop.NEXTFIELD,scan).intValue();
            if (nscan==0) break;
            assertEquals(array[count++],nscan);
            scan=nscan;
        }
        assertEquals(17,count);
        
        assertEquals(b3.getUseID(),g.getProperty(Prop.CHILD,1).intValue());
        assertEquals(b5.getUseID(),g.getProperty(Prop.CHILD,2).intValue());
        assertEquals(oc.getUseID(),g.getProperty(Prop.CHILD,3).intValue());
        assertEquals(0,g.getProperty(Prop.CHILD,0).intValue());
        assertEquals(0,g.getProperty(Prop.CHILD,4).intValue());

        assertEquals(sheet.getUseID(),w.getProperty(Prop.CHILD,1).intValue());
        assertEquals(0,w.getProperty(Prop.CHILD,0).intValue());
        assertEquals(0,w.getProperty(Prop.CHILD,4).intValue());
        
        assertEquals(1,g.getProperty(Prop.CHILDINDEX,b3.getUseID()).intValue());
        assertEquals(2,g.getProperty(Prop.CHILDINDEX,b5.getUseID()).intValue());
        assertEquals(3,g.getProperty(Prop.CHILDINDEX,oc.getUseID()).intValue());
    }

    public void testAll()
    {
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(w);
        ci.setScanSheets(true);
        ci.setScanDisabled(true);
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(s1,ci.next());
        assertEquals(s2,ci.next());
        assertEquals(e1,ci.next());
        assertEquals(e2,ci.next());
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertEquals(g,ci.next());
        assertEquals(b3,ci.next());
        assertEquals(b5,ci.next());
        assertEquals(oc,ci.next());
        assertEquals(r1,ci.next());
        assertEquals(r2,ci.next());
        assertEquals(b4,ci.next());
        assertFalse(ci.hasNext());
        
    }

    public void testAllOffsetIncludes()
    {
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(e2,true);
        ci.setScanSheets(true);
        ci.setScanDisabled(true);
        assertEquals(e2,ci.next());
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertEquals(g,ci.next());
        assertEquals(b3,ci.next());
        assertEquals(b5,ci.next());
        assertEquals(oc,ci.next());
        assertEquals(r1,ci.next());
        assertEquals(r2,ci.next());
        assertEquals(b4,ci.next());
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(s1,ci.next());
        assertEquals(s2,ci.next());
        assertEquals(e1,ci.next());
        assertFalse(ci.hasNext());
        
    }
    
    public void testAllOffsetNoIncludes()
    {
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(e2,false);
        ci.setScanSheets(true);
        ci.setScanDisabled(true);
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertEquals(g,ci.next());
        assertEquals(b3,ci.next());
        assertEquals(b5,ci.next());
        assertEquals(oc,ci.next());
        assertEquals(r1,ci.next());
        assertEquals(r2,ci.next());
        assertEquals(b4,ci.next());
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(s1,ci.next());
        assertEquals(s2,ci.next());
        assertEquals(e1,ci.next());
        assertEquals(e2,ci.next());
        assertFalse(ci.hasNext());
    }

    public void testSkipDisabled()
    {
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(w);
        ci.setScanSheets(true);
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(s1,ci.next());
        assertEquals(s2,ci.next());
        assertEquals(e1,ci.next());
        assertEquals(e2,ci.next());
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertEquals(b4,ci.next());
        assertFalse(ci.hasNext());
        
    }

    public void testSkipHidden()
    {
        e2.setHidden();
        
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(w);
        ci.setScanSheets(true);
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(s1,ci.next());
        assertEquals(s2,ci.next());
        assertEquals(e1,ci.next());
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertEquals(b4,ci.next());
        assertFalse(ci.hasNext());
        
    }

    public void testSkipHiddenIgnored()
    {
        e2.setHidden();
        
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(w);
        ci.setScanSheets(true);
        ci.setScanHidden(true);
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(s1,ci.next());
        assertEquals(s2,ci.next());
        assertEquals(e1,ci.next());
        assertEquals(e2,ci.next());
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertEquals(b4,ci.next());
        assertFalse(ci.hasNext());
        
    }

    public void testSkipUnselectedSheets()
    {
        // test from top
        ControlIterator ci;
        ci = new ControlIterator(w);
        sheet.setProperty(Prop.SELSTART,2);
        
        assertEquals(sheet,ci.next());
        assertEquals(t1,ci.next());
        assertEquals(t2,ci.next());
        assertEquals(b,ci.next());
        assertEquals(eb,ci.next());
        assertEquals(t3,ci.next());
        assertFalse(ci.hasNext());
        
    }
    
    
}
