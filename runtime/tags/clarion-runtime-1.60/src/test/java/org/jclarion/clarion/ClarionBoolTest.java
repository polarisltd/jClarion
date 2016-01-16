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

public class ClarionBoolTest extends TestCase {

    public void testConstruct()
    {
        ClarionBool b;
        
        b= new ClarionBool();
        assertFalse(b.boolValue());

        b= new ClarionBool(true);
        assertTrue(b.boolValue());
        
        b= new ClarionBool(false);
        assertFalse(b.boolValue());

        b= new ClarionBool(0);
        assertFalse(b.boolValue());

        b= new ClarionBool(1);
        assertTrue(b.boolValue());

        b= new ClarionBool(-1);
        assertTrue(b.boolValue());

        b= new ClarionBool(10);
        assertTrue(b.boolValue());

        b= new ClarionBool(-10);
        assertTrue(b.boolValue());
    }

    public void testSerialize() {
        ClarionBool b;
        
        b=new ClarionBool(true);
        TestUtil.testSerialize(b,(byte)0x01);
        
        b=new ClarionBool(false);
        TestUtil.testSerialize(b,(byte)0x00);
    }

    public void testDeserialize() {
        ClarionBool b=new ClarionBool();
        
        TestUtil.testDeserialize(b,(byte)0x01);
        assertTrue(b.boolValue());

        TestUtil.testDeserialize(b,(byte)0x00);
        assertFalse(b.boolValue());

        TestUtil.testDeserialize(b,(byte)0xff);
        assertTrue(b.boolValue());
    }

    public void testSetValue() {
        ClarionBool b;
        
        b= new ClarionBool();

        b.setValue(true);
        assertTrue(b.boolValue());
        assertEquals("1",b.toString());

        b.setValue(false);
        assertFalse(b.boolValue());
        assertEquals("",b.toString());
    }

    public void testClear() {
        ClarionBool b=new ClarionBool(true);
        assertTrue(b.boolValue());

        b.clear();
        assertFalse(b.boolValue());
        
        b.clear(1);
        assertTrue(b.boolValue());

        b.clear(-1);
        assertFalse(b.boolValue());
        
        b.setValue(true);
        b.clear(0);
        assertFalse(b.boolValue());
    }

    public void testIntValue() {
        ClarionBool b=new ClarionBool(true);
        assertEquals(1,b.intValue());
        
        b.setValue(false);
        assertEquals(0,b.intValue());
    }
    
    public void testMath()
    {
        ClarionBool b = new ClarionBool(true);
        
        assertEquals("11",b.add(10).toString());

        assertEquals("-9",b.subtract(10).toString());

        assertEquals("10",b.multiply(10).toString());

        assertEquals("0.1",b.divide(Clarion.newDecimal("10")).toString());

        assertEquals("1",b.power(true).toString());

        assertEquals("1",b.modulus("10").toString());

        b.setValue(false);
        
        assertEquals("10",b.add(10).toString());

        assertEquals("-10",b.subtract(10).toString());

        assertEquals("0",b.multiply(10).toString());

        assertEquals("0",b.divide(Clarion.newDecimal("10")).toString());

        assertEquals("0",b.power(true).toString());
        assertEquals("1",b.power(false).toString());

        assertEquals("0",b.modulus("10").toString());
    }

    public void testNegate()
    {
        ClarionBool b=new ClarionBool();
        
        assertFalse(b.boolValue());
        assertTrue(b.negate().boolValue());
        assertFalse(b.negate().negate().boolValue());
    }

    public void testCompareTo()
    {
        ClarionBool b=new ClarionBool();
        
        assertTrue(b.compareTo(true)<0);
        assertTrue(b.compareTo(false)==0);
        
        assertTrue(b.compareTo("1")<0);
        assertTrue(b.compareTo(1)<0);
        assertTrue(b.compareTo("")==0);
        assertTrue(b.compareTo(0)==0);
        assertTrue(b.compareTo("2")<0);
        assertTrue(b.compareTo(2)<0);

        b.setValue(true);
        assertTrue(b.compareTo(true)==0);
        assertTrue(b.compareTo(false)>0);
        
        assertTrue(b.compareTo("1")==0);
        assertTrue(b.compareTo(1)==0);
        assertTrue(b.compareTo("0")>0);
        assertTrue(b.compareTo(0)>0);
        assertTrue(b.compareTo("2")<0);
        assertTrue(b.compareTo(2)<0);
    }
    

    public void testGetString() {
        ClarionBool b = new ClarionBool();
        
        b.setValue(false);
        assertEquals("",b.getString().toString());

        b.setValue(true);
        assertEquals("1",b.getString().toString());
    }

    public void testGetNumber() {
        ClarionBool b = new ClarionBool();
        
        b.setValue(false);
        assertEquals(0,b.getNumber().intValue());

        b.setValue(true);
        assertEquals(1,b.getNumber().intValue());
    }
    
    public void testGetBool() {
        ClarionBool b = new ClarionBool();
        assertSame(b,b.getBool());
    }

    public void testGetDecimal() {
        ClarionBool b = new ClarionBool();
        
        b.setValue(false);
        assertEquals("0",b.getDecimal().toString());

        b.setValue(true);
        assertEquals("1",b.getDecimal().toString());
    }

    public void testLike() {
        ClarionBool b = new ClarionBool();
        ClarionBool n=b.like();
        
        assertNotSame(n,b);
        
        assertTrue(n.equals(b));
        assertTrue(b.equals(n));
        
        b.setValue(true);

        assertFalse(n.equals(b));
        assertFalse(b.equals(n));

        n=b.like();
        assertNotSame(n,b);
        
        assertTrue(n.equals(b));
        assertTrue(b.equals(n));
    }
    
    /**
     *
    public void testGetReal() {
        fail("Not yet implemented");
    }
     */
}
