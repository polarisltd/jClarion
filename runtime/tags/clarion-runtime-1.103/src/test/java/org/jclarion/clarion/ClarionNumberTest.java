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
import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.runtime.CDate;

import junit.framework.TestCase;

public class ClarionNumberTest extends TestCase 
{
    private ThreadHelper helper;
    
    public void tearDown()
    {
        if (helper!=null) {
            helper.tearDown();
            helper=null;
        }
    }
    
    public void testConstruct()
    {
        ClarionNumber n;
        
        n=new ClarionNumber();
        assertEquals("0",n.toString());
        assertEquals(0,n.intValue());

        n=new ClarionNumber(12);
        assertEquals("12",n.toString());
        assertEquals(12,n.intValue());
        
        n=new ClarionNumber("-125");
        assertEquals("-125",n.toString());
        assertEquals(-125,n.intValue());
    }
    
    public void testSetValueOverflows32BitRange()
    {
        ClarionNumber n = new ClarionNumber();
        n.setValue(2);
        assertEquals(2,n.intValue());
        n.setValue("3000000000");
        assertEquals(0,n.intValue());
        n.setValue("300000000");
        assertEquals(300000000,n.intValue());
    }
    
    public void testSetValue()
    {
        ClarionNumber n;
        n=new ClarionNumber();
        
        n.setValue(-123);
        assertEquals(-123,n.intValue());

        n.setValue("2000");
        assertEquals(2000,n.intValue());

        n.setValue("2001.10");
        assertEquals(2001,n.intValue());
    }

    
    public void testCompareToBounds()
    {
    	doTestCTB(-2147483647,2147483647);
    	doTestCTB(-2147483647,100);
    	doTestCTB(-100,100);
    	doTestCTB(100,2147483647);
    }
    
    private void doTestCTB(int s,int l)
    {
    	assertTrue(Clarion.newNumber(s).compareTo(Clarion.newNumber(l))<0);
    	assertTrue(Clarion.newNumber(l).compareTo(Clarion.newNumber(s))>0);
    }
    
    public void testCompareTo()
    {
        ClarionNumber n;
        n = new ClarionNumber(10);
        
        assertTrue(n.compareTo(10)==0);
        assertTrue(n.compareTo(9)>0);
        assertTrue(n.compareTo(11)<0);

        assertTrue(n.compareTo(new ClarionNumber(10))==0);
        assertTrue(n.compareTo(new ClarionNumber(9))>0);
        assertTrue(n.compareTo(new ClarionNumber(11))<0);
        
        // numeric compares

        assertTrue(n.compareTo("9")>0);
        assertTrue(n.compareTo("10")==0);
        assertTrue(n.compareTo("11")<0);
        assertTrue(n.compareTo("1")>0);
    }

    public void testClearDate() {
        ClarionNumber n = new ClarionNumber();
        n.setEncoding(ClarionNumber.DATE);
        n.clear();
        assertEquals(0,n.intValue());
        n.clear(0);
        assertEquals(0,n.intValue());
        n.clear(1);
        assertEquals(2994626,n.intValue());
        assertEquals(CDate.date(12,31,9999),n.intValue());
        n.clear(-1);
        assertEquals(0,n.intValue());
    }

    public void testClearTime() {
        ClarionNumber n = new ClarionNumber();
        n.setEncoding(ClarionNumber.TIME);
        n.clear();
        assertEquals(0,n.intValue());
        n.clear(0);
        assertEquals(0,n.intValue());
        n.clear(1);
        assertEquals(24*60*60*100,n.intValue());
        n.clear(-1);
        assertEquals(0,n.intValue());
    }
    
    public void testClear() {
        ClarionNumber n = new ClarionNumber();

        n.clear();
        assertEquals(0,n.intValue());
        n.clear(0);
        assertEquals(0,n.intValue());
        n.clear(1);
        assertEquals(2147483647,n.intValue());
        n.clear(-1);
        assertEquals(-2147483648,n.intValue());
    }
    
    public void testClearBasedOnEncodingType()
    {
    	assertClear(-1,ClarionNumber.BYTE,0);
    	assertClear(1,ClarionNumber.BYTE,255);
    	assertClear(-1,ClarionNumber.LONG,-2147483648);
    	assertClear(1,ClarionNumber.LONG,2147483647);
    	assertClear(-1,ClarionNumber.SHORT,-32768);
    	assertClear(1,ClarionNumber.SHORT,32767);
    	assertClear(-1,ClarionNumber.SIGNED,-2147483648);
    	assertClear(1,ClarionNumber.SIGNED,2147483647);
    	assertClear(-1,ClarionNumber.ULONG,0);
    	assertClear(1,ClarionNumber.ULONG,2147483647);
    	assertClear(-1,ClarionNumber.UNSIGNED,0);
    	assertClear(1,ClarionNumber.UNSIGNED,2147483647);
    	assertClear(-1,ClarionNumber.USHORT,0);
    	assertClear(1,ClarionNumber.USHORT,65535);
    }
    
    private void assertClear(int clear,int encoding,int result)
    {
    	ClarionNumber cn = new ClarionNumber();
    	cn.setEncoding(encoding);
    	cn.clear(clear);
    	assertEquals(result,cn.intValue());
    }
    
    public void testBoolValue()
    {
        ClarionNumber n = new ClarionNumber();
        
        assertFalse(n.boolValue());

        n.setValue(0);
        assertFalse(n.boolValue());

        n.setValue(1);
        assertTrue(n.boolValue());

        n.setValue(10);
        assertTrue(n.boolValue());

        n.setValue(-1);
        assertTrue(n.boolValue());

        n.setValue(-10);
        assertTrue(n.boolValue());
    }

    public void testAdd()
    {
        ClarionNumber n = new ClarionNumber(4);
        
        assertEquals(10,n.add(6).intValue());

        assertEquals(-2,n.add("-6").intValue());
    }

    public void testSubtract()
    {
        ClarionNumber n = new ClarionNumber(4);
        
        assertEquals(-2,n.subtract(6).intValue());

        assertEquals(10,n.subtract("-6").intValue());
    }

    public void testMultiply()
    {
        ClarionNumber n = new ClarionNumber(4);
        
        assertEquals(24,n.multiply(6).intValue());

        assertEquals(-24,n.multiply("-6").intValue());
    }
    
    public void testDivide()
    {
        ClarionNumber n = new ClarionNumber(100);
        
        assertEquals(25,n.divide(4).intValue());

        assertEquals(-25,n.divide("-4").intValue());
    }

    public void testDivideYieldsFraction()
    {
        ClarionNumber n = new ClarionNumber(100);
        
        assertEquals("12.5",n.divide(8).toString());
    }

    public void testDivideByZeroIsOk()
    {
        ClarionNumber n = new ClarionNumber(100);
        assertEquals("0",n.divide(0).toString());
    }

    public void testDivideByZeroAsDecimalIsOk()
    {
        ClarionNumber n = new ClarionNumber(100);
        assertEquals("0",n.divide("0.0").toString());
    }

    public void testDivideBySomethindNotQuiteZero()
    {
        ClarionNumber n = new ClarionNumber(100);
        assertEquals("1000",n.divide("0.1").toString());
    }
    
    public void testDivideDecimal()
    {
        ClarionNumber n = new ClarionNumber(100);
        
        assertEquals("-40",n.divide(new ClarionDecimal("-2.5")).toString());

    }

    public void testNegate()
    {
        ClarionNumber n = new ClarionNumber(100);
        
        assertEquals(-100,n.negate().intValue());

        assertEquals(100,n.negate().negate().intValue());
    }

    public void testModulus()
    {
        ClarionNumber n = new ClarionNumber(101);
        
        assertEquals(1,n.modulus(4).intValue());

        assertEquals(1,n.modulus("-4").intValue());
    }

    public void testPower()
    {
        ClarionNumber n = new ClarionNumber(6);
        
        assertEquals(1296,n.power(4).intValue());

        assertEquals(7776,n.power("5").intValue());
    }
    
    public void testGetString()
    {
        ClarionNumber n = new ClarionNumber(12386532);
        assertEquals("12386532",n.getString().toString());
    }

    public void testGetNumber()
    {
        ClarionNumber n = new ClarionNumber(12386532);
        assertSame(n,n.getNumber());
    }

    public void testLike() {
        ClarionNumber n = new ClarionNumber(12386532);
        ClarionNumber c = n.like();
        
        assertNotSame(c,n);
        
        assertEquals(12386532,c.intValue());

        TestUtil.testDeserialize(c,(byte)0,(byte)0xbd,(byte)0x00,(byte)0xe4);
        
        n = (new ClarionNumber(60000)).setEncoding(ClarionNumber.USHORT);
        c = n.like();
        assertNotSame(c,n);
        assertEquals(60000,c.intValue());

        TestUtil.testDeserialize(c,(byte)0xea,(byte)0x60);
    }
    
    public void testDimInt() {
        
        ClarionArray<ClarionNumber> l = (new ClarionNumber(20)).dim(5);
        
        for (int scan=1;scan<6;scan++) {
            assertEquals(20,l.get(scan).intValue());
        }
    }

    public void testDimInt2() {
        
        ClarionArray<ClarionArray<ClarionNumber>> l = (new ClarionNumber(20)).dim(6).dim(5);
        
        for (int s1=1;s1<=5;s1++) {
            for (int s2=1;s2<=6;s2++) {
                assertEquals(20,l.get(s1).get(s2).intValue());
            }
        }
    }

    public void testDimInt3() {
        
    	ClarionArray<ClarionArray<ClarionArray<ClarionNumber>>> l = 
    		(new ClarionNumber(20)).dim(4).dim(5).dim(6);
        
        for (int s1=1;s1<=6;s1++) {
            for (int s2=1;s2<=5;s2++) {
                for (int s3=1;s2<=4;s2++) {
                    assertEquals(20,l.get(s1).get(s2).get(s3).intValue());
                }
            }
        }
    }

    public void testSetName() {
        ClarionNumber l = (new ClarionNumber(20)).setName("externalname");
        assertEquals("externalname",l.getName());
    }

    public void testShift() {
        assertEquals(32,ClarionNumber.shift(4,3));
        assertEquals(2,ClarionNumber.shift(4,-1));
    }

    public void testAbs() {
        assertEquals(32,(new ClarionNumber(32)).abs().intValue());
        assertEquals(32,(new ClarionNumber(-32)).abs().intValue());
    }
    
    public void testSerialize()
    {
        ClarionNumber n;
        
        n= new ClarionNumber(10);
        TestUtil.testSerialize(n,(byte)10,(byte)0,(byte)0,(byte)0);

        n= new ClarionNumber(123456789);
        //TestUtil.testSerialize(n,(byte)0x07,(byte)0x5b,(byte)0xcd,(byte)0x15);
        TestUtil.testSerialize(n,(byte)0x15,(byte)0xcd,(byte)0x5b,(byte)0x07);

        n= (new ClarionNumber(123456789)).setEncoding(ClarionNumber.BYTE);
        TestUtil.testSerialize(n,(byte)0x15);

        n= (new ClarionNumber(123456789)).setEncoding(ClarionNumber.SIGNED);
        //TestUtil.testSerialize(n,(byte)0x07,(byte)0x5b,(byte)0xcd,(byte)0x15);
        TestUtil.testSerialize(n,(byte)0x15,(byte)0xcd,(byte)0x5b,(byte)0x07);

        n= (new ClarionNumber(123456789)).setEncoding(ClarionNumber.UNSIGNED);
        //TestUtil.testSerialize(n,(byte)0x07,(byte)0x5b,(byte)0xcd,(byte)0x15);
        TestUtil.testSerialize(n,(byte)0x15,(byte)0xcd,(byte)0x5b,(byte)0x07);

        n= (new ClarionNumber(123456789)).setEncoding(ClarionNumber.ULONG);
        //TestUtil.testSerialize(n,(byte)0x07,(byte)0x5b,(byte)0xcd,(byte)0x15);
        TestUtil.testSerialize(n,(byte)0x15,(byte)0xcd,(byte)0x5b,(byte)0x07);

        n= (new ClarionNumber(123456789)).setEncoding(ClarionNumber.USHORT);
        TestUtil.testSerialize(n,(byte)0x15,(byte)0xcd);

        n= (new ClarionNumber(123456789)).setEncoding(ClarionNumber.SHORT);
        TestUtil.testSerialize(n,(byte)0x15,(byte)0xcd);

    }
    
    private void doTestBackAndForward(int encoding,int from,int to)
    {
        ClarionNumber n;
        n= (new ClarionNumber(from)).setEncoding(encoding);
        ClarionNumber o;
        o= (new ClarionNumber()).setEncoding(encoding);
        
		CMem baos = CMem.create();
		n.serialize(baos);
		o.deserialize(baos);
		assertEquals(0, baos.remaining());
        
        assertEquals(to,o.intValue());
        
    }
    
    public void testDeserialize()
    {
        ClarionNumber n;
        
        n= new ClarionNumber(10);
        TestUtil.testDeserialize(n,(byte)10,(byte)0,(byte)0,(byte)0);
        assertEquals(10,n.getNumber().intValue());

        n= new ClarionNumber();
        //TestUtil.testDeserialize(n,(byte)0x07,(byte)0x5b,(byte)0xcd,(byte)0x15);
        TestUtil.testDeserialize(n,(byte)0x15,(byte)0xcd,(byte)0x5b,(byte)0x07);
        assertEquals(123456789,n.getNumber().intValue());

        doTestBackAndForward(ClarionNumber.BYTE,0,0);
        doTestBackAndForward(ClarionNumber.BYTE,1,1);
        doTestBackAndForward(ClarionNumber.BYTE,-1,255);
        doTestBackAndForward(ClarionNumber.BYTE,255,255);

        doTestBackAndForward(ClarionNumber.SIGNED,0,0);
        doTestBackAndForward(ClarionNumber.SIGNED,1,1);
        doTestBackAndForward(ClarionNumber.SIGNED,-1,-1);
        doTestBackAndForward(ClarionNumber.SIGNED,123456789,123456789);
        doTestBackAndForward(ClarionNumber.SIGNED,2000000000,2000000000);
        doTestBackAndForward(ClarionNumber.SIGNED,-2000000000,-2000000000);

        doTestBackAndForward(ClarionNumber.UNSIGNED,0,0);
        doTestBackAndForward(ClarionNumber.UNSIGNED,1,1);
        doTestBackAndForward(ClarionNumber.UNSIGNED,-1,-1);
        doTestBackAndForward(ClarionNumber.UNSIGNED,123456789,123456789);
        doTestBackAndForward(ClarionNumber.UNSIGNED,2000000000,2000000000);
        doTestBackAndForward(ClarionNumber.UNSIGNED,-2000000000,-2000000000);

        doTestBackAndForward(ClarionNumber.ULONG,0,0);
        doTestBackAndForward(ClarionNumber.ULONG,1,1);
        doTestBackAndForward(ClarionNumber.ULONG,-1,-1);
        doTestBackAndForward(ClarionNumber.ULONG,123456789,123456789);
        doTestBackAndForward(ClarionNumber.ULONG,2000000000,2000000000);
        doTestBackAndForward(ClarionNumber.ULONG,-2000000000,-2000000000);

        doTestBackAndForward(ClarionNumber.USHORT,0,0);
        doTestBackAndForward(ClarionNumber.USHORT,1,1);
        doTestBackAndForward(ClarionNumber.USHORT,-1,65535);
        doTestBackAndForward(ClarionNumber.USHORT,40000,40000);

        doTestBackAndForward(ClarionNumber.SHORT,0,0);
        doTestBackAndForward(ClarionNumber.SHORT,1,1);
        doTestBackAndForward(ClarionNumber.SHORT,-1,-1);
        doTestBackAndForward(ClarionNumber.SHORT,32000,32000);
        doTestBackAndForward(ClarionNumber.SHORT,-32000,-32000);
        
    }
    
    public void testGetBool() {
        ClarionNumber n;
        
        n= new ClarionNumber(10);
        assertEquals(true,n.getBool().boolValue());
        
        n= new ClarionNumber(0);
        assertEquals(false,n.getBool().boolValue());
    }

    public void testGetDecimal() {
        ClarionNumber n;
        
        n= new ClarionNumber(10);
        assertEquals("10",n.getDecimal().toString());
        
        n= new ClarionNumber(0);
        assertEquals("0",n.getDecimal().toString());

        n= new ClarionNumber(-12345678);
        assertEquals("-12345678",n.getDecimal().toString());
    }

    public void testSetOver() {
        ClarionNumber n=new ClarionNumber(10);
        ClarionNumber o=(new ClarionNumber()).setOver(n);
        
        assertEquals(10,n.intValue());
        assertEquals(10,o.intValue());
        
        n.setValue(1);

        assertEquals(1,n.intValue());
        assertEquals(1,o.intValue());

        o.setValue(-20);

        assertEquals(-20,n.intValue());
        assertEquals(-20,o.intValue());

        o.setValue(0x7fffffff);

        assertEquals(0x7fffffff,n.intValue());
        assertEquals(0x7fffffff,o.intValue());
        
        ClarionString s = (new ClarionString(4)).setOver(o);
        assertEquals("\u00ff\u00ff\u00ff\u007f",s.toString());
        
        n.setValue(0x50);
        
        assertEquals(0x50,n.intValue());
        assertEquals(0x50,o.intValue());
        assertEquals("\u0050\u0000\u0000\u0000",s.toString());
        
        s.setValue("hello");
        assertEquals("hell",s.toString());
        assertEquals(0x6c6c6568,n.intValue());
        assertEquals(0x6c6c6568,o.intValue());
    }

    /**

    public void testGetReal() {
        fail("Not yet implemented");
    }
    **/

    public void testNotThreadedNumber()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionNumber s = new ClarionNumber(0);
        
        final int[] r=new int[1];
        
        s.setValue(5);
        assertEquals(5,s.intValue());
        
        s.increment(2);
        assertEquals(7,s.intValue());
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue(-4);
                r[0]=s.intValue();
            } } ,5000);

        assertEquals(-4,s.intValue());
        assertEquals(-4,r[0]);
    }

    public void testThreadedNumber()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionNumber s = (new ClarionNumber(0)).setThread();
        
        final int[] r=new int[1];
        
        s.setValue(5);
        assertEquals(5,s.intValue());
        
        s.increment(2);
        assertEquals(7,s.intValue());
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue(-4);
                r[0]=s.intValue();
            } } ,5000);

        assertEquals(7,s.intValue());
        assertEquals(-4,r[0]);
    }
    
}
