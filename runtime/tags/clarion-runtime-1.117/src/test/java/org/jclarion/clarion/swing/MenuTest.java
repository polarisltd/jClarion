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
import org.jclarion.clarion.control.ItemControl;
import org.jclarion.clarion.control.MenuControl;
import org.jclarion.clarion.control.MenubarControl;
import org.jclarion.clarion.control.SeparatorControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class MenuTest extends SwingTC
{

    public MenuTest(String name) {
        super(name);
    }

    
    public void testSimple()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,500,250);
        w.setCenter();
        
        MenubarControl mb = new MenubarControl();
        w.add(mb);
        
        MenuControl m1 = new MenuControl();
        m1.setText("&File");
        ItemControl i11 = new ItemControl();
        i11.setText("&Open");
        ItemControl i12 = new ItemControl();
        i12.setText("&Save");
        ItemControl i13 = new ItemControl();
        i13.setText("&Disabled").setDisabled();
        ItemControl i14 = new ItemControl();
        i14.setText("H&idden").setHidden();
        m1.add(i11);
        m1.add(i12);
        m1.add(i13);
        m1.add(i14);
        mb.add(m1);

        MenuControl m2 = new MenuControl();
        m2.setText("&Help");
        ItemControl i21 = new ItemControl();
        i21.setText("&Contents");
        ItemControl i22 = new ItemControl();
        i22.setText("&About");
        m2.add(i21);
        m2.add(new SeparatorControl());
        m2.add(i22);
        mb.add(m2);
        
        MenuControl m3 = new MenuControl();
        m3.setText("Disabled");
        m3.setDisabled();
        mb.add(m3);

        MenuControl m4 = new MenuControl();
        m4.setText("Hidden");
        m4.setHidden();
        mb.add(m4);
        
        w.open();

        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        CWin.select(m1.getUseID());
        waitForEventQueueToCatchup();
        getRobot().waitForIdle();

        getRobot().key('F',KeyEvent.ALT_MASK);
        assertTrue(w.accept());
        assertEquals(Event.SELECTED,CWin.event());
        assertEquals(m1.getUseID(),CWin.field());
        w.consumeAccept();
        

        waitForEventQueueToCatchup();
        getRobot().waitForIdle();

        getRobot().key('D');

        waitForEventQueueToCatchup();
        getRobot().waitForIdle();
        
        getRobot().key('I');

        w.setTimer(50);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        waitForEventQueueToCatchup();
        getRobot().waitForIdle();
        getRobot().key('S');
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(i12.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().mousePress(cc(w).getContentPane());
        getRobot().mouseRelease();
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        
        sleep(500);
        
        i13.setProperty(Prop.DISABLE,0);
        i14.setProperty(Prop.HIDE,0);
        CWin.display();
        waitForEventQueueToCatchup();
        
        sleep(100);
        getRobot().key('F',KeyEvent.ALT_MASK);
        sleep(100);
        getRobot().key('D');
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(i13.getUseID(),CWin.field());
        w.consumeAccept();
        
        sleep(100);
        getRobot().key('F',KeyEvent.ALT_MASK);
        sleep(100);
        getRobot().key('I');
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(i14.getUseID(),CWin.field());
        w.consumeAccept();

        i13.setProperty(Prop.DISABLE,1);
        i14.setProperty(Prop.HIDE,1);
        CWin.display();
        waitForEventQueueToCatchup();

        sleep(100);
        getRobot().key('F',KeyEvent.ALT_MASK);
        sleep(100);
        getRobot().key('D');
        sleep(100);
        getRobot().key('I');

        w.setTimer(50);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        getRobot().mousePress(cc(w).getContentPane());
        getRobot().mouseRelease();
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        
        sleep(500);

        w.close();
    }
}
