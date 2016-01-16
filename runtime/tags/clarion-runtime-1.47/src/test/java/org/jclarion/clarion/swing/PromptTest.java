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

import javax.swing.JLabel;


import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class PromptTest extends SwingTC
{

    public PromptTest(String name) {
        super(name);
    }

    public void testString()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        
        final PromptControl p1 =  new PromptControl();
        p1.setText("Field &A").setAt(5,20,null,null);
        w.add(p1);
        
        final EntryControl e1 = new EntryControl();
        e1.setText("@s20");
        e1.setAt(40,20,100,null);
        w.add(e1);

        final PromptControl p2 =  new PromptControl();
        p2.setText("Field &B").setAt(5,30,null,null);
        w.add(p2);
        
        final EntryControl e2 = new EntryControl();
        e2.setText("@n10.2");
        e2.setAt(40,30,100,null);
        w.add(e2);

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
        
        sleep(100);
        getRobot().key('B',KeyEvent.ALT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key('1');

        sleep(100);
        getRobot().key('A',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        assertEquals("1",e2.getUseObject().toString());
        w.consumeAccept();

        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        
        sleep(100);
        getRobot().key('B',KeyEvent.ALT_MASK);

        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(e1.getUseID(),CWin.field());
        assertEquals("abc",e1.getUseObject().toString());
        w.consumeAccept();
        
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key('A');
        getRobot().key('B');
        getRobot().key('C');
        
        sleep(100);
        getRobot().key('A',KeyEvent.ALT_MASK);
        
        assertTrue(w.accept());
        assertEquals(Event.REJECTED,CWin.event());
        assertEquals(e2.getUseID(),CWin.field());
        assertEquals(e2.getUseID(),CWin.focus());
        w.consumeAccept();

        assertEquals(e2.getUseID(),CWin.focus());
        
        sleep(100);
        assertEquals(4,e1.getProperty(Prop.SELSTART).intValue());
        assertEquals(0,e1.getProperty(Prop.SELEND).intValue());
        assertEquals(1,e2.getProperty(Prop.SELSTART).intValue());
        assertEquals(4,e2.getProperty(Prop.SELEND).intValue());

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        assertEquals(e2.getUseID(),CWin.focus());

        w.close();
    }
    

    public String getSWTText(final AbstractControl c) {
        return ((JLabel)c.getComponent()).getText();
    };
    
    
    
    
}
