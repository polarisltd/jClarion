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
package org.jclarion.clarion.swing.notify;

import junit.framework.TestCase;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.runtime.CWin;

public class EventNotifierTest extends TestCase {

    
    public void testSimple()
    {
        ClarionApplication app = new ClarionApplication();
        app.setAt(10,10,300,200);
        app.setText("Some window");

        app.open();
        
        assertTrue(app.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        app.consumeAccept();
        
        EventNotifier.getInstance().error("Test");
        EventNotifier.getInstance().warning("This is a\nBig Warning");
        EventNotifier.getInstance().info("All is well");
        
        try {
            Thread.sleep(18000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        EventNotifier.getInstance().shutdown();
        
        app.close();
        
    }
}
