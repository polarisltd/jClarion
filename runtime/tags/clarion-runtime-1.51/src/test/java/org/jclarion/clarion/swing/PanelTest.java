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

import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.constants.*;

public class PanelTest extends SwingTC
{

    public PanelTest(String name) {
        super(name);
    }

    public void testSimple()
    {
        ClarionWindow w = new ClarionWindow();
        w.setText("Hello World");
        w.setAt(null,null,200,150);
        w.setResize();
        
        PanelControl cp = new PanelControl();
        cp.setAt(20,4,180,130);
        w.add(cp);
        
        StringControl sc = new StringControl();
        sc.setText("This is a string");
        sc.setAt(5,100,null,null);
        w.add(sc);
        
        w.open();
        
        assertTrue(w.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        w.consumeAccept();
        
        w.close();
    }
}
