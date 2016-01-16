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

import javax.swing.JProgressBar;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.runtime.CWin;

public class ProgressTest extends SwingTC
{

    public ProgressTest(String name) {
        super(name);
    }

    public void testPreferredSizing()
    {
        final ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,100);
        ProgressControl pc =  new ProgressControl();
        pc.setAt(10,10,150,20);
        pc.setRange(0,80);
        ClarionNumber cn = new ClarionNumber();
        pc.use(cn);
        w.add(pc);
        w.open();
        
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();

        w.setTimer(10);
        assertTrue(w.accept());
        assertEquals(Event.TIMER,CWin.event());
        w.consumeAccept();
        w.setTimer(0);
        
        JProgressBar jpb = (JProgressBar)cc(pc).getComponent(); 
        
        while (cn.intValue()<80) {
           
            int pos = cn.intValue();
            
            for (int s2=0;s2<10;s2++) {
                cn.increment(1);
                assertEquals(pos,jpb.getValue());
            }
            
            w.setTimer(10);
            assertTrue(w.accept());
            assertEquals(Event.TIMER,CWin.event());
            w.consumeAccept();
            w.setTimer(0);
            
            pos = cn.intValue();
            assertEquals(pos,jpb.getValue());
        }
        
        for (int scan=1;scan<100;scan++) {
            
        }
        
        w.close();
    }
    
}
