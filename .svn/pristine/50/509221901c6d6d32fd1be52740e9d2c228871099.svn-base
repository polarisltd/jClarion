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
import org.jclarion.clarion.constants.Match;

import junit.framework.TestCase;

public class ClarionStringTest extends TestCase {

    private ThreadHelper helper;
    
    public void tearDown()
    {
        if (helper!=null) {
            helper.tearDown();
            helper=null;
        }
    }
    
    private static class NV implements ClarionMemoryChangeListener
    {
        private String result;
        
        @Override
        public void objectChanged(ClarionMemoryModel model) 
        {
            result = model.toString();
            // TODO Auto-generated method stub
        }
        
        public String toString()
        {
            return result;
        }
        
        public void clear()
        {
            result=null;
        }
        
    }
    
    private NV addNV(ClarionString cs)
    {
        NV nv = new NV(); 
        cs.addChangeListener(nv);
        return nv;
    }

    public void testNotThreadedString()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionString s = new ClarionString(10);
        
        final String[] r=new String[1];
        
        s.setValue("Hello");
        assertEquals("Hello",s.toString().trim());
        
        s.setStringAt(3,4,"LL");
        assertEquals("HeLLo",s.toString().trim());
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue("World");
                r[0]=s.toString();
            } } ,5000);

        assertEquals("World",s.toString().trim());
        assertEquals("World",r[0].toString().trim());
    }
    
    public void testThreadedString()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionString s = (new ClarionString(10)).setThread();
        
        final String[] r=new String[1];
        
        s.setValue("Hello");
        assertEquals("Hello",s.toString().trim());
        
        s.setStringAt(3,4,"LL");
        assertEquals("HeLLo",s.toString().trim());
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue("World");
                assertEquals("World",s.toString().trim());
                r[0]=s.toString();
            } } ,5000);

        assertEquals("HeLLo",s.toString().trim());
        assertEquals("World",r[0].toString().trim());
    }

    
    public void testOverloadTriggersUpdate()
    {
        ClarionString s = new ClarionString(10);
        ClarionString s2 = new ClarionString(10);
        s2.setOver(s);
        
        s.setValue("MCC");
        assertEquals("MCC       ",s.toString());
        assertEquals("MCC       ",s2.toString());
        
        s.setValue("MCCB");
        assertEquals("MCCB      ",s.toString());
        assertEquals("MCCB      ",s2.toString());

        s.setValue("MCC");
        assertEquals("MCC       ",s.toString());
        assertEquals("MCC       ",s2.toString());

        s.setStringAt(4,"C");
        assertEquals("MCCC      ",s.toString());
        assertEquals("MCCC      ",s2.toString());

        s.setStringAt(4," ");
        assertEquals("MCC       ",s.toString());
        assertEquals("MCC       ",s2.toString());
    }
    
    private class MyClarionGroup extends ClarionGroup
    {
        ClarionAny a = new ClarionAny();
        
        public MyClarionGroup()
        {
            addVariable("a",a);
        }
    }

    public void testOverloadTriggersUpdateViaAny()
    {
        ClarionString s = new ClarionString(10);
        
        MyClarionGroup a1 = new MyClarionGroup();
        MyClarionGroup a2 = new MyClarionGroup();
        
        a1.setOver(a2);
        
        a1.a.setReferenceValue(s);
        
        s.setValue("MCC");
        
        assertEquals("MCC       ",s.toString());
        assertEquals("MCC       ",a1.a.toString());
        assertEquals("MCC       ",a2.a.toString());
        
        s.setValue("MCCB");

        assertEquals("MCCB      ",s.toString());
        assertEquals("MCCB      ",a1.a.toString());
        assertEquals("MCCB      ",a2.a.toString());

        s.setValue("MCC");
        
        assertEquals("MCC       ",s.toString());
        assertEquals("MCC       ",a1.a.toString());
        assertEquals("MCC       ",a2.a.toString());
        
        a2.a.setValue("MCCD");

        assertEquals("MCCD      ",s.toString());
        assertEquals("MCCD      ",a1.a.toString());
        assertEquals("MCCD      ",a2.a.toString());
    }
    
    public void testConstruct() {
        ClarionString s = new ClarionString("hello");
        assertEquals("hello",s.toString());

        s = new ClarionString();
        assertEquals("",s.toString());

        s = new ClarionString(15);
        assertEquals("               ",s.toString());
    }

    public void testSetValueClarionObject() {
        ClarionString s = new ClarionString(20);
        ClarionString t = new ClarionString("Hello");
        ClarionString t2 = new ClarionString("Hello2");
        s.setValue(t);
        assertEquals("Hello               ",s.toString());
        s.setValue(t2);
        assertEquals("Hello2              ",s.toString());
    }
    
    public void testSetValueZeroLengthString()
    {
        ClarionString s =new ClarionString();
        ClarionMemoryChangeListener cmcl =new ClarionMemoryChangeListener() {

            @Override
            public void objectChanged(ClarionMemoryModel model) {
                // TODO Auto-generated method stub
                
            } } ; 
        s.addChangeListener(cmcl);
        assertEquals("",s.toString());
        s.setValue("Hello");
        assertEquals("Hello",s.toString());
        s.setStringAt(1,"h");
        assertEquals("hello",s.toString());
        s.setValue("");
        assertEquals("",s.toString());
    }

    public void testSetValueClarionObjectWithNotify() {
        ClarionString s = new ClarionString(20);
        NV nv = addNV(s);
        ClarionString t = new ClarionString("Hello");
        ClarionString t2 = new ClarionString("Hello2");
        s.setValue(t);
        assertEquals("Hello               ",nv.toString());
        assertEquals("Hello               ",s.toString());
        assertEquals("Hello",t.toString());
        s.setValue(t2);
        assertEquals("Hello2              ",nv.toString());
        assertEquals("Hello2              ",s.toString());
        assertEquals("Hello2",t2.toString());
        
        nv.clear();
        s.setValue("Hello2");
        assertNull(nv.toString());
        s.setValue("Hello2  ");
        assertNull(nv.toString());

        s.setValue("Hello");
        assertEquals("Hello               ",nv.toString());
        
    }
    
    
    public void testSetValueClarionExact() {
        ClarionString s = new ClarionString(5);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
    }

    public void testSetValueClarionExactAndnotify() {
        ClarionString s = new ClarionString(5);
        NV nv = addNV(s);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
        assertEquals("Hello",nv.toString());
        assertEquals("Hello",t.toString());
    }
    
    public void testSetValueClarionClips() {
        ClarionString s = new ClarionString(3);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hel",s.toString());
    }

    public void testSetValueClarionClipsAndNotify() {
        ClarionString s = new ClarionString(3);
        NV nv = addNV(s);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hel",nv.toString());
        assertEquals("Hel",s.toString());
        assertEquals("Hello",t.toString());
    }

    
    public void testSetValueClarionObjectPString() {
        ClarionString s = (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
    }

    public void testSetValueClarionObjectPStringAndNotify() {
        ClarionString s = (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        NV nv = addNV(s);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
        assertEquals("Hello",nv.toString());
        assertEquals("Hello",t.toString());
        
        nv.clear();
        s.setValue("Hello ");
        assertEquals("Hello ",nv.toString());

        nv.clear();
        s.setValue("Hello");
        assertEquals("Hello",nv.toString());

        nv.clear();
        s.setValue("Hello");
        assertNull(nv.toString());
    }

    public void testSetValueClarionObjectPStringTwice() {
        ClarionString s = (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        ClarionString t = new ClarionString("Hello");
        s.setValue("XYZ");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
    }
    
    public void testSetValueClarionObjectPStringExact() {
        ClarionString s = (new ClarionString(6)).setEncoding(ClarionString.PSTRING);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
    }

    public void testSetValueClarionObjectPStringExact2() {
        ClarionString s = (new ClarionString("xxxxx")).setEncoding(ClarionString.PSTRING);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hello",s.toString());
    }

    public void testSetValueClarionObjectPStringClips() {
        ClarionString s = (new ClarionString(5)).setEncoding(ClarionString.PSTRING);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hell",s.toString());
    }

    public void testSetValueClarionObjectPStringClips2() {
        ClarionString s = (new ClarionString("xxxx")).setEncoding(ClarionString.PSTRING);
        ClarionString t = new ClarionString("Hello");
        s.setValue(t);
        
        assertEquals("Hell",s.toString());
    }

    public void testClearString() {
        ClarionString t = new ClarionString("Hello");
        t.clear();
        assertEquals("     ",t.toString());
        t.clear(1);
        assertEquals("\u00ff\u00ff\u00ff\u00ff\u00ff",t.toString());
        t.clear(-1);
        assertEquals("\u0000\u0000\u0000\u0000\u0000",t.toString());
        t.clear(0);
        assertEquals("     ",t.toString());
    }

    public void testClearStringNotifies() {
        ClarionString t = new ClarionString("Hello");
        NV nv = addNV(t);
        t.clear();
        assertEquals("     ",nv.toString());
        assertEquals("     ",t.toString());
        t.clear(1);
        assertEquals("\u00ff\u00ff\u00ff\u00ff\u00ff",t.toString());
        assertEquals("\u00ff\u00ff\u00ff\u00ff\u00ff",nv.toString());
        t.clear(-1);
        assertEquals("\u0000\u0000\u0000\u0000\u0000",t.toString());
        assertEquals("\u0000\u0000\u0000\u0000\u0000",nv.toString());
        t.clear(0);
        assertEquals("     ",nv.toString());
        assertEquals("     ",t.toString());
    }
    
    public void testClearPString() {
        ClarionString t = (new ClarionString("Hello")).setEncoding(ClarionString.PSTRING);
        t.clear();
        assertEquals("",t.toString());
        t.clear(1);
        assertEquals("\u00ff\u00ff\u00ff\u00ff\u00ff",t.toString());
        t.clear(-1);
        assertEquals("",t.toString());
        t.clear(0);
        assertEquals("",t.toString());
    }
    
    public void testIntValue() {

        ClarionString t = new ClarionString("1");
        assertEquals(1,t.intValue());

        t = new ClarionString("100");
        assertEquals(100,t.intValue());

        t = new ClarionString("100   ");
        assertEquals(100,t.intValue());

        t = new ClarionString("-100   ");
        assertEquals(-100,t.intValue());

        t = new ClarionString("0   ");
        assertEquals(0,t.intValue());

        t = new ClarionString("   ");
        assertEquals(0,t.intValue());

        t = new ClarionString("Hello   ");
        assertEquals(0,t.intValue());

        t = new ClarionString("12.4   ");
        assertEquals(12,t.intValue());

        t = new ClarionString("-12.5   ");
        assertEquals(-12,t.intValue());
        
        t = new ClarionString(".");
        assertEquals(0,t.intValue());
        assertEquals(0,t.getNumber().intValue());
        assertEquals(0,t.getDecimal().intValue());

        t = new ClarionString("1.");
        assertEquals(1,t.intValue());
        assertEquals(1,t.getNumber().intValue());
        assertEquals(1,t.getDecimal().intValue());

        t = new ClarionString("1.4");
        assertEquals(1,t.intValue());
        assertEquals(1,t.getNumber().intValue());
        assertEquals("1.4",t.getDecimal().toString());

        t = new ClarionString(".4");
        assertEquals(0,t.intValue());
        assertEquals(0,t.getNumber().intValue());
        assertEquals("0.4",t.getDecimal().toString());
        
    }

    public void testIntValueAfterAssign() {

        ClarionString t = new ClarionString("1       ");
        assertEquals(1,t.intValue());

        t.setValue("100");
        assertEquals(100,t.intValue());

        t.setValue("100   ");
        assertEquals(100,t.intValue());

        t.setValue("-100   ");
        assertEquals(-100,t.intValue());

        t.setValue("0   ");
        assertEquals(0,t.intValue());

        t.setValue("   ");
        assertEquals(0,t.intValue());

        t.setValue("Hello   ");
        assertEquals(0,t.intValue());

        t.setValue("12.4   ");
        assertEquals(12,t.intValue());

        t.setValue("-12.5   ");
        assertEquals(-12,t.intValue());
    }
    
    public void testBoolValue() {
        
        ClarionString t;
        
        t = new ClarionString(10);
        assertFalse(t.boolValue());

        t = new ClarionString("   ");
        assertFalse(t.boolValue());

        t = new ClarionString("xxx");
        assertTrue(t.boolValue());

        t = new ClarionString("1");
        assertTrue(t.boolValue());

        t = new ClarionString("0");
        assertTrue(t.boolValue());
    }

    public void testCompareToClarionObject() 
    {
        ClarionString l=new ClarionString("1    ");
        ClarionString r=new ClarionString("2          ");
        
        assertTrue(l.compareTo(r)<0);
        assertTrue(r.compareTo(l)>0);
        
        l=new ClarionString("1   ");
        r=new ClarionString("2 ");
        
        assertTrue(l.compareTo(r)<0);
        assertTrue(r.compareTo(l)>0);

        l=new ClarionString("10  ");
        r=new ClarionString("2 ");
        
        assertTrue(l.compareTo(r)<0);
        assertTrue(r.compareTo(l)>0);

        l=new ClarionString("1");
        r=new ClarionString("1 ");
        
        assertTrue(l.compareTo(r)==0);
        assertTrue(r.compareTo(l)==0);

    }

    public void testCompareToClarionObjectAfterAssign() 
    {
        ClarionString l=new ClarionString("x    ");
        l.setValue("1    ");
        ClarionString r=new ClarionString("y          ");
        r.setValue(                       "2          ");
        
        assertTrue(l.compareTo(r)<0);
        assertTrue(r.compareTo(l)>0);
        
        l=new ClarionString("1   ");
        r=new ClarionString("2 ");
        
        assertTrue(l.compareTo(r)<0);
        assertTrue(r.compareTo(l)>0);

        l=new ClarionString("10  ");
        r=new ClarionString("2 ");
        
        assertTrue(l.compareTo(r)<0);
        assertTrue(r.compareTo(l)>0);

        l=new ClarionString("1");
        r=new ClarionString("1 ");
        
        assertTrue(l.compareTo(r)==0);
        assertTrue(r.compareTo(l)==0);

    }
    
    public void testEqualsNumeric() 
    {
        assertTrue(Clarion.newString(20).equals(0));
        assertTrue(Clarion.newString("").equals(0));
        assertTrue(Clarion.newString("   ").equals(0));
        assertTrue(Clarion.newString("0001").equals(1));
        assertTrue(Clarion.newString("0000").equals(0));
    }

    public void testEqualsBin()
    {
        ClarionString l=new ClarionString("1    ");
        ClarionString r=new ClarionString("1          ");
        assertTrue(l.equals(r));

        l=new ClarionString("1\0\0\0\0");
        r=new ClarionString("1\0\0\0\0\0");
        assertFalse(l.equals(r));
        assertFalse(r.equals(l));

        l=new ClarionString("1\u0000");
        r=new ClarionString("1");
        assertFalse(l.equals(r));
        assertFalse(r.equals(l));
    }
        
    public void testEquals()
    {
        ClarionString l=new ClarionString("1    ");
        ClarionString r=new ClarionString("2          ");
        
        assertFalse(l.equals(r));
        assertFalse(r.equals(l));
        
        l=new ClarionString("1   ");
        r=new ClarionString("2 ");
        
        assertFalse(l.equals(r));
        assertFalse(r.equals(l));

        l=new ClarionString("10  ");
        r=new ClarionString("2 ");
        
        assertFalse(l.equals(r));
        assertFalse(r.equals(l));

        l=new ClarionString("1");
        r=new ClarionString("1 ");
        
        assertTrue(l.equals(r));
        assertTrue(r.equals(l));
        
        assertTrue(r.equals("1"));
        assertTrue(r.equals("1  "));
        assertFalse(r.equals(" 1  "));
        assertFalse(r.equals(""));
        assertFalse(r.equals("2"));
    }
    
    public void testGetString() {
        ClarionString l = new ClarionString("xyz");
        assertSame(l,l.getString());
    }

    public void testLike() {
        ClarionString l = new ClarionString("xyz abc  ");
        ClarionString c = l.like();
        assertNotSame(l,c);
        assertTrue(l.equals(c));
    }

    public void testLikeThenModifyDoesNotDuplicate() {
        ClarionString l = new ClarionString("xyz abc  ");
        ClarionString c = l.like();
        assertNotSame(l,c);
        assertTrue(l.equals(c));
        l.setValue("abc xyz");
        assertFalse(l.equals(c));
        assertEquals("xyz abc  ",c.toString());
        assertEquals("abc xyz  ",l.toString());
    }
    
    public void testSetName() {
        ClarionString l = (new ClarionString("xyz abc  ")).setName("externalname");
        assertEquals("externalname",l.getName());
    }
    
    public void testDimInt() {
        
        ClarionString l[] = (new ClarionString(20)).dim(5);
        
        assertEquals(6,l.length);
        assertNull(l[0]);
        for (int scan=1;scan<6;scan++) {
            assertEquals("                    ",l[scan].toString());
        }
    }

    public void testDimInt2() {
        
        ClarionString l[][] = (new ClarionString(20)).dim(5,6);
        
        assertEquals(6,l.length);
        for (int s2=1;s2<=6;s2++) {
            assertNull(l[0][s2]);
        }
        
        for (int s1=1;s1<=5;s1++) {
            assertNull(l[s1][0]);
            for (int s2=1;s2<=6;s2++) {
                assertEquals("                    ",l[s1][s2].toString());
            }
        }
    }

    public void testDimInt3() {
        
        ClarionString l[][][] = (new ClarionString(20)).dim(6,5,4);
        
        for (int s1=1;s1<=6;s1++) {
            for (int s2=1;s2<=5;s2++) {
                assertNull(l[s1][s2][0]);
                for (int s3=1;s2<=4;s2++) {
                    
                    assertNull(l[s1][0][s3]);
                    assertNull(l[0][0][s3]);
                    assertNull(l[0][s2][s3]);
                    
                    assertEquals("                    ",l[s1][s2][s3].toString());
                }
            }
        }
    }

    public void testSetStringAt() {
        
        ClarionString cs = new ClarionString(20);
        cs.setValue("Hello");

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
        
        cs.setStringAt(1,"h");
        
        assertFalse(cs.equals("Hello"));
        assertTrue(cs.equals("hello"));
        
        cs.setStringAt(6,"!");
        assertFalse(cs.equals("Hello!"));
        assertTrue(cs.equals("hello!"));
    }

    public void testSetStringAtWithNotify() {
        
        ClarionString cs = new ClarionString(20);
        NV nv = addNV(cs);
        cs.setValue("Hello");
        assertEquals("Hello               ",nv.toString());

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
        
        cs.setStringAt(1,"h");
        assertEquals("hello               ",nv.toString());
        
        assertFalse(cs.equals("Hello"));
        assertTrue(cs.equals("hello"));
        
        cs.setStringAt(6,"!");
        assertFalse(cs.equals("Hello!"));
        assertTrue(cs.equals("hello!"));
        assertEquals("hello!              ",nv.toString());
        
        
        nv.clear();
        assertNull(nv.toString());
        cs.setStringAt(2,"e");
        assertNull(nv.toString());
        
        cs.setStringAt(2,"E");
        assertEquals("hEllo!              ",nv.toString());
    }
    
    public void testEfficientSetStringAt() {
        
        ClarionString cs = new ClarionString(40000);
        cs.setValue("Hello");

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
    
        long start = System.currentTimeMillis();
        
        for (int scan=0;scan<20000;scan++) {
            cs.setStringAt(1,new String(new char [] { (char)scan }  ));
        }
        
        assertTrue(System.currentTimeMillis()-start<500);
        
        cs.setStringAt(1,'h');
        
        assertFalse(cs.equals("Hello"));
        assertTrue(cs.equals("hello"));
        
        cs.setStringAt(6,"!");
        assertFalse(cs.equals("Hello!"));
        assertTrue(cs.equals("hello!"));
    }
    
    public void testSetStringAtPDecimal() {
        
        ClarionString cs = (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello");

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
        
        cs.setStringAt(1,"h");
        
        assertFalse(cs.equals("Hello"));
        assertTrue(cs.equals("hello"));
        
        cs.setStringAt(6,"!");
        assertFalse(cs.equals("Hello!"));
        assertTrue(cs.equals("hello!"));

        cs.setStringAt(3,new ClarionNumber(7));
        assertTrue(cs.equals("he7lo!"));
    }

    public void testSetStringAt2() {
        
        ClarionString cs = new ClarionString(20);
        cs.setValue("Hello");

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
        
        cs.setStringAt(7,11,"World");
        
        assertTrue(cs.toString(),cs.equals("Hello World"));
        
        cs.setStringAt(2,3,"EL");
        assertTrue(cs.toString(),cs.equals("HELlo World"));

        cs.setStringAt(2,3,"XXX");
        assertTrue(cs.toString(),cs.equals("HXXlo World"));

        cs.setStringAt(2,3,"X");
        assertTrue(cs.toString(),cs.equals("HX lo World"));
    }

    public void testSetStringAt2WithNotify() {
        
        ClarionString cs = new ClarionString(20);
        NV nv = addNV(cs);
        cs.setValue("Hello");
        assertEquals("Hello               ",nv.toString());

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
        
        cs.setStringAt(7,11,"World");
        assertEquals("Hello World         ",nv.toString());
        
        assertTrue(cs.toString(),cs.equals("Hello World"));
        
        cs.setStringAt(2,3,"EL");
        assertEquals("HELlo World         ",nv.toString());
        assertTrue(cs.toString(),cs.equals("HELlo World"));

        cs.setStringAt(2,3,"XXX");
        assertEquals("HXXlo World         ",nv.toString());
        assertTrue(cs.toString(),cs.equals("HXXlo World"));

        cs.setStringAt(2,3,"X");
        assertEquals("HX lo World         ",nv.toString());
        assertTrue(cs.toString(),cs.equals("HX lo World"));

        nv.clear();
        cs.setStringAt(8,9,"or");
        assertNull(nv.toString());

        cs.setStringAt(10,12,"ld ");
        assertNull(nv.toString());

        cs.setStringAt(10,12,"ldy");
        assertEquals("HX lo Worldy        ",nv.toString());
    }
    
    
    public void testSetStringAt2PDecimal() {
        
        ClarionString cs = (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello");

        assertTrue(cs.equals("Hello"));
        assertFalse(cs.equals("hello"));
        
        cs.setStringAt(7,11,"World");
        
        assertTrue(cs.toString(),cs.equals("Hello World"));
        
        cs.setStringAt(2,3,"EL");
        assertTrue(cs.toString(),cs.equals("HELlo World"));

        cs.setStringAt(2,3,"XXX");
        assertTrue(cs.toString(),cs.equals("HXXlo World"));

        cs.setStringAt(2,3,"X");
        assertTrue(cs.toString(),cs.equals("HX lo World"));
    }

    public void testConcat() {
        ClarionString c1; 
        ClarionString c2; 
        ClarionString c3;
    
        c1= new ClarionString("Hello");
        c2= new ClarionString(" World");
        c3 = Clarion.newString(c1.concat(c2));
        assertEquals("Hello World",c3.toString());

        c1= new ClarionString(10);
        c1.setValue("Hello");
        c2= new ClarionString(" World");
        c3 = Clarion.newString(c1.concat(c2));
        assertEquals("Hello      World",c3.toString());
        c1= new ClarionString(10);

        c1.setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello");
        c2= new ClarionString(" World");
        c3 = Clarion.newString(c1.concat(c2));
        assertEquals("Hello World",c3.toString());
        
        assertEquals("Hello World One Two Three",c3.concat(" One"," Two"," Three"));
    }

    public void testSingleStringAt() {
        ClarionString c1= new ClarionString(20);
        c1.setValue("Hello");
        
        assertEquals("H",c1.stringAt(1).toString());

        assertEquals("e",c1.stringAt(2).toString());

        assertEquals(" ",c1.stringAt(10).toString());
    }

    public void testSingleStringAt2() {
        ClarionString c1= new ClarionString("Hello");
        
        assertEquals("H",c1.stringAt(1).toString());

        assertEquals("e",c1.stringAt(2).toString());

        assertEquals(" ",c1.stringAt(10).toString());
    }
    
    public void testSingleStringAtPDecimal() {
        ClarionString c1= (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello");
        
        assertEquals("H",c1.stringAt(1).toString());

        assertEquals("e",c1.stringAt(2).toString());

        assertEquals(" ",c1.stringAt(10).toString());
    }

    public void testRangeStringAt() {
        ClarionString c1= new ClarionString(20);
        c1.setValue("Hello");
        
        assertEquals("He",c1.stringAt(1,2).toString());

        assertEquals("ell",c1.stringAt(2,4).toString());

        assertEquals("ello ",c1.stringAt(2,6).toString());
    }

    public void testRangeStringAt2() {
        ClarionString c1= new ClarionString("Hello ");
        
        assertEquals("He",c1.stringAt(1,2).toString());

        assertEquals("ell",c1.stringAt(2,4).toString());

        assertEquals("ello ",c1.stringAt(2,6).toString());
    }
    
    public void testRangeStringAtPDecimal() {
        ClarionString c1= (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello");
        
        assertEquals("He",c1.stringAt(1,2).toString());

        assertEquals("ell",c1.stringAt(2,4).toString());

        assertEquals("ello ",c1.stringAt(2,6).toString());
        
        assertEquals("He",c1.stringAt(0,2).toString());

        assertEquals("Hello               ",c1.stringAt(1,21).toString());
    }

    public void testVal()
    {
        ClarionString cs = new ClarionString("A");
        assertEquals(65,cs.val());
    }

    public void testChr()
    {
        ClarionString cs = ClarionString.chr(65);
        assertEquals("A",cs.toString());
    }
    
    public void testLen()
    {
        ClarionString cs;
        
        cs = new ClarionString("Hello");
        assertEquals(5,cs.len());

        cs = new ClarionString(20);
        cs.setValue("Hello");
        assertEquals(20,cs.len());

        cs = (new ClarionString(20)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello");
        assertEquals(5,cs.len());
    }

    public void testSub() {
        ClarionString c1= new ClarionString(10);
        c1.setValue("Hello");
        
        assertEquals("He",c1.sub(1,2).toString());

        assertEquals("ell",c1.sub(2,3).toString());

        assertEquals("ello ",c1.sub(2,5).toString());
        
        c1=new ClarionString("Hello");

        assertEquals("He",c1.sub(1,2).toString());

        assertEquals("ell",c1.sub(2,3).toString());

        assertEquals("ello",c1.sub(2,5).toString());
        
        assertEquals("o",c1.sub(-1,1).toString());

        assertEquals("ll",c1.sub(-3,2).toString());
    
        assertEquals("ello",c1.sub(2).toString());

        assertEquals("llo",c1.sub(-3).toString());
    }
    
    public void testSerializeString() {
        
        ClarionString c1= new ClarionString(10);
        c1.setValue("Hello");
        
        TestUtil.testSerialize("Hello     ",c1);
        
        c1= (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello");
        
        TestUtil.testSerialize("\u0005Hello    ",c1);

        c1= (new ClarionString(10)).setEncoding(ClarionString.CSTRING);
        c1.setValue("Hello");
        
        TestUtil.testSerialize("Hello\u0000    ",c1);
        
    }

    public void testSerializeStringNotifies() {
        
        ClarionString c1= new ClarionString(10);
        c1.setValue("Hello");
        
        TestUtil.testSerialize("Hello     ",c1);
        
        c1= (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello");
        
        TestUtil.testSerialize("\u0005Hello    ",c1);

        c1= (new ClarionString(10)).setEncoding(ClarionString.CSTRING);
        c1.setValue("Hello");
        
        TestUtil.testSerialize("Hello\u0000    ",c1);
        
    }
    
    public void testDeserializeString() {
        
        ClarionString c1= new ClarionString(10);
        TestUtil.testDeserialize("Hello     ",c1);
        assertEquals("Hello     ",c1.toString());
        
        c1= (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        TestUtil.testDeserialize("\u0005Hello    ",c1);
        assertEquals("Hello",c1.toString());
        

        c1= (new ClarionString(10)).setEncoding(ClarionString.CSTRING);
        TestUtil.testDeserialize("Hello\u0000    ",c1);
        assertEquals("Hello",c1.toString());

        c1= (new ClarionString(10)).setEncoding(ClarionString.CSTRING);
        TestUtil.testDeserialize("HelloWorld",c1);
        assertEquals("HelloWorl",c1.toString());
    }

    public void testDeserializeStringWithNotify() 
    {
        NV nv;
        ClarionString c1= new ClarionString(10);
        nv=addNV(c1);
        TestUtil.testDeserialize("Hello     ",c1);
        assertEquals("Hello     ",c1.toString());
        assertEquals("Hello     ",nv.toString());
        
        c1= (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        nv=addNV(c1);
        TestUtil.testDeserialize("\u0005Hello    ",c1);
        assertEquals("Hello",c1.toString());
        assertEquals("Hello",nv.toString());
        
        c1= (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello ");
        nv=addNV(c1);
        TestUtil.testDeserialize("\u0005Hello    ",c1);
        assertEquals("Hello",c1.toString());
        assertEquals("Hello",nv.toString());

        c1= (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        c1.setValue("Hello");
        nv=addNV(c1);
        TestUtil.testDeserialize("\u0005Hello    ",c1);
        assertEquals("Hello",c1.toString());
        assertNull(nv.toString());
        

        c1= (new ClarionString(10)).setEncoding(ClarionString.CSTRING);
        nv=addNV(c1);
        TestUtil.testDeserialize("Hello\u0000    ",c1);
        assertEquals("Hello",c1.toString());
        assertEquals("Hello",nv.toString());

        c1= (new ClarionString(10)).setEncoding(ClarionString.CSTRING);
        nv=addNV(c1);
        TestUtil.testDeserialize("HelloWorld",c1);
        assertEquals("HelloWorl",c1.toString());
        assertEquals("HelloWorl",nv.toString());
    }
    
    public void testIsNumeric() {
        
        assertTrue( (new ClarionString("1234.56")).isNumeric() );
        assertFalse( (new ClarionString("1,234.56")).isNumeric() );
        assertTrue( (new ClarionString("-1234.56")).isNumeric() );
        assertFalse( (new ClarionString("1234.56-")).isNumeric() );
        assertTrue( (new ClarionString("1")).isNumeric() );
        assertTrue( (new ClarionString("0")).isNumeric() );
        assertFalse( (new ClarionString("-")).isNumeric() );
        assertTrue( (new ClarionString("1.")).isNumeric() );
        assertTrue( (new ClarionString(".0")).isNumeric() );
        assertFalse( (new ClarionString(".")).isNumeric() );
        assertFalse( (new ClarionString("Zero")).isNumeric() );
    }

    public void testIsUpper() {
        assertTrue( (new ClarionString("A")).isUpper() );
        assertTrue( (new ClarionString("Za")).isUpper() );
        assertFalse( (new ClarionString("a")).isUpper() );
        assertFalse( (new ClarionString("")).isUpper() );
        assertFalse( (new ClarionString("aA")).isUpper() );
    }

    public void testIsAlpha() {
        assertTrue( (new ClarionString("A")).isAlpha() );
        assertTrue( (new ClarionString("Aa")).isAlpha() );
        assertTrue( (new ClarionString("a")).isAlpha() );
        assertFalse( (new ClarionString("")).isAlpha() );
        assertTrue( (new ClarionString("zA")).isAlpha() );
        assertFalse( (new ClarionString("1")).isAlpha() );
        assertFalse( (new ClarionString("1z")).isAlpha() );
    }

    public void testLeft() {
        ClarionString cs;
        
        cs = new ClarionString("   Hello");
        assertEquals("Hello   ",cs.left().toString());

        cs = new ClarionString("  Hello ");
        assertEquals("Hello   ",cs.left().toString());

        cs = (new ClarionString("   Hello")).setEncoding(ClarionString.PSTRING);
        assertEquals("Hello   ",cs.left().toString());

        cs = new ClarionString("Hello");
        assertEquals("Hello",cs.left().toString());

        cs = new ClarionString(" Hello");
        assertEquals("Hell",cs.left(4).toString());
    }

    public void testRight() {
        ClarionString cs;
        
        cs = new ClarionString("Hello   ");
        assertEquals("   Hello",cs.right().toString());

        cs = new ClarionString(" Hello  ");
        assertEquals("   Hello",cs.right().toString());

        cs = (new ClarionString("Hello")).setEncoding(ClarionString.PSTRING);
        assertEquals("Hello",cs.right().toString());

        cs = (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello");
        assertEquals("Hello",cs.right().toString());
        
        cs = (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello   ");
        assertEquals("   Hello",cs.right().toString());

        cs = (new ClarionString("Hello   ")).setEncoding(ClarionString.PSTRING);
        assertEquals("   Hello",cs.right().toString());

        cs = new ClarionString("Hello");
        assertEquals("Hello",cs.right().toString());

        cs = new ClarionString("Hello ");
        assertEquals("ello",cs.right(4).toString());
    }

    public void testCenter() {
        ClarionString cs;
        
        cs = new ClarionString("Hello   ");
        assertEquals("  Hello ",cs.center().toString());

        cs = new ClarionString(" Hello  ");
        assertEquals("  Hello ",cs.center().toString());

        cs = (new ClarionString("Hello")).setEncoding(ClarionString.PSTRING);
        assertEquals("Hello",cs.center().toString());

        cs = (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello");
        assertEquals("Hello",cs.center().toString());
        
        cs = (new ClarionString(10)).setEncoding(ClarionString.PSTRING);
        cs.setValue("Hello   ");
        assertEquals("  Hello ",cs.center().toString());

        cs = (new ClarionString("Hello   ")).setEncoding(ClarionString.PSTRING);
        assertEquals("  Hello ",cs.center().toString());

        cs = new ClarionString("Hello");
        assertEquals("Hello",cs.center().toString());

        cs = new ClarionString("Hello World");
        assertEquals("lo W",cs.center(4).toString());

        cs = new ClarionString("More Realistic Example");
        assertEquals("    More Realistic Example    ",cs.center(30).toString());
        assertEquals("    More Realistic Example   ",cs.center(29).toString());
        assertEquals("   More Realistic Example   ",cs.center(28).toString());
        assertEquals("   More Realistic Example  ",cs.center(27).toString());
        assertEquals("  More Realistic Example  ",cs.center(26).toString());
        assertEquals("  More Realistic Example ",cs.center(25).toString());
        assertEquals(" More Realistic Example ",cs.center(24).toString());
        assertEquals(" More Realistic Example",cs.center(23).toString());
        assertEquals("More Realistic Example",cs.center(22).toString());
        assertEquals("More Realistic Exampl",cs.center(21).toString());
        assertEquals("ore Realistic Exampl",cs.center(20).toString());
        assertEquals("ore Realistic Examp",cs.center(19).toString());
        assertEquals("re Realistic Examp",cs.center(18).toString());
        assertEquals("re Realistic Exam",cs.center(17).toString());
        assertEquals("e Realistic Exam",cs.center(16).toString());
        assertEquals("e Realistic Exa",cs.center(15).toString());
        assertEquals(" Realistic Exa",cs.center(14).toString());
        assertEquals(" Realistic Ex",cs.center(13).toString());
        assertEquals("Realistic Ex",cs.center(12).toString());
    }

    public void testUpper() {
        ClarionString cs;

        cs = new ClarionString("Hello   ");
        assertEquals("HELLO   ",cs.upper().toString());
    }

    public void testLower() {
        ClarionString cs;

        cs = new ClarionString("Hello   ");
        assertEquals("hello   ",cs.lower().toString());
    }

    public void testClip() {
        ClarionString cs;

        cs = new ClarionString("Hello   ");
        assertEquals("Hello",cs.clip().toString());

        cs = new ClarionString(" Hello   ");
        assertEquals(" Hello",cs.clip().toString());
    }

    public void testSetOverClarionMemoryModel() {
        ClarionString c1; 
        ClarionString c2; 
        
        c1 = new ClarionString("Hello   ");
        c2 = new ClarionString(8).setOver(c1);
        
        assertNotSame(c1,c2);
        
        assertEquals("Hello   ",c1.toString());
        assertEquals("Hello   ",c2.toString());
        
        c1.setValue("World");

        assertEquals("World   ",c1.toString());
        assertEquals("World   ",c2.toString());

        c2.setValue("World!");

        assertEquals("World!  ",c1.toString());
        assertEquals("World!  ",c2.toString());
     
        triggerGC();

        c1.setValue("World");

        assertEquals("World   ",c1.toString());
        assertEquals("World   ",c2.toString());

        c2.setValue("World!");

        assertEquals("World!  ",c1.toString());
        assertEquals("World!  ",c2.toString());
        
        c1=null;
        
        triggerGC();

        c2.setValue("World");
        assertEquals("World   ",c2.toString());
        
    }

    public void testSetOverClarionMemoryModel2() {
        ClarionString c1; 
        ClarionString c2; 
        
        c1 = new ClarionString("Hello   ");
        c2 = new ClarionString(8).setOver(c1);
        
        assertNotSame(c1,c2);
        
        assertEquals("Hello   ",c1.toString());
        assertEquals("Hello   ",c2.toString());
        
        c1.setValue("World");

        assertEquals("World   ",c1.toString());
        assertEquals("World   ",c2.toString());

        c2.setValue("World!");

        assertEquals("World!  ",c1.toString());
        assertEquals("World!  ",c2.toString());
     
        c2=null;
        
        triggerGC();

        c1.setValue("World");
        assertEquals("World   ",c1.toString());
        
    }

    public void testSetOverArray() {
        ClarionString c1=new ClarionString(20); 
        ClarionString c2[]=new ClarionString(2).dim(10);
        c2[1].setOver(c2,c1);

        assertEquals("                    ",c1.toString());
        for (int scan=1;scan<10;scan++) {
            assertEquals("  ",c2[scan].toString());
        }
        
        c1.setValue("xxxxxxxxxxxxxxxxxxxx");
        assertEquals("xxxxxxxxxxxxxxxxxxxx",c1.toString());
        for (int scan=1;scan<10;scan++) {
            assertEquals("xx",c2[scan].toString());
        }

        c1.setValue("0123456789abcdefghij");
        assertEquals("0123456789abcdefghij",c1.toString());
        testArray(c2,new String[] { null,"01","23","45","67","89","ab","cd","ef","gh","ij" } );
        
        c2[6].setValue("GRRAR!");

        assertEquals("0123456789GRcdefghij",c1.toString());
        testArray(c2,new String[] { null,"01","23","45","67","89","GR","cd","ef","gh","ij" } );

        c1.setValue("0123456789abcdefghij");
        assertEquals("0123456789abcdefghij",c1.toString());
        testArray(c2,new String[] { null,"01","23","45","67","89","ab","cd","ef","gh","ij" } );
        
        c2=null;
        triggerGC();
        
        c1.setValue("0123456789abcdefghij");
        assertEquals("0123456789abcdefghij",c1.toString());
    }
    
    private void testArray(ClarionObject bits[],String[] array) {
        for (int scan=1;scan<bits.length;scan++) {
            assertEquals(array[scan],bits[scan].toString());
        }
    }

    public void testAddClarionObject() {
        ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("10",cs.add(10).toString());

        cs= new ClarionString("5");
        assertEquals("15",cs.add(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("15.3",cs.add(10).toString());
    }

    public void testMultiplyClarionObject() {
        ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("0",cs.multiply(10).toString());

        cs= new ClarionString("5");
        assertEquals("50",cs.multiply(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("53.0",cs.multiply(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("50.403",cs.multiply("9.51").toString());
    }

    public void testSubtractClarionObject() {
        ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("-10",cs.subtract(10).toString());

        cs= new ClarionString("5");
        assertEquals("-5",cs.subtract(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("-4.7",cs.subtract(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("-4.21",cs.subtract("9.51").toString());
    }

    public void testDivideClarionObject() {
        ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("0",cs.divide(10).toString());

        cs= new ClarionString("5");
        assertEquals("0.5",cs.divide(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("0.53",cs.divide(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("0.5573080967402734",cs.divide("9.51").toString());
    }

    public void testNegate() {
        ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("0",cs.negate().toString());

        cs= new ClarionString("5");
        assertEquals("-5",cs.negate().toString());

        cs= new ClarionString("5.3");
        assertEquals("-5.3",cs.negate().toString());
    }

    public void testModulusClarionObject() {
      ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("0",cs.modulus(10).toString());

        cs= new ClarionString("5");
        assertEquals("5",cs.modulus(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("5.3",cs.modulus(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("1.1",cs.modulus("2.1").toString());
    }

    public void testPowerClarionObject() {
      ClarionString cs;
        
        cs= new ClarionString("hello");
        assertEquals("0",cs.power(10).toString());

        cs= new ClarionString("5");
        assertEquals("9765625",cs.power(10).toString());

        cs= new ClarionString("5.3");
        assertEquals("17488747.0365513049",cs.power(10).toString());

      }
    
    public void testGetNumber() {
        ClarionString cs;
          
          cs= new ClarionString("hello");
          assertEquals(0,cs.getNumber().intValue());

          cs= new ClarionString("5");
          assertEquals(5,cs.getNumber().intValue());

          cs= new ClarionString("-12345678");
          assertEquals(-12345678,cs.getNumber().intValue());
    }

    public void testGetBool() {
        ClarionString cs;
          
          cs= new ClarionString("hello");
          assertEquals(true,cs.getBool().boolValue());

          cs= new ClarionString("1");
          assertEquals(true,cs.getBool().boolValue());

          cs= new ClarionString("0");
          assertEquals(true,cs.getBool().boolValue());

          cs= new ClarionString("");
          assertEquals(false,cs.getBool().boolValue());
          
          cs= new ClarionString("     ");
          assertEquals(false,cs.getBool().boolValue());
    }

    public void testGetDecimal() {
        ClarionString cs;
          
          cs= new ClarionString("hello");
          assertEquals("0",cs.getDecimal().toString());

          cs= new ClarionString("1");
          assertEquals("1",cs.getDecimal().toString());

          cs= new ClarionString("0.000");
          assertEquals("0.000",cs.getDecimal().toString());

          cs= new ClarionString("1234.5678");
          assertEquals("1234.5678",cs.getDecimal().toString());

    }

    public void testAll()
    {
        ClarionString cs;
        cs = new ClarionString("xyz");
        
        assertEquals("xyz",cs.all(3).toString());
        assertEquals("xy",cs.all(2).toString());
        assertEquals("xyzx",cs.all(4).toString());
        assertEquals("xyzxyz",cs.all(6).toString());
        assertEquals(
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyzxyzxyzxyzxyzxyz"+
                "xyzxyzxyzxyzxyz"
                ,cs.all().toString());
    }

    public void testFormat() {
        
        ClarionString cs=  new ClarionString("12");
        assertEquals("    $12.00",cs.format("@n$10.2").toString());
    }

    public void testDeformat() {
        ClarionString cs=  new ClarionString("    $12.00");
        assertEquals("12",cs.deformat("@n$10.2").toString());
    }

    public void testSetOverUnboundedString()
    {
        ClarionString s1=  new ClarionString("This is a long one!");
        ClarionString s2=(new ClarionString()).setOver(s1);
        
        assertEquals("This is a long one!",s2.toString());
        
    }

    public void testSetOverMassiveUnboundedString()
    {
        ClarionString s1=  new ClarionString(60000);
        ClarionString s2=(new ClarionString()).setOver(s1);
        
        assertEquals(60000,s2.len());
        
    }

    public void testInString()
    {
        ClarionString s1=  new ClarionString("This is a long  one!");
         
        assertEquals(3,s1.inString("i"));
        assertEquals(6,s1.inString("i",1,4));
        assertEquals(0,s1.inString("i",1,7));
        assertEquals(1,s1.inString("This"));
        assertEquals(11,s1.inString("long",1,1));
        assertEquals(0,s1.inString("long"));
        assertEquals(3,s1.inString("is",1,1));
        assertEquals(3,s1.inString("is"));
        assertEquals(12,s1.inString("on",1,1));
        assertEquals(17,s1.inString("on"));
        assertEquals(20,s1.inString("!"));
        assertEquals(17,s1.inString("one!",1,1));
    }

    public void testAppendZerosToCStringDoesNotChangeLength()
    {
        ClarionString cs = (new ClarionString(20)).setEncoding(ClarionString.CSTRING);
        
        cs.setValue("12345\u00006789");
        assertEquals("12345",cs.toString());
        assertEquals(5,cs.len());
        
        cs.setStringAt(6,"\u0000");
        assertEquals("12345",cs.toString());
        assertEquals(5,cs.len());

        cs.setStringAt(6,"6");
        assertEquals("123456",cs.toString());
        assertEquals(6,cs.len());

        cs.setStringAt(7,"\u0000");
        assertEquals("123456",cs.toString());
        assertEquals(6,cs.len());
    }
    
    /*
    public void testGetReal() {
        fail("Not yet implemented");
    }


    public void testSetNull() {
        fail("Not yet implemented");
    }

     */
    
    private void triggerGC()
    {
        System.gc();
        Thread.yield();
        try {
            Thread.sleep(50);
        } catch (InterruptedException ex) { }
    }
    

    public void testMatch()
    {
        ClarionString cs;
        
        cs=new ClarionString("andrew.barnham@sourforge.net");
        assertTrue(cs.match("^[-A-Z0-9._]+@{[-A-Z0-9._]+.}+[A-Z][A-Z][A-Z]?[A-Z]?$",Match.REGULAR+Match.NOCASE));
        cs=new ClarionString("Some junk");
        assertFalse(cs.match("^[-A-Z0-9._]+@{[-A-Z0-9._]+.}+[A-Z][A-Z][A-Z]?[A-Z]?$",Match.REGULAR+Match.NOCASE));

        cs=new ClarionString("Richard");
        assertTrue(cs.match("RICHARD",Match.SIMPLE+Match.NOCASE));
        assertFalse(cs.match("RICHARD",Match.SIMPLE));

        assertTrue(cs.match("R*",Match.WILD+Match.NOCASE));
        assertTrue(cs.match("R*",Match.WILD));
        assertFalse(cs.match("r*",Match.WILD));
        assertTrue(cs.match("r*",Match.WILD+Match.NOCASE));
        assertFalse(cs.match("i*",Match.WILD+Match.NOCASE));
        assertTrue(cs.match("?i*",Match.WILD+Match.NOCASE));
        assertTrue(cs.match("*i*",Match.WILD+Match.NOCASE));

        cs=new ClarionString("Fireworks on the fourth");
        assertTrue(cs.match("{4|four}th",Match.REGULAR+Match.NOCASE));
        cs=new ClarionString("July 4th fireworks");
        assertTrue(cs.match("{4|four}th",Match.REGULAR+Match.NOCASE));

        for (String test : new String[] { "Tom  ", "Thom ", "Thomas   ", "Tommy " } ) {
            cs=new ClarionString(test);
            assertTrue(cs.match("^Th?om{as|my}?{ }+",Match.REGULAR+Match.NOCASE));
        }
    }
    
    public void testStrpos()
    {
        ClarionString list1=new ClarionString("IN,OH,KY,TN,PA");
        ClarionString list2=new ClarionString("WI,MN,IA,SD,ND");
        ClarionString wanted=new ClarionString("NJ|NY|PA|DE");
        
        assertEquals(13,list1.strpos(wanted.toString()));
        assertEquals(0,list2.strpos(wanted.toString()));
        
        ClarionString test = new ClarionString("Fireworks on the fourth");
        assertEquals(18,test.strpos("{4|Four}th",true));
        assertEquals(0,test.strpos("{4|Four}th",false));

        test = new ClarionString("July 4th fireworks");
        assertEquals(6,test.strpos("{4|Four}th",true));
        assertEquals(6,test.strpos("{4|Four}th",false));
    }
    
    public void testQuote()
    {
        quoteAssert("A","A",false);
        quoteAssert("A","A",true);
        quoteAssert("<250>","<250>",false);
        quoteAssert("\u00fa","<250>",true);
        quoteAssert("<<250","<250",false);
        quoteAssert("<250","<250",true);
        quoteAssert("<<display text>","<display text>",false);
        quoteAssert("<display text>","<display text>",true);

        quoteAssert("label{{prop:text}","label{prop:text}",false);
        quoteAssert("label{prop:text}","label{prop:text}",true);
        quoteAssert("don''t understand quote","don't understand quote",false);
        quoteAssert("don''t understand quote","don't understand quote",true);
    }

    private void quoteAssert(String output, String test,boolean mode) {
        assertEquals(output,Clarion.newString(test).quote(mode));
    }
    
    public void testUnquote()
    {
        unquoteAssert("abc","abc");
        unquoteAssert("<display text>","<display text>");
        unquoteAssert("<display text>>","<<display text>>");
        unquoteAssert(" ' ' '{ '< < < <' <{ { { {' {<"," ' '' '{ '< < << <' <{ { {{ {' {<");
    }

    private void unquoteAssert(String output,String test) {
        assertEquals(output,Clarion.newString(test).unquote());
    }
    
}
