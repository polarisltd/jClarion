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
import java.awt.event.InputEvent;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JLabel;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class StringTest extends SwingTC
{

    public StringTest(String name) {
        super(name);
    }
    
    public void testCopy()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        StringControl s1 = new StringControl();
        s1.setText("Hello Big Wide World").setAt(20,20,null,null);
        w.add(s1);

        StringControl s2 = new StringControl();
        ClarionDecimal cn = new ClarionDecimal("1234.56");
        s2.use(cn);
        s2.setPicture("@n$10.2");
        s2.setAt(20,50,null,null);
        w.add(s2);
        
        w.open();
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        waitForEventQueueToCatchup();
        
        getRobot().mousePress(cc(s2).getComponent(),0,0,InputEvent.BUTTON3_MASK);
        getRobot().mouseRelease(InputEvent.BUTTON3_MASK);
        waitForEventQueueToCatchup();
        getRobot().mousePress(cc(s2).getComponent(),10,10);
        getRobot().mouseRelease();
        waitForEventQueueToCatchup();
        assertEquals("1234.56",CWin.getClipboard().toString());

        getRobot().mousePress(cc(s1).getComponent(),0,0,InputEvent.BUTTON3_MASK);
        getRobot().mouseRelease(InputEvent.BUTTON3_MASK);
        waitForEventQueueToCatchup();
        getRobot().mousePress(cc(s1).getComponent(),10,10);
        getRobot().mouseRelease();
        waitForEventQueueToCatchup();
        assertEquals("Hello Big Wide World",CWin.getClipboard().toString());
        
        w.close();
    }

    public void testDate()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        StringControl s2 = new StringControl();
        ClarionNumber cn = new ClarionNumber();
        cn.setValue(CDate.date(7,20,1969));
        s2.use(cn);
        s2.setPicture("@d6.");
        s2.setAt(20,50,null,null);
        w.add(s2);
        
        w.open();
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        waitForEventQueueToCatchup();
        
        getRobot().mousePress(cc(s2).getComponent(),0,0,InputEvent.BUTTON3_MASK);
        getRobot().mouseRelease(InputEvent.BUTTON3_MASK);
        waitForEventQueueToCatchup();
        getRobot().mousePress(cc(s2).getComponent(),10,10);
        getRobot().mouseRelease();
        waitForEventQueueToCatchup();
        assertEquals("20.7.1969",CWin.getClipboard().toString());
        
        w.close();
    }
    
    public void testReuseResetDimensions()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        StringControl s1 = new StringControl();
        s1.setText("Hello Big Wide World").setAt(20,20,null,null);
        w.add(s1);

        w.open();        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        waitForEventQueueToCatchup();
        
        Dimension d = cc(s1).getComponent().getSize();
        assertNotNull(d);
        
        w.close();
        
        w.open();        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        waitForEventQueueToCatchup();

        Dimension d2 = cc(s1).getComponent().getSize();
        assertNotNull(d2);
        assertEquals(d,d2);
        
        w.close();
    }
    
    public void testChangeUseVar()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        StringControl s1 = new StringControl();
        s1.setText("@s20").setAt(20,20,null,null);
        s1.use(new ClarionString(20));
        w.add(s1);
    	
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("",getSWTText(s1));
        
        ClarionString sn = new ClarionString(20);
        s1.use(sn);
        
        CWin.display();
        waitForEventQueueToCatchup();
        
        assertEquals("",getSWTText(s1));

        sn.setValue("Changed");
        
        CWin.display();
        waitForEventQueueToCatchup();
        
        assertEquals("Changed",getSWTText(s1));
        
        
        sn = new ClarionString(20);
        sn.setEncoding(ClarionString.CSTRING);
        Clarion.getControl(s1.getUseID()).setProperty(Prop.USE,sn);
        
        CWin.display(s1.getUseID());
        waitForEventQueueToCatchup();
        
        assertEquals("",getSWTText(s1));
        
        sn.setValue("Changed");
        
        CWin.display();
        waitForEventQueueToCatchup();
        
        assertEquals("Changed",getSWTText(s1));

        w.close();
    }
    
    public void testChangeColor()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        StringControl s1 = new StringControl();
        s1.setText("Hello World").setAt(20,20,null,null);

        w.add(s1);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        Map<Integer,java.awt.Color> colors=new HashMap<Integer, java.awt.Color>();
        colors.put(Color.RED,java.awt.Color.RED);
        colors.put(Color.GREEN,new java.awt.Color(0,128,0));
        colors.put(Color.BLUE,java.awt.Color.BLUE);
        colors.put(Color.BLACK,java.awt.Color.BLACK);
        colors.put(Color.WHITE,java.awt.Color.WHITE);
        colors.put(Color.YELLOW,java.awt.Color.YELLOW);
        
        for ( Map.Entry<Integer,java.awt.Color> e : colors.entrySet() ) {
            s1.setProperty(Prop.FONTCOLOR,e.getKey());
            waitForEventQueueToCatchup();
            assertEquals(e.getValue(),cc(s1).getLabel().getForeground());
        }
        
        for ( Map.Entry<Integer,java.awt.Color> e : colors.entrySet() ) {
            s1.setProperty(Prop.BACKGROUND,e.getKey());
            waitForEventQueueToCatchup();
            assertEquals(e.getValue(),cc(s1).getLabel().getBackground());
        }
        
        w.close();
    }
    
    public void testStringDefaultLengthIsBasedOnPattern()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        StringControl s1 = new StringControl();
        s1.setText("@n$13.2").setAt(20,20,null,null);
        ClarionString cs1 = new ClarionString("1234.56");
        s1.use(cs1);

        StringControl s2 = new StringControl();
        s2.setText("@n$13.2").setAt(20,20,null,null);
        ClarionString cs2 = new ClarionString("0");
        s2.use(cs2);
        
        w.add(s1);
        w.add(s2);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
    
        assertEquals(s1.getProperty(Prop.WIDTH).intValue(),s2.getProperty(Prop.WIDTH).intValue());

        assertTrue(s1.getProperty(Prop.WIDTH).intValue()>20);
        
        w.close();
    }
    
    public void testString()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("All Good").setAt(20,20,null,null);
        w.add(s);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("All Good",getSWTText(s));
        
        s.setProperty(Prop.TEXT,"Not All Good");
        
        assertEquals("Not All Good",getSWTText(s));

        s.setProperty(Prop.TEXT,"Good & Bad");
        
        assertEquals("Good & Bad",getSWTText(s));

        assertEquals(Create.STRING,s.getProperty(Prop.TYPE).intValue());
        
        w.close();
    }
    
    public void testUseString()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("@n$12.2").setAt(20,20,100,null);
        ClarionDecimal cd = new ClarionDecimal("213.12");
        s.use(cd);
        w.add(s);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$213.12",getSWTText(s));
        
        s.setProperty(Prop.TEXT,"@s10");
        
        assertEquals("213.12",getSWTText(s));

        s.setProperty(Prop.TEXT,"@n$12.2~ RM~b");
        
        assertEquals("$213.12 RM",getSWTText(s));

        cd.setValue(0);
        CWin.display();
        
        assertEquals("",getSWTText(s));
        
        cd.setValue("1234.56");
        CWin.display();
        
        assertEquals("$1,234.56 RM",getSWTText(s));

        w.close();
    }

    public void testUseThreadedString()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  (new StringControl());
        s.setText("@n$12.2").setAt(20,20,100,null);
        ClarionDecimal cd = (new ClarionDecimal("213.12")).setThread();
        s.use(cd);
        w.add(s);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$213.12",getSWTText(s));
        
        s.setProperty(Prop.TEXT,"@s10");
        
        assertEquals("213.12",getSWTText(s));

        s.setProperty(Prop.TEXT,"@n$12.2~ RM~b");
        
        assertEquals("$213.12 RM",getSWTText(s));

        cd.setValue(0);
        CWin.display();
        
        assertEquals("",getSWTText(s));
        
        cd.setValue("1234.56");
        CWin.display();
        
        assertEquals("$1,234.56 RM",getSWTText(s));

        w.close();
    }
    
    public void testUseStringChangePicture()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("@n12.2").setAt(20,20,100,null);
        ClarionNumber cn = new ClarionNumber(84231);
        s.use(cn);
        w.add(s);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("84,231.00",getSWTText(s));
        
        s.setProperty(Prop.TEXT,"@d6.");
        
        assertEquals("10.8.2031",getSWTText(s));


        w.close();
    }
    
    public void testUseStringChangeUseVar()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("@n$12.2").setAt(20,20,100,null);
        
        ClarionDecimal cd = new ClarionDecimal("213.12");
        ClarionDecimal cd2 = new ClarionDecimal("100.00");
        
        s.use(cd);
        w.add(s);
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$213.12",getSWTText(s));
        
        cd.setValue(0);
        CWin.display();
        assertEquals("$0.00",getSWTText(s));
        
        cd.setValue("1234.56");
        CWin.display();
        assertEquals("$1,234.56",getSWTText(s));

        
        s.use(cd2);
        assertEquals("$100.00",getSWTText(s));
        
        cd.setValue("789.12");
        CWin.display();
        assertEquals("$100.00",getSWTText(s));

        cd2.setValue("987.65");
        CWin.display();
        assertEquals("$987.65",getSWTText(s));
        
        w.close();
    }

    public void testUseStringChangeUseVarViaProp()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("@n$12.2").setAt(20,20,100,null);
        
        ClarionDecimal cd = new ClarionDecimal("213.12");
        ClarionDecimal cd2 = new ClarionDecimal("100.00");
        
        s.use(cd);
        w.add(s);
        w.open();

        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$213.12",getSWTText(s));
        
        cd.setValue(0);
        CWin.display();
        assertEquals("$0.00",getSWTText(s));
        
        cd.setValue("1234.56");
        CWin.display();
        assertEquals("$1,234.56",getSWTText(s));

        
        s.setProperty(Prop.USE,cd2);
        assertEquals("$100.00",getSWTText(s));
        
        cd.setValue("789.12");
        CWin.display();
        assertEquals("$100.00",getSWTText(s));

        cd2.setValue("987.65");
        CWin.display();
        assertEquals("$987.65",getSWTText(s));
        
        w.close();
    }
    
    public void testUseStringPostCloseUpdateAfterGC()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("@n$12.2").setAt(20,20,100,null);
        ClarionDecimal cd = new ClarionDecimal("213.12");
        s.use(cd);
        w.add(s);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$213.12",getSWTText(s));
        
        s.setProperty(Prop.TEXT,"@s10");
        
        assertEquals("213.12",getSWTText(s));

        s.setProperty(Prop.TEXT,"@n$12.2~ RM~b");
        
        assertEquals("$213.12 RM",getSWTText(s));

        cd.setValue(0);
        CWin.display();
        
        assertEquals("",getSWTText(s));
        
        cd.setValue("1234.56");
        CWin.display();
        
        assertEquals("$1,234.56 RM",getSWTText(s));

        w.close();

        System.gc();
        Thread.yield();
        
        cd.setValue("666");
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$666.00 RM",getSWTText(s));
        
        w.close();
        
    }
    
    
    public void testUseStringPostCloseUpdate()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final StringControl s =  new StringControl();
        s.setText("@n$12.2").setAt(20,20,100,null);
        ClarionDecimal cd = new ClarionDecimal("213.12");
        s.use(cd);
        w.add(s);
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$213.12",getSWTText(s));
        
        s.setProperty(Prop.TEXT,"@s10");
        
        assertEquals("213.12",getSWTText(s));

        s.setProperty(Prop.TEXT,"@n$12.2~ RM~b");
        
        assertEquals("$213.12 RM",getSWTText(s));

        cd.setValue(0);
        CWin.display();
        
        assertEquals("",getSWTText(s));
        
        cd.setValue("1234.56");
        CWin.display();
        
        assertEquals("$1,234.56 RM",getSWTText(s));

        w.close();

        cd.setValue("666");
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertEquals("$666.00 RM",getSWTText(s));
        
        w.close();
        
    }

    private String getSWTText(final AbstractControl c) {
        waitForEventQueueToCatchup();
        return ((JLabel)cc(c).getComponent()).getText();
    };
}
