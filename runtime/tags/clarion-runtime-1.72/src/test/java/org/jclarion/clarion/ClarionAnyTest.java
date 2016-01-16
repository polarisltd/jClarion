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

import org.jclarion.clarion.memory.CMem;
import junit.framework.TestCase;

public class ClarionAnyTest extends TestCase {

    public void testConstruct() {
        ClarionAny s = new ClarionAny();
        assertEquals("",s.toString());

        s = new ClarionAny(new ClarionString("Hello"));
        assertEquals("Hello",s.toString());
    }

    public void testSetValueClarionObject() {
        
        ClarionAny s = new ClarionAny();
        s.setValue(new ClarionString("Hello"));
        assertEquals("Hello",s.toString());
    }

    public void testClear() {
        
        ClarionAny s = new ClarionAny();
        s.setValue(new ClarionString("Hello"));
        assertEquals("Hello",s.toString());

        s.clear();
        assertEquals("     ",s.toString());
    }

    public void testGenericLike() {
        ClarionAny s = new ClarionAny();
        s.setValue(new ClarionString("5"));
        assertEquals("5",s.genericLike().toString());
        assertNotSame(s,s.genericLike());
    }
    
    public void testAllMethods() {

        ClarionAny s = new ClarionAny();
        s.setValue(new ClarionString("5"));

        assertEquals(7,s.add(2).intValue());
        assertEquals(true,s.add(2).boolValue());
        assertEquals(true,s.compareTo(7)<0);
        assertEquals(2,s.divide(2).intValue());
        assertEquals(true,s.getBool().boolValue());
        assertEquals("5",s.getDecimal().toString());
        assertEquals("5",s.getNumber().toString());
        assertEquals("5",s.getString().toString());
        assertEquals("1",s.modulus(4).toString());
        assertEquals("15",s.multiply(3).toString());
        assertEquals("-5",s.negate().toString());
        assertEquals("125",s.power(3).toString());
        assertEquals("-3",s.subtract(8).toString());
    }


    public void testChangeInChildDoesNotAffectAny()
    {
        ClarionAny ca = new ClarionAny();
        
        ClarionNumber cn = new ClarionNumber();
        ca.setValue(cn);
        
        assertEquals(0,ca.intValue());
        ca.setValue(cn);

        cn.setValue(5);
        assertEquals(0,ca.intValue());
        
        ca.setValue(cn);
        assertEquals(5,ca.intValue());
        
        cn.setValue(10);
        assertEquals(5,ca.intValue());
    }
    
    public void testSerializaton()
    {
        ClarionAny any = new ClarionAny(new ClarionDecimal("10.23"));
        
        ClarionAny any2 = new ClarionAny();
        
        assertEquals("10.23",any.toString());
        assertEquals("",any2.toString());

        System.gc();
        Thread.yield();
        
        CMem sos = CMem.create();
        any.serialize(sos);
        any2.deserialize(sos);
        
        sos.resetRead();
        assertEquals(8,sos.remaining());
        byte b1[] = CMem.toByteArray(sos);

        System.gc();
        Thread.yield();

        assertEquals("10.23",any.toString());
        assertEquals("10.23",any2.toString());

        System.gc();
        Thread.yield();

        any.setValue("");
        assertEquals("",any.toString());
        assertEquals("10.23",any2.toString());

        System.gc();
        Thread.yield();
        
        sos.resetWrite();
        sos.resetRead();
        any2.serialize(sos);
        any.deserialize(sos);
        
        assertEquals("10.23",any.toString());
        assertEquals("10.23",any2.toString());

        sos.resetRead();
        byte b2[] = CMem.toByteArray(sos);
        assertEquals(b1[0],b2[0]);
        assertEquals(b1[1],b2[1]);
        assertEquals(b1[2],b2[2]);
        assertEquals(b1[3],b2[3]);
        
        assertSame(any.getDecimal(),any2.getDecimal());
        
        any.increment(1);
        assertEquals("11.23",any.toString());
        assertEquals("10.23",any2.toString());
    }
    
    public void testBufferLikeExample1()
    {
        ClarionGroup g1=new ClarionGroup();
        ClarionAny g1a = new ClarionAny();
        ClarionAny g1b = new ClarionAny();
        g1.addVariable("a",g1a);
        g1.addVariable("b",g1b);

        ClarionGroup g2=new ClarionGroup();
        ClarionAny g2a = new ClarionAny();
        ClarionAny g2b = new ClarionAny();
        ClarionAny g2c = new ClarionAny();
        g2.addVariable("a",g2a);
        g2.addVariable("b",g2b);
        g2.addVariable("c",g2c);
        
        
        g1.setOver(g2);
        
        g1a.setValue(15);
        g1b.setValue(30);
        
        assertEquals(15,g2a.intValue());
        assertEquals(30,g2b.intValue());
        assertEquals(0,g2c.intValue());
        
        g2a.setValue("Hello");
        g2b.setValue(new ClarionDecimal("10.2"));
        
        assertEquals("Hello",g1a.toString());
        assertEquals("10.2",g1b.toString());
        
        g2c.setValue("Other");

        assertEquals("Hello",g1a.toString());
        assertEquals("10.2",g1b.toString());

        assertEquals("Hello",g2a.toString());
        assertEquals("10.2",g2b.toString());
        
        assertSame(g1a.getString(),g2a.getString());
        assertSame(g1b.getDecimal(),g2b.getDecimal());
    }
}
