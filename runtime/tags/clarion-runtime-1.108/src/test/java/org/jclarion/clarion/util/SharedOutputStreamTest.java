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
package org.jclarion.clarion.util;

import junit.framework.TestCase;

public class SharedOutputStreamTest extends TestCase {

    private byte test[]=new byte [] { 
            (byte)1, (byte)3, (byte)5, (byte)7,
            (byte)11, (byte)13, (byte)17, (byte)19,
    };
    
    public void testWriteToClonedStreamIsOK()
    {
        SharedOutputStream bsos = new SharedOutputStream();
        SharedOutputStream sos=bsos.like();
        
        sos.write(1);
        sos.write(3);
        sos.write(5);
        
        assertEquals(3,sos.getSize());
        
        byte t[];
        
        t=sos.getBytes();
        
        assertEquals(1,t[0]);
        assertEquals(3,t[1]);
        assertEquals(5,t[2]);
        
        t=sos.toByteArray();

        assertEquals(1,t[0]);
        assertEquals(3,t[1]);
        assertEquals(5,t[2]);
        assertEquals(3,t.length);
        
        try { sos.close();} catch (java.io.IOException ex) { }
        try { bsos.close();} catch (java.io.IOException ex) { }
    }
    
    public void testWriteInt() {
        
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(1);
        sos.write(3);
        sos.write(5);
        
        assertEquals(3,sos.getSize());
        
        byte t[];
        
        t=sos.getBytes();
        
        assertEquals(1,t[0]);
        assertEquals(3,t[1]);
        assertEquals(5,t[2]);
        
        t=sos.toByteArray();

        assertEquals(1,t[0]);
        assertEquals(3,t[1]);
        assertEquals(5,t[2]);
        assertEquals(3,t.length);
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

    public void testWriteByteArray() {
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(test);
        
        assertEquals(8,sos.getSize());
        
        byte t[];
        
        t=sos.getBytes();
        
        assertEquals(1,t[0]);
        assertEquals(3,t[1]);
        assertEquals(5,t[2]);
        assertEquals(7,t[3]);
        assertEquals(11,t[4]);
        assertEquals(13,t[5]);
        assertEquals(17,t[6]);
        assertEquals(19,t[7]);
        
        t=sos.toByteArray();

        assertEquals(1,t[0]);
        assertEquals(3,t[1]);
        assertEquals(5,t[2]);
        assertEquals(7,t[3]);
        assertEquals(11,t[4]);
        assertEquals(13,t[5]);
        assertEquals(17,t[6]);
        assertEquals(19,t[7]);
        assertEquals(8,t.length);
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

    public void testWriteByteArrayIntInt() {
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(test,1,6);
        
        byte t[];
        
        assertEquals(6,sos.getSize());
        
        t=sos.getBytes();
        
        assertEquals(3,t[0]);
        assertEquals(5,t[1]);
        assertEquals(7,t[2]);
        assertEquals(11,t[3]);
        assertEquals(13,t[4]);
        assertEquals(17,t[5]);
        
        t=sos.toByteArray();

        assertEquals(3,t[0]);
        assertEquals(5,t[1]);
        assertEquals(7,t[2]);
        assertEquals(11,t[3]);
        assertEquals(13,t[4]);
        assertEquals(17,t[5]);
        assertEquals(6,t.length);
        
        sos.write(test,2,3);

        assertEquals(9,sos.getSize());
        
        t=sos.getBytes();
        
        assertEquals(3,t[0]);
        assertEquals(5,t[1]);
        assertEquals(7,t[2]);
        assertEquals(11,t[3]);
        assertEquals(13,t[4]);
        assertEquals(17,t[5]);
        assertEquals(5,t[6]);
        assertEquals(7,t[7]);
        assertEquals(11,t[8]);
        
        t=sos.toByteArray();

        assertEquals(3,t[0]);
        assertEquals(5,t[1]);
        assertEquals(7,t[2]);
        assertEquals(11,t[3]);
        assertEquals(13,t[4]);
        assertEquals(17,t[5]);
        assertEquals(5,t[6]);
        assertEquals(7,t[7]);
        assertEquals(11,t[8]);
        assertEquals(9,t.length);
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

    public void testGetInputStream() {
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(test,0,8);
        
        SharedInputStream sis = sos.getInputStream();
        
        assertEquals(1,sis.read());
        assertEquals(3,sis.read());
        assertEquals(5,sis.read());
        assertEquals(7,sis.read());
        assertEquals(11,sis.read());
        assertEquals(13,sis.read());
        assertEquals(17,sis.read());
        assertEquals(19,sis.read());
        assertEquals(-1,sis.read());
        assertEquals(-1,sis.read());
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

    public void testReset() {
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(test,0,8);
        sos.reset();
        assertEquals(0,sos.getSize());
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

    public void testGetBytes() {
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(test,0,8);
        assertSame(sos.getBytes(),sos.getBytes());
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

    public void testToByteArray() {
        SharedOutputStream sos = new SharedOutputStream();
        sos.write(test,0,8);
        assertNotSame(sos.toByteArray(),sos.toByteArray());
        
        try { sos.close();} catch (java.io.IOException ex) { }
        
    }

}
