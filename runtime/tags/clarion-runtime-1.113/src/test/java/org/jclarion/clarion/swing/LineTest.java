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
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.runtime.CWin;

public class LineTest extends SwingTC
{

    public LineTest(String name) {
        super(name);
    }
    
    public void testSlopePositive()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(20,20,60,60);
        
        cw.add(lc);

        displayForABit(cw);
    }


    public void testThick()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(20,20,60,60);
        lc.setLineWidth(2);
        
        cw.add(lc);

        displayForABit(cw);
    }

    public void testFlat()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(20,20,60,0);
        lc.setLineWidth(2);
        
        cw.add(lc);

        displayForABit(cw);
    }

    public void testNegativeY()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(20,80,60,-60);
        lc.setLineWidth(2);
        
        cw.add(lc);

        displayForABit(cw);
    }

    public void testNegativeX()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(80,20,-60,60);
        lc.setLineWidth(2);
        
        cw.add(lc);

        displayForABit(cw);
    }

    public void testNegativeXAndY()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(80,80,-60,-60);
        lc.setLineWidth(2);
        
        cw.add(lc);

        displayForABit(cw);
    }

    public void testUpAndDown()
    {
        ClarionWindow cw = new ClarionWindow();
        cw.setAt(10,10,100,100);
        cw.setText("Test");
        
        LineControl lc = new LineControl();
        lc.setAt(20,20,0,60);
        lc.setColor(0x0000ff,null,null);
        lc.setLineWidth(2);
        
        cw.add(lc);

        displayForABit(cw);
    }
    
    private void displayForABit(ClarionWindow cw) {
        cw.open();
        
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();

        cw.setTimer(100);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        cw.setTimer(0);
        
        cw.post(Event.CLOSEWINDOW);
        
        assertTrue(cw.accept());
        assertEquals(Event.CLOSEWINDOW,CWin.event());
        cw.consumeAccept();
        
        cw.close();
    }
    
}
