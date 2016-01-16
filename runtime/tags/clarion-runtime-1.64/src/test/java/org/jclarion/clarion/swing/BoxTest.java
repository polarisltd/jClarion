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

import java.util.Random;

import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.runtime.CWin;

public class BoxTest extends SwingTC
{

    public BoxTest(String name) {
        super(name);
    }
    
    public void testSimpleBox()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        cw.add((new BoxControl()).setAt(10,10,30,30).setColor(0xff0000,null,null));
     
        cw.open();
        
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();

        Random r=new Random();
        for (int scan=0;scan<20;scan++) {
            CWin.box(
                    r.nextInt(80),r.nextInt(80),
                    r.nextInt(20),r.nextInt(20));
        }
        
        cw.setTimer(300);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);
        
        cw.close();
        
    }    
}
