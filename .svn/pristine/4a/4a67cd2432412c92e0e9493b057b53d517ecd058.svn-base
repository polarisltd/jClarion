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

import org.jclarion.TestUtil;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.ref.RefVariable;

import junit.framework.TestCase;

public class ClarionGroupTest extends TestCase {

    
    private class TestClarionGroup extends ClarionGroup
    {
        public ClarionString s1=new ClarionString(10);
        public ClarionNumber n1=new ClarionNumber();;
        public ClarionArray<ClarionNumber> n2=new ClarionNumber().dim(10);
        public RefVariable<Object> o = new RefVariable<Object>();
        
        public TestClarionGroup()
        {
            addVariable("s1",s1);
            addVariable("n1",n1);
            addVariable("n2",n2);
            addVariable("o",o);
        }
    }

    private class MyGroup extends ClarionGroup
    {
        public RefVariable<ClarionFile> file=new RefVariable<ClarionFile>();
        
        public MyGroup()
        {
            addVariable("file",file);
        }
    }
    
    public void testOverGroup()
    {
        MyGroup mg = new MyGroup();
        ClarionNumber cn = new ClarionNumber();
        cn.setEncoding(ClarionNumber.LONG).setOver(mg);
        mg.file.set(new ClarionFile() {
			@Override
			public void add() {
			}

			@Override
			public void add(int size) {
			}

			@Override
			public boolean bof() {
				return false;
			}

			@Override
			public void buffer(Integer pagesize, Integer behind, Integer ahead,
					Integer timeout) {
			}

			@Override
			public void build() {
			}

			@Override
			public void close() {
			}

			@Override
			public void copyTo(String target) {
			}

			@Override
			public void create() {
			}

			@Override
			public void delete() {
			}

			@Override
			public boolean eof() {
				return false;
			}

			@Override
			public void flush() {
			}

			@Override
			public void freeState(int state) {
			}

			@Override
			public void get(ClarionKey akey) {
			}

			@Override
			public void get(ClarionString pointer, Integer len) {
			}

			@Override
			public void get(ClarionNumber position, Integer len) {
			}

			@Override
			protected String getDriver() {
				return null;
			}

			@Override
			public ClarionString getNulls() {
				return null;
			}

			@Override
			public int getPointer() {
				return 0;
			}

			@Override
			public ClarionString getPosition(ClarionKey key) {
				return null;
			}

			@Override
			public int getState() {
				return 0;
			}

			@Override
			public void lock() {
			}

			@Override
			public void next() {
			}

			@Override
			public void open(int mode) {
			}

			@Override
			public void previous() {
			}

			@Override
			public void put() {
			}

			@Override
			public int records() {
				return 0;
			}

			@Override
			public void reget(ClarionKey key, ClarionString string) {
			}

			@Override
			public void remove() {
			}

			@Override
			public void reset(ClarionKey key, ClarionString string) {
			}

			@Override
			public void restoreState(int state) {
			}

			@Override
			public void send(String operator) {
			}

			@Override
			public void set(ClarionKey key) {
			}

			@Override
			public void set(int position) {
			}

			@Override
			public void setNulls(ClarionString nulls) {
			}

			@Override
			public void stream() {
			}

			@Override
			public void unlock() {
			}

			@Override
			public void watch() {
			} });
        mg.notifyChange();
        assertEquals(CMemory.address(mg.file.get()),cn.intValue());
    }
    
    public void testConstruct()
    {
        new ClarionGroup();
    }

    private class TClarionGroup extends ClarionGroup
    {
        public RefVariable<Object> myObject=new RefVariable<Object>();
    }
    
    private static class G1 extends ClarionGroup
    {
        public ClarionString p1=new ClarionString("  ");
        public ClarionString p2=new ClarionString("  ");
        public ClarionString p3=new ClarionString("  ");
        public G1()
        {
            addVariable("p1",p1);
            addVariable("p2",p2);
            addVariable("p3",p3);
        }
    }

    private static class G2 extends ClarionGroup
    {
        public ClarionString p1=new ClarionString("  ");
        public ClarionString p2=new ClarionString("  ");
        public G2()
        {
            addVariable("p1",p1);
            addVariable("p2",p2);
        }
    }
    
    public void testCastTo()
    {
        G1 g1 = new G1();
        
        g1.p1.setValue("He");
        g1.p2.setValue("ll");
        g1.p3.setValue("o!");

        G2 g2 = (G2)g1.castTo(G2.class);
        
        assertEquals("Hello!",g2.getString().toString());
        assertEquals("He",g2.p1.toString());
        assertEquals("ll",g2.p2.toString());
        
        TestUtil.triggerGC();
        
        g1.p2.setValue("LL");
        assertEquals("HeLLo!",g2.getString().toString());

        g2.p1.setValue("hE");
        assertEquals("hELLo!",g1.getString().toString());
        assertEquals("hELLo!",g2.getString().toString());
        assertEquals("hE",g2.p1.toString());
        assertEquals("LL",g2.p2.toString());
    }

    public void testCastTo2()
    {
        G2 g2 = new G2();
        
        g2.p1.setValue("He");
        g2.p2.setValue("ll");

        G1 g1 = (G1)g2.castTo(G1.class);
        
        assertEquals("Hell  ",g1.getString().toString());
        
        TestUtil.triggerGC();
        
        g2.p2.setValue("LL");
        assertEquals("HeLL  ",g1.getString().toString());
        
        g1.p1.setValue("hE");
        assertEquals("hELL  ",g1.getString().toString());
        assertEquals("hELL",g2.getString().toString());
    }
    
    public void testAddReferenceNameNotPerfectMatch()
    {
        TClarionGroup cp = new TClarionGroup();
        cp.addVariable("Myobject",cp.myObject);
        assertEquals(1,cp.getVariableCount());
        
        assertNull(cp.what(1));
        cp.myObject.set(new ClarionString());
        assertSame(cp.myObject.get(),cp.what(1));
    }

    public void testAddReferenceNamePerfectMatch()
    {
        TClarionGroup cp = new TClarionGroup();
        cp.addVariable("myObject",cp.myObject);
        assertEquals(1,cp.getVariableCount());
        
        assertNull(cp.what(1));
        cp.myObject.set(new ClarionString());
        assertSame(cp.myObject.get(),cp.what(1));
    }
    
    
    public void testAddVariable()
    {
        ClarionGroup cg = new ClarionGroup();
        cg.addVariable("s1",new ClarionString(10));
        cg.addVariable("n1",new ClarionNumber());
        cg.addVariable("n2",(new ClarionNumber()).dim(5));
        //cg.addReference("o1",new Object());
    }

    public void testClear() {
        TestClarionGroup ctg = new TestClarionGroup();
        
        ctg.s1.setValue("Hello");
        ctg.n1.setValue(10);
        ctg.n2.get(5).setValue(12);
        ctg.n2.get(7).setValue(8);
        ctg.o.set(new Object());

        assertEquals("Hello     ",ctg.s1.toString());
        assertEquals(10,ctg.n1.intValue());
        assertEquals(12,ctg.n2.get(5).intValue());
        assertEquals(8,ctg.n2.get(7).intValue());
        assertNotNull(ctg.o.get());
        
        
        ctg.clear();
        assertEquals("          ",ctg.s1.toString());
        assertEquals(0,ctg.n1.intValue());
        assertEquals(0,ctg.n2.get(5).intValue());
        assertEquals(0,ctg.n2.get(7).intValue());
        assertNull(ctg.o.get());
        
        ctg.clear(-1);
        assertEquals("\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000",ctg.s1.toString());
        assertEquals(-2147483648,ctg.n1.intValue());
        assertEquals(-2147483648,ctg.n2.get(5).intValue());
        assertEquals(-2147483648,ctg.n2.get(7).intValue());
        assertEquals(-2147483648,ctg.n2.get(8).intValue());
        assertNull(ctg.o.get());
        
        ctg.clear(1);
        assertEquals("\u00ff\u00ff\u00ff\u00ff\u00ff\u00ff\u00ff\u00ff\u00ff\u00ff",ctg.s1.toString());
        assertEquals(2147483647,ctg.n1.intValue());
        assertEquals(2147483647,ctg.n2.get(5).intValue());
        assertEquals(2147483647,ctg.n2.get(7).intValue());
        assertEquals(2147483647,ctg.n2.get(8).intValue());
        assertNull(ctg.o.get());
        
        
    }

    public void testSetOver() {
        TestClarionGroup ctg = new TestClarionGroup();
        
        ctg.s1.setValue("Hello");
        ctg.n1.setValue(10);
        ctg.n2.get(5).setValue(12);
        ctg.n2.get(7).setValue(8);
        ctg.o.set(new Object());
        
        TestClarionGroup ctg2 = new TestClarionGroup();
        ctg2.setOver(ctg);
        
        assertNotSame(ctg,ctg2);
        
        assertEquals("Hello     ",ctg2.s1.toString());
        assertEquals(10,ctg2.n1.intValue());
        assertEquals(12,ctg2.n2.get(5).intValue());
        assertEquals(8,ctg2.n2.get(7).intValue());
        assertNotNull(ctg2.o);
        
        ctg.s1.setValue("World");

        assertEquals("World     ",ctg2.s1.toString());
        assertEquals(10,ctg2.n1.intValue());
        assertEquals(12,ctg2.n2.get(5).intValue());
        assertEquals(8,ctg2.n2.get(7).intValue());
        assertNotNull(ctg2.o);
        
        ctg.n2.get(9).setValue(255);

        assertEquals("World     ",ctg2.s1.toString());
        assertEquals(10,ctg2.n1.intValue());
        assertEquals(12,ctg2.n2.get(5).intValue());
        assertEquals(8,ctg2.n2.get(7).intValue());
        assertEquals(255,ctg2.n2.get(9).intValue());
        assertNotNull(ctg2.o);
        
        assertNotSame(ctg.n2.get(9),ctg2.n2.get(9));
    }
    
    public void testSerialize()
    {
        ClarionGroup cg = new ClarionGroup();
        
        cg.addVariable("s1",new ClarionString("Hello"));
        cg.addVariable("s2",new ClarionString(" "));
        cg.addVariable("s4",new ClarionString("World"));
        cg.addVariable("s3",new ClarionNumber(0x100));
        
        TestUtil.testSerialize("Hello World\u0000\u0001\u0000\u0000",cg);
    }

    public void testDeserialize()
    {
        ClarionGroup cg = new ClarionGroup();
        
        ClarionString s1 = new ClarionString(5);
        ClarionString s2 = new ClarionString(1);
        ClarionString s3 = new ClarionString(5);
        ClarionNumber n1 = new ClarionNumber();
           
        cg.addVariable("s1",s1);
        cg.addVariable("s2",s2);
        cg.addVariable("s4",s3);
        cg.addVariable("s3",n1);
        
        TestUtil.testDeserialize("Hello World\u0000\u0001\u0000\u0000",cg);
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("World",s3.toString());
        assertEquals(0x100,n1.intValue());
    }
    
    public class TestClarionGroup2 extends TestClarionGroup
    {
        public TestClarionGroup base=new TestClarionGroup();
        public ClarionString k=new ClarionString(20); 
        
        public TestClarionGroup2() {
            super();
            addVariable("base",base);
            addVariable("k",k);
        }
    }

    public class TestClarionGroup3 extends TestClarionGroup
    {
        public TestClarionGroup base=new TestClarionGroup();
        public ClarionDecimal k=new ClarionDecimal(10,2); 
        
        public TestClarionGroup3() {
            super();
            addVariable("k",k);
            addVariable("base",base);
        }
    }
    
    public void testMerge() {
        TestClarionGroup2 tg2 = new TestClarionGroup2();
        TestClarionGroup3 tg3 = new TestClarionGroup3();
        
        tg2.n1.setValue(20);
        tg2.n2.get(1).setValue(5);
        tg2.o.set(new Object());
        tg2.s1.setValue("Some crap");
        tg2.base.s1.setValue("Some Other Crap");
        tg2.base.o.set(new Object());
        tg2.k.setValue("120.5");
        
        tg3.merge(tg2);
        
        assertEquals(20,tg3.n1.intValue());
        assertEquals(5,tg3.n2.get(1).intValue());
        assertSame(tg2.o.get(),tg3.o.get());
        assertEquals("Some crap ",tg3.s1.toString());
        assertEquals("Some Other",tg3.base.s1.toString());
        assertSame(tg2.base.o.get(),tg3.base.o.get());
        assertEquals("120.50",tg3.k.toString());
    }
    
    public void testWhat()
    {
        TestClarionGroup2 tg2 = new TestClarionGroup2();
        
        assertSame(tg2.s1,tg2.what(1));
        assertSame(tg2.n1,tg2.what(2));
        assertSame(null,tg2.what(3));   // cannot 'what' an array
        assertSame(null,tg2.what(4));   // cannot 'what' an object
        assertSame(null,tg2.what(5));   // cannot 'what' a group
        
        assertSame(tg2.base.s1,tg2.what(6));
        assertSame(tg2.base.n1,tg2.what(7));
        assertSame(null,tg2.what(8));   // cannot 'what' an array
        assertSame(null,tg2.what(9));   // cannot 'what' an object
        
        assertSame(tg2.k,tg2.what(10));
        
    }
    
    public void testGetGroupParam() {
        TestClarionGroup tg = new TestClarionGroup();
        
        assertSame(tg.s1,tg.getGroupParam("s1"));
        assertSame(tg.n1,tg.getGroupParam("n1"));
    }

    public void testWhere() {
        TestClarionGroup2 tg2 = new TestClarionGroup2();
        tg2.o.set(new Object());
        tg2.base.o.set(new Object());
        
        assertEquals(1,tg2.where(tg2.s1));
        assertEquals(2,tg2.where(tg2.n1));
        assertEquals(4,tg2.where(tg2.o)); 
        assertEquals(5,tg2.where(tg2.base));  
        assertEquals(6,tg2.where(tg2.base.s1));
        assertEquals(7,tg2.where(tg2.base.n1));
        assertEquals(9,tg2.where(tg2.base.o)); 
        assertEquals(10,tg2.where(tg2.k)); 
    }

    public void testGetString() {
        ClarionGroup cg = new ClarionGroup();
        
        cg.addVariable("s1",new ClarionString("Hello"));
        cg.addVariable("s2",new ClarionString(" "));
        cg.addVariable("s4",new ClarionString("World"));
        cg.addVariable("s3",new ClarionNumber(0x100));

        assertEquals("Hello World\u0000\u0001\u0000\u0000",cg.getString().toString());
    }

    public void testSetValue() {
        ClarionGroup cg = new ClarionGroup();
        
        ClarionString s1=new ClarionString(5);
        ClarionString s2=new ClarionString(1);
        ClarionString s4=new ClarionString(5);
        ClarionNumber s3=new ClarionNumber();
        
        cg.addVariable("s1",s1);
        cg.addVariable("s2",s2);
        cg.addVariable("s4",s4);
        cg.addVariable("s3",s3);
        
        cg.setValue("Hello World\u0000\u0001\u0000\u0000");
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("World",s4.toString());
        assertEquals(0x100,s3.intValue());
    }

    public void testSetLongValue() {
        ClarionGroup cg = new ClarionGroup();
        
        ClarionString s1=new ClarionString(5);
        ClarionString s2=new ClarionString(1);
        ClarionString s4=new ClarionString(5);
        ClarionNumber s3=new ClarionNumber();
        
        cg.addVariable("s1",s1);
        cg.addVariable("s2",s2);
        cg.addVariable("s4",s4);
        cg.addVariable("s3",s3);
        
        cg.setValue("Hello World\u0000\u0000\u0001\u0000      ");
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("World",s4.toString());
        assertEquals(0x10000,s3.intValue());
    }

    public void testSetShortenedValue() {
        ClarionGroup cg = new ClarionGroup();
        
        ClarionString s1=new ClarionString(5);
        ClarionString s2=new ClarionString(1);
        ClarionString s4=new ClarionString(5);
        ClarionNumber s3=new ClarionNumber();
        
        cg.addVariable("s1",s1);
        cg.addVariable("s2",s2);
        cg.addVariable("s4",s4);
        cg.addVariable("s3",s3);
        
        cg.setValue("Hello World\u0000\u0001");
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("World",s4.toString());
        assertEquals(0x20200100,s3.intValue());
    }
    
    public void testSetShortenedValueTwoTimesToVerifySizeCache() {
        ClarionGroup cg = new ClarionGroup();
        
        ClarionString s1=new ClarionString(5);
        ClarionString s2=new ClarionString(1);
        ClarionString s4=new ClarionString(5);
        ClarionNumber s3=new ClarionNumber();
        
        cg.addVariable("s1",s1);
        cg.addVariable("s2",s2);
        cg.addVariable("s4",s4);
        cg.addVariable("s3",s3);
        
        cg.setValue("Hello World\u0000\u0001");
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("World",s4.toString());
        assertEquals(0x20200100,s3.intValue());

        cg.setValue("Hello There");
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("There",s4.toString());
        assertEquals(0x20202020,s3.intValue());

        cg.setValue("Hello There\u0001\u0001\u0002\u0003");
        assertEquals("Hello",s1.toString());
        assertEquals(" ",s2.toString());
        assertEquals("There",s4.toString());
        assertEquals(0x03020101,s3.intValue());
    }
    
}
