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
package org.jclarion.clarion.runtime.format;

import junit.framework.TestCase;

public class FormatResolverTest extends TestCase {

    public void testForward() {
        
        
        FormatResolver fr = new FormatResolver("1234","wxyz",false);
        assertEquals('1',fr.input(false));
        assertEquals('1',fr.input(false));
        assertEquals('w',fr.pattern(false));
        assertEquals('w',fr.pattern(false));
        assertEquals('w',fr.pattern(false));
        assertFalse(fr.isInputFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals("",fr.toString());

        assertEquals('1',fr.input(true));
        assertFalse(fr.isInputFinished());
        assertEquals('2',fr.input(true));
        assertFalse(fr.isInputFinished());

        assertFalse(fr.isPatternFinished());
        assertEquals('w',fr.pattern(true));
        assertFalse(fr.isPatternFinished());

        assertEquals('3',fr.input(true));
        assertFalse(fr.isInputFinished());

        assertFalse(fr.isPatternFinished());
        assertEquals('x',fr.pattern(true));
        assertFalse(fr.isPatternFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals('y',fr.pattern(true));
        assertFalse(fr.isPatternFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals('z',fr.pattern(true));
        assertTrue(fr.isPatternFinished());
    
        assertFalse(fr.isInputFinished());
        assertEquals('4',fr.input(true));
        assertTrue(fr.isInputFinished());
        
        assertEquals("",fr.toString());
        fr.append('T');
        assertEquals("T",fr.toString());
        fr.append('W');
        assertEquals("TW",fr.toString());
        fr.append('E');
        assertEquals("TWE",fr.toString());
        
    }

    
    public void testRollback() {
        
        
        FormatResolver fr = new FormatResolver("1234","wxyz",false);
        assertEquals('1',fr.input(false));
        assertEquals('1',fr.input(false));
        assertEquals('w',fr.pattern(false));
        assertEquals('w',fr.pattern(false));
        assertEquals('w',fr.pattern(false));
        assertFalse(fr.isInputFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals("",fr.toString());

        assertEquals('1',fr.input(true));
        assertEquals('2',fr.input(true));
        assertEquals('w',fr.pattern(true));

        fr.append('T');
        fr.append('H');
        fr.append('I');
        

        Object o =fr.savepoint();
        
        assertEquals('3',fr.input(true));
        assertEquals('4',fr.input(true));
        
        assertEquals('x',fr.pattern(true));
        assertEquals('y',fr.pattern(true));
        assertEquals('z',fr.pattern(true));
        
        fr.append('S');
        
        assertEquals("THIS",fr.toString());

        fr.rollback(o);
        assertEquals('3',fr.input(true));
        assertEquals('x',fr.pattern(true));
        assertEquals("THI",fr.toString());
        
    }
    
    
    public void testReverse() {
        
        
        FormatResolver fr = new FormatResolver("4321","zyxw",true);
        assertEquals('1',fr.input(false));
        assertEquals('1',fr.input(false));
        assertEquals('w',fr.pattern(false));
        assertEquals('w',fr.pattern(false));
        assertEquals('w',fr.pattern(false));
        assertFalse(fr.isInputFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals("",fr.toString());

        assertEquals('1',fr.input(true));
        assertFalse(fr.isInputFinished());
        assertEquals('2',fr.input(true));
        assertFalse(fr.isInputFinished());

        assertFalse(fr.isPatternFinished());
        assertEquals('w',fr.pattern(true));
        assertFalse(fr.isPatternFinished());

        assertEquals('3',fr.input(true));
        assertFalse(fr.isInputFinished());

        assertFalse(fr.isPatternFinished());
        assertEquals('x',fr.pattern(true));
        assertFalse(fr.isPatternFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals('y',fr.pattern(true));
        assertFalse(fr.isPatternFinished());
        assertFalse(fr.isPatternFinished());
        assertEquals('z',fr.pattern(true));
        assertTrue(fr.isPatternFinished());
    
        assertFalse(fr.isInputFinished());
        assertEquals('4',fr.input(true));
        assertTrue(fr.isInputFinished());
        
        assertEquals("",fr.toString());
        fr.append('T');
        assertEquals("T",fr.toString());
        fr.append('W');
        assertEquals("WT",fr.toString());
        fr.append('E');
        assertEquals("EWT",fr.toString());
        
    }
    
}
