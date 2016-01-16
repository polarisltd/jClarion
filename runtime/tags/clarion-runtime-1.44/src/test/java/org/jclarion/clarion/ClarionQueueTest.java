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
package org.jclarion.clarion;

import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.constants.*;

import junit.framework.TestCase;

public class ClarionQueueTest extends TestCase {
    
    public static class TestClarionQueue extends ClarionQueue
    {
        public ClarionString s1 = new ClarionString(10);
        public ClarionNumber n1 = new ClarionNumber();
        public ClarionDecimal d1 = new ClarionDecimal(10,2);
        public ClarionDecimal da[] = new ClarionDecimal(11,3).dim(5);
        public Object o;
        public ClarionDecimal dr;
        
        public TestClarionQueue() {
            addVariable("s1",s1);
            addVariable("n1",n1);
            addVariable("d1",d1);
            addVariable("da",da);
            addReference("o",o);
            addReference("dr",dr);
        }
    }

    public void testActiveOrderingSearch()
    {
        TestClarionQueue q = new TestClarionQueue();
        
        assertEquals(0,q.getPointer());
        
        q.s1.setValue("A");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        q.s1.setValue("C");
        q.add("+s1");
        q.s1.setValue("C");
        q.add("+s1");
        q.s1.setValue("E");
        q.add("+s1");
        q.s1.setValue("D");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        
        q.clear();
        q.get(Clarion.newString("+S1"));
        assertEquals(1,q.getPointer());
        
        q.s1.setValue("B");
        q.get(Clarion.newString("+S1"));
        assertEquals(2,q.getPointer());
        
        q.get(2);
        assertEquals("B",q.s1.toString().trim());
        q.get(3);
        assertEquals("B",q.s1.toString().trim());
        q.delete();
        q.get(3);
        assertEquals("B",q.s1.toString().trim());
        q.get(4);
        assertEquals("B",q.s1.toString().trim());
        q.get(5);
        assertEquals("C",q.s1.toString().trim());
        
        q.s1.setValue("D");
        q.get(Clarion.newString("+S1"));
        assertEquals(7,q.getPointer());
        
        q.get(8);
        assertEquals("E",q.s1.toString().trim());

        q.get(7);
        assertEquals("D",q.s1.toString().trim());
    }

    public void testActiveOrderingSearch2()
    {
        TestClarionQueue q = new TestClarionQueue();
        
        assertEquals(0,q.getPosition());
        
        q.s1.setValue("A");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        q.s1.setValue("C");
        q.add("+s1");
        q.s1.setValue("C");
        q.add("+s1");
        q.s1.setValue("E");
        q.add("+s1");
        q.s1.setValue("D");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        q.s1.setValue("B");
        q.add("+s1");
        
        q.clear();
        assertEquals(1,q.getPosition());
        
        q.s1.setValue("B");
        assertEquals(2,q.getPosition());
        
        q.get(2);
        assertEquals("B",q.s1.toString().trim());
        q.get(3);
        assertEquals("B",q.s1.toString().trim());
        q.delete();
        q.get(3);
        assertEquals("B",q.s1.toString().trim());
        q.get(4);
        assertEquals("B",q.s1.toString().trim());
        q.get(5);
        assertEquals("C",q.s1.toString().trim());
        
        q.s1.setValue("D");
        assertEquals(7,q.getPosition());
        
        q.get(8);
        assertEquals("E",q.s1.toString().trim());

        q.get(7);
        assertEquals("D",q.s1.toString().trim());
    }
    
    public void testAddAndResort()
    {
        TestClarionQueue q = new TestClarionQueue();
        
        q.sort(new ClarionString("+n1"));
        q.n1.setValue(4);
        q.add();

        q.sort(new ClarionString("+n1"));
        q.n1.setValue(2);
        q.add();

        q.sort(new ClarionString("+n1"));
        q.n1.setValue(1);
        q.add();
        
        q.sort(new ClarionString("+n1"));
        q.n1.setValue(3);
        q.add();
        
        q.sort(new ClarionString("+n1"));
        for (int scan=1;scan<4;scan++) {
            q.get(scan);
            assertEquals(scan,q.n1.intValue());
        }
    }
    
    public void testGetThenAddClearsError() {
        
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        
        q.get(q.ORDER().ascend(q.s1));
        assertEquals(30,CError.errorCode());

        q.add(q.ORDER().ascend(q.s1));
        assertEquals(0,CError.errorCode());
        
        assertEquals(1,q.records());
    }
    
    public void testAdd() {
        
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add();

        assertEquals(3,q.records());

        for (int scan=0;scan<2;scan++) {
            q.get(1);
            assertEquals("Hello     ", q.s1.toString());
            assertEquals(10, q.n1.intValue());
            assertEquals("12.30", q.d1.toString());
            assertEquals("-1.000", q.da[4].toString());
            assertEquals("13.2", q.dr.toString());
            assertSame(o1, q.o);

            q.get(2);
            assertEquals("World     ", q.s1.toString());
            assertEquals(20, q.n1.intValue());
            assertEquals("20.50", q.d1.toString());
            assertEquals("10.000", q.da[4].toString());
            assertEquals("100", q.dr.toString());
            assertSame(o2, q.o);

            q.get(3);
            assertEquals("Yeah      ", q.s1.toString());
            assertEquals(21, q.n1.intValue());
            assertEquals("20.60", q.d1.toString());
            assertEquals("-11.000", q.da[4].toString());
            assertNull(q.dr);
            assertNull(q.o);
        }
    }

    public void testAddOrder() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        Object o1 = q.o;
     
        q.add(q.ORDER().ascend(q.n1));

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(5);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        Object o2 = q.o;
        
        q.add(q.ORDER().ascend(q.n1));

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add(q.ORDER().ascend(q.n1));

        assertEquals(3,q.records());

        for (int scan=0;scan<2;scan++) {
            q.get(1);
            assertEquals(0,CError.errorCode());
            assertEquals("World     ", q.s1.toString());
            assertEquals(5, q.n1.intValue());
            assertEquals("20.50", q.d1.toString());
            assertEquals("10.000", q.da[4].toString());
            assertEquals("100", q.dr.toString());
            assertSame(o2, q.o);
            
            q.get(2);
            assertEquals("Hello     ", q.s1.toString());
            assertEquals(10, q.n1.intValue());
            assertEquals("12.30", q.d1.toString());
            assertEquals("-1.000", q.da[4].toString());
            assertEquals("13.2", q.dr.toString());
            assertSame(o1, q.o);

            q.get(3);
            assertEquals("Yeah      ", q.s1.toString());
            assertEquals(21, q.n1.intValue());
            assertEquals("20.60", q.d1.toString());
            assertEquals("-11.000", q.da[4].toString());
            assertNull(q.dr);
            assertNull(q.o);
        }
    }
    
    public void testAddOrderMany() {
        TestClarionQueue q = new TestClarionQueue();
        
        int order[] = {8,6,3,7,10,2,12,15,10,6};
        int sorted[] = {6,3,2,10,4,1,5,9,7,8 };
        
        for (int scan=0;scan<10;scan++) {
            q.n1.setValue(order[scan]);
            q.d1.setValue(scan+1);
            q.add(q.ORDER().ascend(q.n1));
        }

        for (int scan=0;scan<10;scan++) {
            q.get(scan+1);
            assertEquals(""+scan,sorted[scan],q.d1.intValue());
            assertEquals(""+scan,order[sorted[scan]-1],q.n1.intValue());
        }
    }

    public void testMixedSortAtEnd() {
        TestClarionQueue q = new TestClarionQueue();
        
        int order[] = {8,6,3,7,10,2,12,15,10,6};
        int sorted[] = {6,3,2,10,4,1,5,9,7,8 };
        
        for (int scan=0;scan<10;scan++) {
            q.n1.setValue(order[scan]);
            q.d1.setValue(scan+1);
            if ((scan&1)==0) {
                q.add();
            } else {
                q.add(q.ORDER().ascend(q.n1));
            }
        }

        for (int scan=0;scan<10;scan++) {
            q.get(scan+1);
            assertEquals(""+scan,sorted[scan],q.d1.intValue());
            assertEquals(""+scan,order[sorted[scan]-1],q.n1.intValue());
        }
        
        assertEquals(1,q.getSortCount());
    }

    public void testMixedSortAtEnd2() {
        TestClarionQueue q = new TestClarionQueue();
        
        int order[] = {8,6,3,7,10,2,12,15,10,6};
        int sorted[] = {6,3,2,10,4,1,5,9,7,8 };
        
        for (int scan=0;scan<10;scan++) {
            q.n1.setValue(order[scan]);
            q.d1.setValue(scan+1);
            if ((scan&1)==0) {
                q.add(q.ORDER().descend(q.n1));
            } else {
                q.add(q.ORDER().ascend(q.n1));
            }
        }

        for (int scan=0;scan<10;scan++) {
            q.get(scan+1);
            assertEquals(""+scan,sorted[scan],q.d1.intValue());
            assertEquals(""+scan,order[sorted[scan]-1],q.n1.intValue());
        }
        
        assertEquals(2,q.getSortCount());
    }

    
    public void testAddSortDescend() {
        TestClarionQueue q = new TestClarionQueue();
        
        int order[] = {8,6,3,7,10,2,12,15,10,6};
        //int sorted[] = {6,3,2,10,4,1,5,9,7,8 };
        int sorted[] = {8,7,5,9,1,4,2,10,3,6};
        
        for (int scan=0;scan<10;scan++) {
            q.n1.setValue(order[scan]);
            q.d1.setValue(scan+1);
            q.add(q.ORDER().descend(q.n1));
        }

        for (int scan=0;scan<10;scan++) {
            q.get(scan+1);
            assertEquals(""+scan,sorted[scan],q.d1.intValue());
            assertEquals(""+scan,order[sorted[scan]-1],q.n1.intValue());
        }
        
        assertEquals(1,q.getSortCount());
    }
    
    public void testAddNormalSortAtEnd() {
        TestClarionQueue q = new TestClarionQueue();
        
        int order[] = {8,6,3,7,10,2,12,15,10,6};
        int sorted[] = {6,3,2,10,4,1,5,9,7,8 };
        
        for (int scan=0;scan<10;scan++) {
            q.n1.setValue(order[scan]);
            q.d1.setValue(scan+1);
            if (scan<9) {
                q.add();
            } else {
                q.add(q.ORDER().ascend(q.n1));
            }
        }

        for (int scan=0;scan<10;scan++) {
            q.get(scan+1);
            assertEquals(""+scan,sorted[scan],q.d1.intValue());
            assertEquals(""+scan,order[sorted[scan]-1],q.n1.intValue());
        }
        
        assertEquals(1,q.getSortCount());
    }

    public void testSortMultipleKeys() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("A1");
        q.n1.setValue("9");
        q.add(q.ORDER().ascend(q.s1).descend(q.n1));

        q.s1.setValue("A2");
        q.n1.setValue("10");
        q.add(q.ORDER().ascend(q.s1).descend(q.n1));

        q.s1.setValue("A2");
        q.n1.setValue("11");
        q.add(q.ORDER().ascend(q.s1).descend(q.n1));
        
        q.get(1);
        assertEquals("A1        ",q.s1.toString());
        q.get(2);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(11,q.n1.intValue());
        q.get(3);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
    }

    
    public void testSortByString1() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("A1");
        q.n1.setValue("9");
        q.add("s1,-n1");

        q.s1.setValue("A2");
        q.n1.setValue("10");
        q.add("s1,-n1");

        q.s1.setValue("A2");
        q.n1.setValue("11");
        q.add("s1,-n1");
        
        q.get(1);
        assertEquals("A1        ",q.s1.toString());
        q.get(2);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(11,q.n1.intValue());
        q.get(3);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
    }
    
    public void testSortByString2() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("A1");
        q.n1.setValue("9");
        q.add("+q.s1,-q.n1");

        q.s1.setValue("A2");
        q.n1.setValue("10");
        q.add("+q.s1,-q.n1");

        q.s1.setValue("A2");
        q.n1.setValue("11");
        q.add("+q.s1,-q.n1");
        
        q.get(1);
        assertEquals("A1        ",q.s1.toString());
        q.get(2);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(11,q.n1.intValue());
        q.get(3);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
    }
    
    public void testSortByString3() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("A1");
        q.n1.setValue("9");
        q.add(new ClarionString("+q:s1,-q:n1"));

        q.s1.setValue("A2");
        q.n1.setValue("10");
        q.add(new ClarionString("+q:s1,-q:n1"));

        q.s1.setValue("A2");
        q.n1.setValue("11");
        q.add(new ClarionString("+q:s1,-q:n1"));
        
        q.get(1);
        assertEquals("A1        ",q.s1.toString());
        q.get(2);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(11,q.n1.intValue());
        q.get(3);
        assertEquals("A2        ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
    }

    public void testPutAfterAddAndGet() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add();

        assertEquals(3,q.records());

        q.put();
        
        q.d1.setValue("22.3");
        q.put();
        
        q.get(2);
        q.n1.setValue(5);
        q.put();

        q.get(1);
        assertEquals("Hello     ", q.s1.toString());
        assertEquals(10, q.n1.intValue());
        assertEquals("12.30", q.d1.toString());
        assertEquals("-1.000", q.da[4].toString());
        assertEquals("13.2", q.dr.toString());
        assertSame(o1, q.o);

        q.get(2);
        assertEquals("World     ", q.s1.toString());
        assertEquals(5, q.n1.intValue());
        assertEquals("20.50", q.d1.toString());
        assertEquals("10.000", q.da[4].toString());
        assertEquals("100", q.dr.toString());
        assertSame(o2, q.o);

        q.get(3);
        assertEquals("Yeah      ", q.s1.toString());
        assertEquals(21, q.n1.intValue());
        assertEquals("22.30", q.d1.toString());
        assertEquals("-11.000", q.da[4].toString());
        assertNull(q.dr);
        assertNull(q.o);
        
    }

    public void testPutWithOrderAfterAddAndGet() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        Object o1 = q.o;
     
        q.add("q.s1");

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        Object o2 = q.o;
        
        q.add("q.s1");

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add("q.s1");

        assertEquals(3,q.records());

        q.put();
        
        q.d1.setValue("22.3");
        q.put();
        
        q.get(2);
        q.n1.setValue(5);
        q.put();

        q.get(1);
        assertEquals("Hello     ", q.s1.toString());
        assertEquals(10, q.n1.intValue());
        assertEquals("12.30", q.d1.toString());
        assertEquals("-1.000", q.da[4].toString());
        assertEquals("13.2", q.dr.toString());
        assertSame(o1, q.o);

        q.get(2);
        assertEquals("World     ", q.s1.toString());
        assertEquals(5, q.n1.intValue());
        assertEquals("20.50", q.d1.toString());
        assertEquals("10.000", q.da[4].toString());
        assertEquals("100", q.dr.toString());
        assertSame(o2, q.o);

        q.get(3);
        assertEquals("Yeah      ", q.s1.toString());
        assertEquals(21, q.n1.intValue());
        assertEquals("22.30", q.d1.toString());
        assertEquals("-11.000", q.da[4].toString());
        assertNull(q.dr);
        assertNull(q.o);
    }

    
    public void testPutTriggersDisorder() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add("q.n1");

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add("q.n1");

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add("q.n1");

        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(20,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());
        
        q.get(2);q.n1.setValue(16);q.put();
    
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(16,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(2);q.n1.setValue(4);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(4,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(2);q.n1.setValue(0);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(0,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(2);q.n1.setValue(30);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(3);q.n1.setValue(29);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(29,q.n1.intValue());

        q.get(3);q.n1.setValue(30);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(30,q.n1.intValue());

        q.get(3);q.n1.setValue(31);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(31,q.n1.intValue());

        q.get(2);q.n1.setValue(31);q.put();
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(31,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(31,q.n1.intValue());
        
    }

    public void testPutOrder() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add();

        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(20,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());
        
        q.get(2);q.n1.setValue(16);q.put(q.ORDER().ascend(q.n1));
    
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(16,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(2);q.n1.setValue(4);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("World     ",q.s1.toString());
        assertEquals(4,q.n1.intValue());
        q.get(2);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(1);q.n1.setValue(0);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("World     ",q.s1.toString());
        assertEquals(0,q.n1.intValue());
        q.get(2);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());

        q.get(1);q.n1.setValue(30);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(21,q.n1.intValue());
        q.get(3);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());

        q.get(2);q.n1.setValue(29);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(29,q.n1.intValue());
        q.get(3);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());

        q.get(2);q.n1.setValue(30);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(30,q.n1.intValue());

        q.get(3);q.n1.setValue(31);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(30,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(31,q.n1.intValue());

        q.get(2);q.n1.setValue(31);q.put(q.ORDER().ascend(q.n1));
        
        q.get(1);assertEquals("Hello     ",q.s1.toString());
        assertEquals(10,q.n1.intValue());
        q.get(2);assertEquals("World     ",q.s1.toString());
        assertEquals(31,q.n1.intValue());
        q.get(3);assertEquals("Yeah      ",q.s1.toString());
        assertEquals(31,q.n1.intValue());
    }

    public void testDelete() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add();
        

        assertEquals(3,q.records());
        q.delete();
        assertEquals(2,q.records());
        assertEquals(0,CError.errorCode());
        q.delete();
        assertEquals(30,CError.errorCode());
        
        q.get(1);
        assertEquals("Hello     ",q.s1.toString());
        q.delete();
        assertEquals(0,CError.errorCode());
        assertEquals(1,q.records());

        q.get(1);
        assertEquals("World     ",q.s1.toString());
        q.delete();
        assertEquals(0,CError.errorCode());
        assertEquals(0,q.records());
    }

    public void testDeleteSorted() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add("s1");

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add("s1");

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add("s1");
        

        assertEquals(3,q.records());
        q.delete();
        assertEquals(2,q.records());
        assertEquals(0,CError.errorCode());
        q.delete();
        assertEquals(30,CError.errorCode());
        
        q.get(1);
        assertEquals("Hello     ",q.s1.toString());
        q.delete();
        assertEquals(0,CError.errorCode());
        assertEquals(1,q.records());

        q.get(1);
        assertEquals("World     ",q.s1.toString());
        q.delete();
        assertEquals(0,CError.errorCode());
        assertEquals(0,q.records());
    }
    
    
    public void testFree() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add("s1");

        assertEquals(1,q.records());
        
        q.s1.setValue("World");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add("s1");

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.dr=null;
        q.o=null;

        q.add("s1");
        
        q.free();
        
        assertEquals(0,q.records());
    }

    public void testSortOrder() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.da[1].setValue(1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("Hello");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.da[1].setValue(2);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.da[1].setValue(3);
        q.dr=null;
        q.o=null;

        q.add();

        q.get(1);assertEquals(1,q.da[1].intValue());
        q.get(2);assertEquals(2,q.da[1].intValue());
        q.get(3);assertEquals(3,q.da[1].intValue());
        
        q.sort(new ClarionString("n1"));
        
        q.get(1);assertEquals(1,q.da[1].intValue());
        q.get(2);assertEquals(2,q.da[1].intValue());
        q.get(3);assertEquals(3,q.da[1].intValue());

        q.sort(new ClarionString("-s1"));
        
        q.get(1);assertEquals(3,q.da[1].intValue());
        q.get(2);assertEquals(1,q.da[1].intValue());
        q.get(3);assertEquals(2,q.da[1].intValue());

        q.dr=new ClarionDecimal(10);
        q.sort(new ClarionString("dr"));
        
        q.get(1);assertEquals(3,q.da[1].intValue());
        q.get(2);assertEquals(1,q.da[1].intValue());
        q.get(3);assertEquals(2,q.da[1].intValue());
        
        q.dr=new ClarionDecimal(10);
        q.sort(new ClarionString("s1,n1"));
        
        q.get(1);assertEquals(1,q.da[1].intValue());
        q.get(2);assertEquals(2,q.da[1].intValue());
        q.get(3);assertEquals(3,q.da[1].intValue());

        q.dr=new ClarionDecimal(10);
        q.sort(new ClarionString("-s1"));
        
        q.get(1);assertEquals(3,q.da[1].intValue());
        q.get(2);assertEquals(1,q.da[1].intValue());
        q.get(3);assertEquals(2,q.da[1].intValue());

        q.dr=new ClarionDecimal(10);
        q.sort(new ClarionString("-s1,n1"));
        
        q.get(1);assertEquals(3,q.da[1].intValue());
        q.get(2);assertEquals(1,q.da[1].intValue());
        q.get(3);assertEquals(2,q.da[1].intValue());

        q.dr=new ClarionDecimal(10);
        q.sort(new ClarionString("-s1,-n1"));
        
        q.get(1);assertEquals(3,q.da[1].intValue());
        q.get(2);assertEquals(2,q.da[1].intValue());
        q.get(3);assertEquals(1,q.da[1].intValue());

        q.dr=new ClarionDecimal(10);
        q.sort(q.ORDER().descend(q.s1));
        
        q.get(1);assertEquals(3,q.da[1].intValue());
        q.get(2);assertEquals(1,q.da[1].intValue());
        q.get(3);assertEquals(2,q.da[1].intValue());
    }

    public void testGetOrder()
    {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.da[1].setValue(1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("Hello");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.da[1].setValue(2);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.da[1].setValue(3);
        q.dr=null;
        q.o=null;

        q.add();
        
        q.sort(q.ORDER().ascend(q.s1));

        q.clear();
        q.s1.setValue("Hello");
        q.get(q.ORDER().ascend(q.s1));
        assertEquals(1,q.da[1].intValue());
        assertEquals(0,CError.errorCode());

        q.clear();
        q.s1.setValue("Yeah");
        q.get(q.ORDER().ascend(q.s1));
        assertEquals(3,q.da[1].intValue());
        assertEquals(0,CError.errorCode());

        q.clear();
        q.d1.setValue("20.5");
        q.get(q.ORDER().ascend(q.d1));
        assertEquals(2,q.da[1].intValue());
        assertEquals(0,CError.errorCode());

        q.clear();
        q.d1.setValue("20.6");
        q.get(q.ORDER().ascend(q.d1));
        assertEquals(3,q.da[1].intValue());
        assertEquals(0,CError.errorCode());
        
        q.clear();
        q.s1.setValue("AAA");
        q.get(q.ORDER().ascend(q.s1));
        assertEquals(0,q.da[1].intValue());
        assertEquals(Constants.NOENTRYERR,CError.errorCode());
        assertEquals(1,q.getPointer());

        q.clear();
        q.s1.setValue("Hx");
        q.get(q.ORDER().ascend(q.s1));
        assertEquals(0,q.da[1].intValue());
        assertEquals(Constants.NOENTRYERR,CError.errorCode());
        assertEquals(3,q.getPointer());

        q.clear();
        q.s1.setValue("Hx");
        q.get(new ClarionString("s1"));
        assertEquals(0,q.da[1].intValue());
        assertEquals(Constants.NOENTRYERR,CError.errorCode());
        assertEquals(3,q.getPointer());

        q.sort(q.ORDER().ascend(q.s1).ascend(q.n1));
        
        q.clear();
        q.s1.setValue("Hello");
        q.n1.setValue(15);
        q.get(new ClarionString("s1,n1"));
        assertEquals(0,q.da[1].intValue());
        assertEquals(Constants.NOENTRYERR,CError.errorCode());
        assertEquals(2,q.getPointer());

        
        q.sort(q.ORDER().ascend(q.s1));

        q.clear();
        q.s1.setValue("Z");
        q.get(q.ORDER().ascend(q.s1));
        assertEquals(0,q.da[1].intValue());
        assertEquals(Constants.NOENTRYERR,CError.errorCode());
        assertEquals(4,q.getPointer());
        
    }
    
    public void testGetPosition() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.da[1].setValue(1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add();

        assertEquals(1,q.records());
        
        q.s1.setValue("Hello");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.da[1].setValue(2);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add();

        assertEquals(2,q.records());

        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.da[1].setValue(3);
        q.dr=null;
        q.o=null;

        q.add();

        q.clear();
        q.s1.setValue("Hello");
        q.sort(q.ORDER().ascend(q.s1));
        assertEquals(1,q.getPosition());

        q.clear();
        q.s1.setValue("Yeah");
        q.sort(q.ORDER().ascend(q.s1));
        assertEquals(3,q.getPosition());

        q.clear();
        q.d1.setValue("20.5");
        q.sort(q.ORDER().ascend(q.d1));
        assertEquals(2,q.getPosition());

        q.clear();
        q.s1.setValue("Z");
        q.sort(q.ORDER().ascend(q.s1));
        assertEquals(4,q.getPosition());

        q.clear();
        q.s1.setValue("Hello");
        q.n1.setValue(15);
        q.sort(new ClarionString("s1,n1"));
        assertEquals(2,q.getPosition());

    }
    
    public void testGetPointer() {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Hello");
        q.n1.setValue(10);
        q.d1.setValue("12.3");
        q.da[4].setValue(-1);
        q.da[1].setValue(1);
        q.dr=new ClarionDecimal("13.2");
        q.o=new Object();
        //Object o1 = q.o;
     
        q.add();
        assertEquals(1,q.getPointer());

        assertEquals(1,q.records());
        
        q.s1.setValue("Hello");
        q.n1.setValue(20);
        q.d1.setValue("20.5");
        q.da[4].setValue(10);
        q.da[1].setValue(2);
        q.dr=new ClarionDecimal("100");
        q.o=new Object();
        //Object o2 = q.o;
        
        q.add();
        assertEquals(2,q.getPointer());
        
        q.s1.setValue("Yeah");
        q.n1.setValue(21);
        q.d1.setValue("20.6");
        q.da[4].setValue(-11);
        q.da[1].setValue(3);
        q.dr=null;
        q.o=null;

        q.add();
        
        assertEquals(3,q.getPointer());

        q.get(1);
        assertEquals(1,q.getPointer());
        q.get(2);
        assertEquals(2,q.getPointer());
        q.get(3);
        assertEquals(3,q.getPointer());
    }

    public void testGetPointerPostSortedGetIsAccurate()
    {
        TestClarionQueue q = new TestClarionQueue();
        
        q.s1.setValue("Bob Marley");
        q.n1.setValue(6);
        q.add();
        
        q.s1.setValue("Paul Kelly");
        q.n1.setValue(2);
        q.add();
        
        q.s1.setValue("Dave Wyndorf");
        q.n1.setValue(4);
        q.add();

        q.s1.setValue("James Brown");
        q.n1.setValue(20);
        q.add();
        
        q.s1.setValue("Dave Wyndof");
        q.get(new ClarionString("+s1"));
        assertEquals(0,CError.errorCode());
        assertEquals(3,q.getPointer());

        q.s1.setValue("James Brown");
        q.get(new ClarionString("+s1"));
        assertEquals(0,CError.errorCode());
        assertEquals(4,q.getPointer());

        q.sort(new ClarionString("+n1"));

        q.s1.setValue("Dave Wyndof");
        q.get(new ClarionString("+s1"));
        assertEquals(0,CError.errorCode());
        assertEquals(2,q.getPointer());
    }
    
    
    
    private class DepthClarionQueue extends ClarionQueue
    {
        public ClarionString name=new ClarionString(30);
        public ClarionNumber icon=new ClarionNumber();
        public ClarionNumber depth=new ClarionNumber();
        
        public DepthClarionQueue()
        {
            addVariable("name",name);
            addVariable("icon",icon);
            addVariable("depth",depth);
        }
    }
    
    private void add(DepthClarionQueue queue,String name,int depth)
    {
        queue.name.setValue(name);
        queue.icon.setValue((int)(Math.random()*100));
        queue.depth.setValue(depth);
        queue.add();
    }
    
    public void testDepthRoutines()
    {
        DepthClarionQueue q = new DepthClarionQueue();
        
        add(q,"Estimates",1);
            add(q,"Bikes",2);
                add(q,"Honda",3);
                add(q,"Suzuki",3);
                add(q,"Kawasaki",3);
             add(q,"P/E",2);
                add(q,"Stihl",3);
                add(q,"Husky",3);
                add(q,"Honda",3);

        assertQueue(q,1,true,false      ,false);
        assertQueue(q,2,true,true       ,false,true);
        assertQueue(q,3,false,true      ,false,true,true);
        assertQueue(q,4,false,true      ,false,true,true);
        assertQueue(q,5,false,false     ,false,true,false);
        assertQueue(q,6,true,false      ,false,false);
        assertQueue(q,7,false,true      ,false,false,true);
        assertQueue(q,8,false,true      ,false,false,true);
        assertQueue(q,9,false,false     ,false,false,false);
    }

    public void testDepthRoutinesWithTreeQueue()
    {
        DepthClarionQueue tq = new DepthClarionQueue();
        
        add(tq,"Estimates",1);
            add(tq,"Bikes",2);
                add(tq,"Honda",3);
                add(tq,"Suzuki",3);
                add(tq,"Kawasaki",3);
             add(tq,"P/E",2);
                add(tq,"Stihl",3);
                add(tq,"Husky",3);
                add(tq,"Honda",3);

        ClarionQueueReader q = new TreeClarionQueue(tq,3);
        assertEquals(9,q.records());
                
        assertQueue(q,1,true,false      ,false);
        assertQueue(q,2,true,true       ,false,true);
        assertQueue(q,3,false,true      ,false,true,true);
        assertQueue(q,4,false,true      ,false,true,true);
        assertQueue(q,5,false,false     ,false,true,false);
        assertQueue(q,6,true,false      ,false,false);
        assertQueue(q,7,false,true      ,false,false,true);
        assertQueue(q,8,false,true      ,false,false,true);
        assertQueue(q,9,false,false     ,false,false,false);
        
        q.toggle(2,3);
 
        assertEquals(6,q.records());

        assertQueue(q,1,true,false      ,false);
        assertQueue(q,2,true,true       ,false,true);
        assertQueue(q,3,true,false      ,false,false);
        assertQueue(q,4,false,true      ,false,false,true);
        assertQueue(q,5,false,true      ,false,false,true);
        assertQueue(q,6,false,false     ,false,false,false);
        
    }
    
    private void assertQueue(ClarionQueueReader q, int i, 
            boolean hasChildren,boolean hasSibling,boolean... siblingDepths) 
    {
        assertEquals(hasChildren,q.hasChildren(i,3));
        
        boolean[] bits = q.getSiblingTree(i,3);
        if (bits==null) {
            assertEquals(0,siblingDepths.length);
        } else {
            assertEquals(bits.length,siblingDepths.length);
            for (int scan=0;scan<bits.length;scan++) {
                assertEquals("POS:"+scan,siblingDepths[scan],bits[scan]);
            }
        }
    }
}
