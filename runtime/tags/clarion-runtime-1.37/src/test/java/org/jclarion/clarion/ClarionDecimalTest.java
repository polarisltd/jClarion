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

import junit.framework.TestCase;

public class ClarionDecimalTest extends TestCase {
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
        ClarionDecimal c=new ClarionDecimal();
        assertEquals("0",c.toString());

        c=new ClarionDecimal(10);
        assertEquals("10",c.toString());

        c=new ClarionDecimal(10,2);
        assertEquals("0.00",c.toString());

        c=new ClarionDecimal(10,2,"13.5");
        assertEquals("13.50",c.toString());

        c=new ClarionDecimal(10,2,"crap");
        assertEquals("0.00",c.toString());

        c=new ClarionDecimal("-13.5");
        assertEquals("-13.5",c.toString());

        c=new ClarionDecimal("crap");
        assertEquals("0",c.toString());
    }

    public void testSerialize() {
        ClarionDecimal c;
        
        c=new ClarionDecimal(10,2,"13.5");
        TestUtil.testSerialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x13,(byte)0x50);

        c=new ClarionDecimal(10,2,"-13.5");
        TestUtil.testSerialize(c,(byte)0x80,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x13,(byte)0x50);

        c=(new ClarionDecimal(10,2,"13.52")).setEncoding(ClarionDecimal.PDECIMAL);
        TestUtil.testSerialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x01,(byte)0x35,(byte)0x2c);

        c=(new ClarionDecimal(10,2,"-13.52")).setEncoding(ClarionDecimal.PDECIMAL);
        TestUtil.testSerialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x01,(byte)0x35,(byte)0x2d);

        c=new ClarionDecimal(10,2,"12345612.34");
        TestUtil.testSerialize(c,(byte)0x00,(byte)0x12,(byte)0x34,(byte)0x56,(byte)0x12,(byte)0x34);

        c=new ClarionDecimal(11,2,"912345612.34");
        TestUtil.testSerialize(c,(byte)0x09,(byte)0x12,(byte)0x34,(byte)0x56,(byte)0x12,(byte)0x34);
    }

    public void testDeerialize() {
        ClarionDecimal c;
        
        c=new ClarionDecimal(10,2);
        TestUtil.testDeserialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x13,(byte)0x50);
        assertEquals("13.50",c.toString());

        c=new ClarionDecimal(10,2);
        TestUtil.testDeserialize(c,(byte)0x80,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x13,(byte)0x50);
        assertEquals("-13.50",c.toString());

        c=(new ClarionDecimal(10,2)).setEncoding(ClarionDecimal.PDECIMAL);
        TestUtil.testDeserialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x01,(byte)0x35,(byte)0x2c);
        assertEquals("13.52",c.toString());

        c=(new ClarionDecimal(10,2)).setEncoding(ClarionDecimal.PDECIMAL);
        TestUtil.testDeserialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x01,(byte)0x35,(byte)0x2d);
        assertEquals("-13.52",c.toString());

        c=new ClarionDecimal(10,2);
        TestUtil.testDeserialize(c,(byte)0x00,(byte)0x12,(byte)0x34,(byte)0x56,(byte)0x12,(byte)0x34);
        assertEquals("12345612.34",c.toString());

        c=new ClarionDecimal(11,2);
        TestUtil.testDeserialize(c,(byte)0x09,(byte)0x12,(byte)0x34,(byte)0x56,(byte)0x12,(byte)0x34);
        assertEquals("912345612.34",c.toString());
    }

    public void testSetValue()
    {
        ClarionDecimal cd = new ClarionDecimal();
        
        cd.setValue("100.2321");
        assertEquals("100.2321",cd.toString());

        cd.setValue(-10);
        assertEquals("-10",cd.toString());

        cd.setValue(new ClarionString("100.231"));
        assertEquals("100.231",cd.toString());
    }
    
    public void testSetValueRounding()
    {
        ClarionDecimal cd = new ClarionDecimal(10,2);
        cd.setValue("12.345");
        assertEquals("12.35",cd.toString());

        cd.setValue("12.344");
        assertEquals("12.34",cd.toString());
    }

    public void testSetValueExceedPrecision()
    {
        ClarionDecimal cd = new ClarionDecimal(7,2);
        cd.setValue("123456.78");
        assertEquals("99999.99",cd.toString());
        cd.setValue("-123456.78");
        assertEquals("-99999.99",cd.toString());
    }
    public void testClear()
    {
        ClarionDecimal cd = new ClarionDecimal(10,2);
        
        cd.clear();
        assertEquals("0.00",cd.toString());

        cd.clear(0);
        assertEquals("0.00",cd.toString());

        cd.clear(-1);
        assertEquals("-99999999.99",cd.toString());

        cd.clear(1);
        assertEquals("99999999.99",cd.toString());
    }

    public void testIntValue()
    {
        ClarionDecimal cd = new ClarionDecimal(10,2,"100.2");
        
        assertEquals(100,cd.intValue());
        
        cd.setValue("-12");
        assertEquals(-12,cd.intValue());
    }
    
    public void testBigIntValue()
    {
        ClarionDecimal cd = new ClarionDecimal(15,2,"3000000000");
        
        assertEquals(0,cd.intValue());
        
        cd.setValue("-12");
        assertEquals(-12,cd.intValue());

        cd.setValue("300000000");
        assertEquals(300000000,cd.intValue());

        cd.setValue("-300000000");
        assertEquals(-300000000,cd.intValue());

        cd.setValue("2147483647");
        assertEquals(2147483647,cd.intValue());

        cd.setValue("2147483648");
        assertEquals(0,cd.intValue());

        cd.setValue("-2147483648");
        assertEquals(-2147483648,cd.intValue());

        cd.setValue("-2147483647");
        assertEquals(-2147483647,cd.intValue());

        cd.setValue("-2147483649");
        assertEquals(0,cd.intValue());
    }

    public void testBoolValue()
    {
        ClarionDecimal cd = new ClarionDecimal(10,2,"100.2");
        
        assertTrue(cd.boolValue());
        
        cd.setValue("-12");
        assertTrue(cd.boolValue());

        cd.setValue("0");
        assertFalse(cd.boolValue());

        cd.setValue("0.000");
        assertFalse(cd.boolValue());

        cd.setValue("0.01");
        assertTrue(cd.boolValue());

        cd.setValue("-0.01");
        assertTrue(cd.boolValue());

        cd.setValue("-0.001");
        assertFalse(cd.boolValue());
    }
    
    public void testAdd()
    {
        assertEquals("10.2",Clarion.newDecimal("10").add(Clarion.newDecimal("0.2")).toString());

        assertEquals("10.2",Clarion.newDecimal("10").add("0.2").toString());

        assertEquals("10.2",Clarion.newDecimal(".2").add(10).toString());

        assertEquals("10.2000",Clarion.newDecimal(8,4,".2").add(10).toString());
    }

    public void testSubtract()
    {
        assertEquals("9.8",Clarion.newDecimal("10").subtract(Clarion.newDecimal("0.2")).toString());

        assertEquals("9.8",Clarion.newDecimal("10").subtract("0.2").toString());

        assertEquals("-9.8",Clarion.newDecimal(".2").subtract(10).toString());

        assertEquals("-9.8000",Clarion.newDecimal(8,4,".2").subtract(10).toString());
    }

    public void testMultiply()
    {
        assertEquals("2.12",Clarion.newDecimal("10.6").multiply(Clarion.newDecimal("0.2")).toString());

        assertEquals("2.12",Clarion.newDecimal("10.6").multiply("0.2").toString());

        assertEquals("2.0",Clarion.newDecimal(".2").multiply(10).toString());

        assertEquals("2.12000",Clarion.newDecimal(8,4,".2").multiply("10.6").toString());
    }

    public void testDivide()
    {
        assertEquals("7.571428571428571",Clarion.newDecimal("10.6").divide(Clarion.newDecimal("1.4")).toString());

        assertEquals("7.571428571428571",Clarion.newDecimal("10.6").divide("1.4").toString());

        assertEquals("0.02",Clarion.newDecimal(".2").divide(10).toString());

        assertEquals("0.01886792452830189",Clarion.newDecimal(8,4,".2").divide("10.6").toString());

        assertEquals("3.333333333333333",Clarion.newDecimal(8,4,"10").divide("3").toString());
    }

    public void testModulus()
    {
        assertEquals("0.8",Clarion.newDecimal("10.6").modulus(Clarion.newDecimal("1.4")).toString());

        assertEquals("0.8",Clarion.newDecimal("10.6").modulus("1.4").toString());

        assertEquals("0.2",Clarion.newDecimal(".2").modulus(10).toString());

        assertEquals("0.2000",Clarion.newDecimal(8,4,".2").modulus("10.6").toString());

        assertEquals("1.0000",Clarion.newDecimal(8,4,"10").modulus("3").toString());
    }

    public void testPower()
    {
        assertEquals("14.706125000",Clarion.newDecimal(8,3,"2.45").power(3).toString());
    }

    public void testNegate()
    {
        assertEquals("-2.450",Clarion.newDecimal(8,3,"2.45").negate().toString());
    }

    public void testCompareTo()
    {
        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo(new ClarionDecimal("2.450"))==0);

        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo(new ClarionDecimal("2"))>0);
        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo(new ClarionDecimal("3"))<0);
        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo(2)>0);
        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo(3)<0);
        assertTrue(Clarion.newNumber(2).compareTo(Clarion.newDecimal(8,3,"2.45"))<0);
        assertTrue(Clarion.newNumber(3).compareTo(Clarion.newDecimal(8,3,"2.45"))>0);

        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo("2.450")==0);
        assertTrue(Clarion.newDecimal(8,3,"2.45").compareTo("2.45")==0);
    }
    
    public void testEquals()
    {
        assertTrue(Clarion.newDecimal(8,3,"2.45").equals(new ClarionDecimal("2.450")));

        assertFalse(Clarion.newDecimal(8,3,"2.45").equals(new ClarionDecimal("2")));
        assertFalse(Clarion.newDecimal(8,3,"2.45").equals(new ClarionDecimal("3")));
        assertFalse(Clarion.newDecimal(8,3,"2.45").equals(2));
        assertFalse(Clarion.newDecimal(8,3,"2.45").equals(3));
        assertFalse(Clarion.newNumber(2).equals(Clarion.newDecimal(8,3,"2.45")));
        assertFalse(Clarion.newNumber(3).equals(Clarion.newDecimal(8,3,"2.45")));

        assertTrue(Clarion.newDecimal(8,3,"2.45").equals("2.450"));
        assertTrue(Clarion.newDecimal(8,3,"2.45").equals("2.45"));
    }

    public void testGetString() {
        ClarionDecimal n = new ClarionDecimal(8,4,"-3.141");
        
        assertEquals("-3.1410",n.getString().toString());
    }

    public void testGetNumber() {
        ClarionDecimal n = new ClarionDecimal(8,4,"-3.141");
        
        assertEquals(-3,n.getNumber().intValue());
    }

    public void testGetDecimal() {
        ClarionDecimal n = new ClarionDecimal(8,4,"-3.141");
        
        assertSame(n,n.getDecimal());
    }
    
    public void testLike()
    {
        ClarionDecimal c=(new ClarionDecimal(10,2,"-13.52")).setEncoding(ClarionDecimal.PDECIMAL);
        
        ClarionDecimal n =c.like();
        assertNotSame(c,n);
        assertTrue(n.equals(c));
        assertTrue(c.equals(n));
        
        TestUtil.testSerialize(c,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x01,(byte)0x35,(byte)0x2d);
        TestUtil.testSerialize(n,(byte)0x00,(byte)0x00,(byte)0x00,(byte)0x01,(byte)0x35,(byte)0x2d);
    }

    public void testDimInt() {
        
        ClarionDecimal l[] = (new ClarionDecimal(10,2,"123235.3435")).dim(5);
        
        assertEquals(6,l.length);
        assertNull(l[0]);
        for (int scan=1;scan<6;scan++) {
            assertEquals("123235.34",l[scan].toString());
        }
    }

    public void testDimInt2() {
        
        ClarionDecimal l[][] = (new ClarionDecimal(10,2,"-13.456")).dim(5,6);
        
        assertEquals(6,l.length);
        for (int s2=1;s2<=6;s2++) {
            assertNull(l[0][s2]);
        }
        
        for (int s1=1;s1<=5;s1++) {
            assertNull(l[s1][0]);
            for (int s2=1;s2<=6;s2++) {
                assertEquals("-13.46",l[s1][s2].toString());
            }
        }
    }

    public void testSetName() {
        ClarionDecimal d = (new ClarionDecimal(10,2)).setName("externalname");
        assertEquals("externalname",d.getName());
    }

    public void testAbs() {
        ClarionDecimal d;
        
        d = new ClarionDecimal("3.1415972");
        assertEquals("3.1415972",d.toString()); 
        assertEquals("3.1415972",d.abs().toString()); 

        d = new ClarionDecimal("-3.1415972");
        assertEquals("-3.1415972",d.toString()); 
        assertEquals("3.1415972",d.abs().toString()); 
    }

    public void testRoundClarionObject() {
        ClarionDecimal d;
        
        d = new ClarionDecimal("3.1415972");
        assertEquals("3.1415972",d.toString()); 
        assertEquals("3",d.round("1").toString()); 
        assertEquals("3.1",d.round("0.1").toString()); 
        assertEquals("3.14",d.round("0.01").toString()); 
        assertEquals("3.142",d.round("0.001").toString()); 
        assertEquals("3.1416",d.round("0.0001").toString()); 

        assertEquals("3.0",d.round("0.5").toString()); 
        assertEquals("3.15",d.round("0.05").toString()); 
        assertEquals("3.140",d.round("0.005").toString()); 
        assertEquals("3.1415",d.round("0.0005").toString()); 
        assertEquals("3.14160",d.round("0.00005").toString()); 

    }
    
    public void testGetBool()
    {
        ClarionDecimal n = new ClarionDecimal();
        
        n.setValue("0");
        assertEquals(false,n.getBool().boolValue());

        n.setValue("0.000");
        assertEquals(false,n.getBool().boolValue());

        n.setValue("0.001");
        assertEquals(true,n.getBool().boolValue());

        n.setValue("-0.001");
        assertEquals(true,n.getBool().boolValue());

        n.setValue("123123.123123");
        assertEquals(true,n.getBool().boolValue());
    }

    public void testSetOver() {
        
        ClarionDecimal c;
        ClarionDecimal n;
        
        c=new ClarionDecimal(10,2,"100");
        n=(new ClarionDecimal(10,3)).setOver(c);
        
        assertEquals("100.00",c.toString());
        assertEquals("10.000",n.toString());

        c.setValue("1234.56");
        assertEquals("1234.56",c.toString());
        assertEquals("123.456",n.toString());
        
        n.setValue("-6543.2101");
        assertEquals("-65432.10",c.toString());
        assertEquals("-6543.210",n.toString());
        
        ClarionString cs = new ClarionString(6);
        cs.setOver(c);
        
        assertEquals("\u0080\u0000\u0006\u0054\u0032\u0010",cs.toString());
        
        cs.setValue("\u0000\u0098\u0012\u0034\u0065\u0087");
        assertEquals("98123465.87",c.toString());
        assertEquals("9812346.587",n.toString());

        c.setValue(100);
        assertEquals("100.00",c.toString());
        assertEquals("10.000",n.toString());
        assertEquals("\u0000\u0000\u0000\u0001\u0000\u0000",cs.toString());
        
    }
    
    
    /**

    public void testGetReal() {
        fail("Not yet implemented");
    }

    
    */

    public void testNotThreadedNumber()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionDecimal s = new ClarionDecimal(5,2);
        
        final String[] r=new String[1];
        
        s.setValue(5);
        assertEquals("5.00",s.toString());
        
        s.increment("2.1");
        assertEquals("7.10",s.toString());
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue(-4);
                r[0]=s.toString();
            } } ,5000);

        assertEquals("-4.00",s.toString());
        assertEquals("-4.00",r[0]);
    }

    public void testThreadedNumber()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionDecimal s = (new ClarionDecimal(5,2)).setThread();;
        
        final String[] r=new String[1];
        
        s.setValue(5);
        assertEquals("5.00",s.toString());
        
        s.increment("2.1");
        assertEquals("7.10",s.toString());
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue(-4);
                r[0]=s.toString();
            } } ,5000);

        assertEquals("7.10",s.toString());
        assertEquals("-4.00",r[0]);
    }

    public void testThreadedNumberWithThreadedListeners()
    {
        helper=new ThreadHelper();
        ThreadHelper.TestThread t = helper.createThread(); 
        final ClarionDecimal s = (new ClarionDecimal(5,2)).setThread();;
        
        final int fireCount[] = new int[2];
        final ClarionMemoryChangeListener l[]=new ClarionMemoryChangeListener[2]; 
        l[0]=new ClarionMemoryChangeListener() {
            public void objectChanged(ClarionMemoryModel model) {
                fireCount[0]++;
            } };
        l[1]=new ClarionMemoryChangeListener() {
            public void objectChanged(ClarionMemoryModel model) {
                fireCount[1]++;
            } };

        s.addChangeListener(l[0]);
        t.runAndWait(new Runnable() { 
            @Override
            public void run() {
                s.addChangeListener(l[1]);
            }
        },5000);
        
        final String[] r=new String[1];
        
        s.setValue(5);
        assertEquals("5.00",s.toString());
        assertEquals(1,fireCount[0]);
        assertEquals(0,fireCount[1]);
        
        s.increment("2.1");
        assertEquals("7.10",s.toString());
        assertEquals(2,fireCount[0]);
        assertEquals(0,fireCount[1]);
        
        t.runAndWait(new Runnable(){

            @Override
            public void run() {
                s.setValue(-4);
                r[0]=s.toString();
            } } ,5000);
        assertEquals(2,fireCount[0]);
        assertEquals(1,fireCount[1]);

        assertEquals("7.10",s.toString());
        assertEquals("-4.00",r[0]);
    }
    
}
