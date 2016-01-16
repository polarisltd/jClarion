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
        m1.add(i11);
        m1.add(i12);
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
        w.open();

        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        CWin.select(m1.getUseID());

        sleep(100);
        getRobot().key('F',KeyEvent.ALT_MASK);

        sleep(100);
        getRobot().key('S');
        
        assertTrue(w.accept());
        assertEquals(Event.ACCEPTED,CWin.event());
        assertEquals(i12.getUseID(),CWin.field());
        w.consumeAccept();
        
        getRobot().mousePress(w.getContentPane());
        getRobot().mouseRelease();
        
        getRobot().waitForIdle();
        waitForEventQueueToCatchup();
        
        sleep(500);
        
        
        w.close();
    }
}
