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
package org.jclarion.clarion.runtime;

import org.jclarion.TestUtil;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

import junit.framework.TestCase;

public class CMemoryTest extends TestCase {

    public void testSimple()
    {
        Object o = new Object();
        
        int i = CMemory.address(o);
        assertTrue(i!=0);
        assertEquals(i,CMemory.address(o));
        assertEquals(i,CMemory.address(o));
        assertSame(o,CMemory.resolveAddress(i));
        
        TestUtil.triggerGC();

        assertEquals(i,CMemory.address(o));
        assertEquals(i,CMemory.address(o));
        assertSame(o,CMemory.resolveAddress(i));
        
        o=null;
        
        TestUtil.triggerGC();
        
        assertNull(CMemory.resolveAddress(i));
    }

    public void testMany()
    {
        Object o[] = new Object[10];
        int i[] = new int[10];
        
        for (int scan=0;scan<10;scan++) {
            o[scan]=new Object();
            i[scan]=CMemory.address(o[scan]);
        }

        for (int scan=0;scan<10;scan++) {
            assertTrue(i[scan]!=0);
            assertEquals(i[scan],CMemory.address(o[scan]));
            assertEquals(i[scan],CMemory.address(o[scan]));
            assertSame(o[scan],CMemory.resolveAddress(i[scan]));
        }
        
        TestUtil.triggerGC();

        for (int scan=0;scan<10;scan++) {
            assertTrue(i[scan]!=0);
            assertEquals(i[scan],CMemory.address(o[scan]));
            assertEquals(i[scan],CMemory.address(o[scan]));
            assertSame(o[scan],CMemory.resolveAddress(i[scan]));
        }
        
        o=null;
        
        TestUtil.triggerGC();
        
        for (int scan=0;scan<10;scan++) {
            assertNull(CMemory.resolveAddress(i[scan]));
        }
    }

    public void testSize() {
        ClarionString cs = new ClarionString(20);
        ClarionNumber n = (new ClarionNumber()).setEncoding(ClarionNumber.LONG);
        ClarionGroup cg = new ClarionGroup();
        cg.addVariable("cs",cs);
        cg.addVariable("n",n);
        assertEquals(20,CMemory.size(cs));
        assertEquals(4,CMemory.size(n));
        assertEquals(24,CMemory.size(cg));
    }
    
    
    /*
    public void testClear() {
        fail("Not yet implemented");
    }


    public void testAddressObject() {
        fail("Not yet implemented");
    }

    public void testAddressObjectArray() {
        fail("Not yet implemented");
    }

    public void testGetAddressPrototype() {
        fail("Not yet implemented");
    }

    public void testGetPrototype() {
        fail("Not yet implemented");
    }

    public void testResolveAddress() {
        fail("Not yet implemented");
    }

    public void testTied() {
        fail("Not yet implemented");
    }

    public void testTie() {
        fail("Not yet implemented");
    }

    public void testUntie() {
        fail("Not yet implemented");
    }

    public void testPeek() {
        fail("Not yet implemented");
    }

    public void testPoke() {
        fail("Not yet implemented");
    }
     * 
     */

}
