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

import javax.swing.JCheckBox;

import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class CheckTest  extends SwingTC {

    public CheckTest(String name) {
        super(name);
    }
    
    public void testRenameCheck()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        final CheckControl cc = new CheckControl();
        cc.setText("&Options");
        cc.setValue("True","False");
        ClarionString val=new ClarionString(); 
        cc.use(val);
        cc.setAt(5,5,null,null);
        w.add(cc);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        w.consumeAccept();
        
        assertEquals("Options",cc(cc).getButton().getText());
        Dimension od = cc(cc).getButton().getSize();
        
        cc.setProperty(Prop.TEXT,"More Options");
        waitForEventQueueToCatchup();
        assertEquals("More Options",cc(cc).getButton().getText());
        Dimension nd = cc(cc).getButton().getSize();
        assertTrue(nd.width>od.width);
        
        w.close();
    }
    
    public void testSimple() throws InterruptedException
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);

        final CheckControl cc = new CheckControl();
        cc.setText("&Options");
        cc.setValue("True","False");
        ClarionString val=new ClarionString(); 
        cc.use(val);
        cc.setAt(5,5,null,null);
        w.add(cc);
        
        ButtonControl b =  new ButtonControl();
        b.setText("All Good").setAt(10,15,null,null);
        w.add(b);

        EntryControl ec =  new EntryControl();
        ec.setText("@n$11.2").setAt(10,30,null,null);
        w.add(ec);
        
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
        
        assertEquals("",val.toString());
        
        sleep(100);
        getRobot().key(' ');

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        assertEquals("True",val.toString());
        w.consumeAccept();

        sleep(100);
        getRobot().key(' ');

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(cc.getUseID(),CWin.field());
        assertEquals("False",val.toString());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(false,((JCheckBox)cc(cc).getComponent()).isSelected());
            
        val.setValue("True");
        waitForEventQueueToCatchup();

        assertEquals(true,((JCheckBox)cc(cc).getComponent()).isSelected());
        

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        
        CWin.select(ec.getUseID());
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(ec.getUseID(),CWin.field());
        w.consumeAccept();
        
        Thread.sleep(100);
        getRobot().sleep();
        waitForEventQueueToCatchup();      
        getRobot().key('X');
        getRobot().sleep();
        waitForEventQueueToCatchup();
        Thread.sleep(100);
        
        getRobot().mousePress((Component)cc(cc).getComponent(),5,5);
        getRobot().mouseRelease();

        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(ec.getUseID(),CWin.field());
        w.consumeAccept();

        /*
        while (w.accept()) {
            System.out.println(CWin.eventString());
            w.consumeAccept();
        }
        */
        
        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        w.close();
    }
    
}
