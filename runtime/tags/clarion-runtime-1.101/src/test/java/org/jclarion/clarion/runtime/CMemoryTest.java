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
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

import junit.framework.TestCase;

public class CMemoryTest extends TestCase {

    public static class Q1 extends ClarionQueue
    {
        public ClarionAny left = new ClarionAny();
        public ClarionAny right = new ClarionAny();
        public ClarionAny buffer = new ClarionAny();
        
        public Q1()
        {
            addVariable("left",left);
            addVariable("right",left);
            addVariable("buffer",left);
        }
    }

    public static class Q2 extends ClarionQueue
    {
        public ClarionAny left = new ClarionAny();
        public ClarionAny right = new ClarionAny();
        
        public Q2()
        {
            addVariable("left",left);
            addVariable("right",left);
        }
    }
    
    public void testAnyMapping()
    {
        Q1 q1 = new Q1();
        Q2 q2 = (Q2)CMemory.castTo(q1,Q2.class);
        q2.clear();
    }
    
    public void testInstanceAddressing()
    {
        ClarionNumber cn = new ClarionNumber();
        cn.setValue(5);
        cn.initThread();
        
        int i = CMemory.address(cn);
        assertTrue(i!=0);
        assertEquals(i,CMemory.address(cn));
        assertSame(cn,CMemory.resolveAddress(i));
        
        int j = CMemory.instance(cn,null);
        assertFalse(i==j);
        assertEquals(j,CMemory.instance(cn,null));
        assertEquals(j,CMemory.instance(cn,0));
        assertEquals(j,CMemory.instance(cn,CRun.getThreadID()));
        
        final Object[] sync = new Object[1];
        
        Thread nf = new Thread() {
            public void run()
            {
                synchronized(sync) {
                    while (sync[0]==null) {
                        try {
                            sync.wait();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        };
        nf.start();

        try {
            int j2 = CMemory.instance(cn,(int)nf.getId());
            assertFalse(j==j2);
            
            int v1=5;
            int v2=5;

            for (int test=0;test<3;test++) {
                
                TestUtil.triggerGC();
                
                ClarionNumber n1 = (ClarionNumber)CMemory.resolveAddress(j);
                ClarionNumber n2 = (ClarionNumber)CMemory.resolveAddress(j2);
        
                assertNotSame(cn,n1);
                assertNotSame(cn,n2);
                assertNotSame(n1,n2);
            
                assertEquals(v1,cn.intValue());
                assertEquals(v1,n1.intValue());
                assertEquals(v2,n2.intValue());

                v2+=1;
                n2.setValue(v2);

                assertEquals(v1,cn.intValue());
                assertEquals(v1,n1.intValue());
                assertEquals(v2,n2.intValue());

                v1-=1;
                n1.setValue(v1);

                assertEquals(v1,cn.intValue());
                assertEquals(v1,n1.intValue());
                assertEquals(v2,n2.intValue());

                v1-=1;
                cn.setValue(v1);

                assertEquals(v1,cn.intValue());
                assertEquals(v1,n1.intValue());
                assertEquals(v2,n2.intValue());
                
            }            
            
        } finally {
            synchronized(sync) {
                sync[0]=new Object();
                sync.notifyAll();
            }
            try {
                nf.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
    }
    
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
