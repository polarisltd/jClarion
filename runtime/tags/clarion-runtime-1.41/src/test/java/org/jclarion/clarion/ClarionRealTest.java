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

import java.io.IOException;

import org.jclarion.clarion.util.SharedOutputStream;

import junit.framework.TestCase;

public class ClarionRealTest extends TestCase 
{

    public void testSerializeDeserialize() throws IOException 
    {
        double a = 1.23456;
        double b = 9.87654;
        double c = 0.00023415;
        
        ClarionReal c_a=new ClarionReal(a);
        ClarionReal c_b=new ClarionReal(b);
        ClarionReal c_c=new ClarionReal(c);
        
        SharedOutputStream sos = new SharedOutputStream();
        
        sos.reset();
        c_a.serialize(sos);
        byte[] s_a = sos.toByteArray();

        sos.reset();
        c_b.serialize(sos);
        byte[] s_b = sos.toByteArray();
        
        sos.reset();
        c_c.serialize(sos);
        byte[] s_c = sos.toByteArray();
        
        assertEquals(8,s_a.length);
        assertEquals(8,s_b.length);
        assertEquals(8,s_c.length);
        
        ClarionReal cr = new ClarionReal(0);

        sos.reset();
        sos.write(s_a);
        cr.deserialize(sos.getInputStream());
        assertEquals(a,cr.getDouble());

        sos.reset();
        sos.write(s_b);
        cr.deserialize(sos.getInputStream());
        assertEquals(b,cr.getDouble());

        sos.reset();
        sos.write(s_c);
        cr.deserialize(sos.getInputStream());
        assertEquals(c,cr.getDouble());
    }

    public void testSetValueClarionObject() 
    {
        ClarionReal cr = new ClarionReal(0);
        
        cr.setValue(new ClarionReal(4.75));
        assertEquals(4.75,cr.getDouble());

        cr.setValue(new ClarionNumber(4));
        assertEquals(4.0,cr.getDouble());


        cr.setValue(new ClarionBool(true));
        assertEquals(1.0,cr.getDouble());

        cr.setValue(new ClarionBool(false));
        assertEquals(0.0,cr.getDouble());

        cr.setValue(new ClarionString("16.125"));
        assertEquals(16.125,cr.getDouble());

        cr.setValue(new ClarionDecimal("2.500"));
        assertEquals(2.5,cr.getDouble());
    }

    public void testClearInt() 
    {
        ClarionReal cr = new ClarionReal(0);
        cr.setValue(5.234243);
        
        cr.clear(0);
        assertEquals(0.0,cr.getDouble());
        
        cr.clear(1);
        assertEquals(1.7976931348623157E308,cr.getDouble());

        cr.clear(-1);
        assertEquals(-1.7976931348623157E308,cr.getDouble());
    }

    public void testIntValue() {
        ClarionReal cr = new ClarionReal(0);
        cr.setValue(5.234243);
        assertEquals(5,cr.intValue());
    }

    public void testBoolValue() {
        ClarionReal cr = new ClarionReal(0.0);
        assertFalse(cr.boolValue());
        cr.setValue(5.234243);
        assertTrue(cr.boolValue());
    }

    public void testAddClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(12.125,cr.add(new ClarionNumber(4)).getReal().getDouble());
    }

    public void testMultiplyClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(40.625,cr.multiply(new ClarionNumber(5)).getReal().getDouble());
    }

    public void testSubtractClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(3.125,cr.subtract(new ClarionNumber(5)).getReal().getDouble());
    }

    public void testDivideClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(1.625,cr.divide(new ClarionNumber(5)).getReal().getDouble());
    }

    public void testNegate() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(-8.125,cr.negate().getReal().getDouble());
    }

    public void testModulusClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(2.125,cr.modulus(new ClarionDecimal("3.0")).getReal().getDouble());
    }

    public void testPowerClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(536.376953125,cr.power(new ClarionDecimal("3.0")).getReal().getDouble());
    }

    public void testCompareToClarionObject() {
        ClarionReal cr = new ClarionReal(8.125);
        
        assertCompare(1,cr,new ClarionReal(5));
        assertCompare(1,cr,new ClarionNumber(8));
        assertCompare(-1,cr,new ClarionNumber(9));
        assertCompare(1,cr,new ClarionString("1"));
        assertCompare(1,cr,new ClarionString("4"));
        assertCompare(-1,cr,new ClarionString("10"));
        assertCompare(-1,cr,new ClarionString("90"));
        assertCompare(0,cr,new ClarionDecimal("8.125"));
        assertCompare(1,cr,new ClarionDecimal("8.124"));
        assertCompare(-1,cr,new ClarionDecimal("8.126"));
    }

    private void assertCompare(int r,ClarionObject c1,ClarionObject c2)
    {
        assertEquals(r,c1.compareTo(c2));
        assertEquals(-r,c2.compareTo(c1));
    }
    
    public void testGetString() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals("8.125",cr.getString().toString());
    }

    public void testGetNumber() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals(8,cr.getNumber().intValue());
    }

    public void testGetReal() {
        ClarionReal cr = new ClarionReal(8.125);
        assertSame(cr,cr.getReal());
    }

    public void testGetBool() {
        ClarionReal cr;

        cr = new ClarionReal(0.0);
        assertFalse(cr.getBool().boolValue());

        cr = new ClarionReal(1.0);
        assertTrue(cr.getBool().boolValue());
        
        cr = new ClarionReal(8.125);
        assertTrue(cr.getBool().boolValue());
    }

    public void testGetDecimal() {
        ClarionReal cr = new ClarionReal(8.125);
        assertEquals("8.125",cr.getDecimal().toString());
    }

    public void testGenericLike() {
        ClarionReal cr = new ClarionReal(8.125);
        ClarionReal cl = cr.genericLike().getReal();
        
        assertNotSame(cr,cl);
        assertEquals(cr.getDouble(),cl.getDouble());
    }

}
