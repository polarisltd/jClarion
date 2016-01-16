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

public class SharedInputStreamTest extends TestCase {

    private byte test[]=new byte [] { 
            (byte)1, (byte)3, (byte)5, (byte)7,
            (byte)11, (byte)13, (byte)17, (byte)19,
    };
    
    public void testRead() {
        
        SharedInputStream sis = new SharedInputStream(test);
        
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
        
        sis.close();
    }

    public void testReadByteArrayIntInt() {
        SharedInputStream sis = new SharedInputStream(test);
        
        byte result[] = new byte[3];
        
        assertEquals(3,sis.read(result));
        assertEquals(1,result[0]);
        assertEquals(3,result[1]);
        assertEquals(5,result[2]);

        assertEquals(2,sis.read(result,1,2));
        assertEquals(1,result[0]);
        assertEquals(7,result[1]);
        assertEquals(11,result[2]);

        assertEquals(2,sis.read(result,0,2));
        assertEquals(13,result[0]);
        assertEquals(17,result[1]);
        assertEquals(11,result[2]);

        assertEquals(1,sis.read(result,0,3));
        assertEquals(19,result[0]);
        assertEquals(17,result[1]);
        assertEquals(11,result[2]);

        assertEquals(-1,sis.read(result,0,3));
        assertEquals(19,result[0]);
        assertEquals(17,result[1]);
        assertEquals(11,result[2]);

        assertEquals(-1,sis.read(result,0,3));
        assertEquals(19,result[0]);
        assertEquals(17,result[1]);
        assertEquals(11,result[2]);
        
        sis.close();
        
    }

    public void testSkip() {
        SharedInputStream sis = new SharedInputStream(test);
        
        assertEquals(1,sis.read());
        
        assertEquals(1,sis.skip(1));
        
        assertEquals(5,sis.read());
        assertEquals(7,sis.read());

        assertEquals(2,sis.skip(2));
        
        assertEquals(17,sis.read());
        
        assertEquals(1,sis.skip(10));
        
        assertEquals(-1,sis.read());

        assertEquals(0,sis.skip(10));
        
        assertEquals(-1,sis.read());
        
        sis.close();
        
    }

    public void testAvailable() {
        SharedInputStream sis = new SharedInputStream(test);
        
        assertEquals(8,sis.available());
        assertEquals(1,sis.read());
        assertEquals(7,sis.available());
        assertEquals(3,sis.read());
        assertEquals(6,sis.available());
        assertEquals(5,sis.read());
        assertEquals(5,sis.available());
        assertEquals(7,sis.read());
        assertEquals(4,sis.available());
        assertEquals(11,sis.read());
        assertEquals(3,sis.available());
        assertEquals(13,sis.read());
        assertEquals(2,sis.available());
        assertEquals(17,sis.read());
        assertEquals(1,sis.available());
        assertEquals(19,sis.read());
        assertEquals(0,sis.available());
        assertEquals(-1,sis.read());
        assertEquals(0,sis.available());
        assertEquals(-1,sis.read());
        
        sis.close();
        
    }

    public void testMarkAndReset() {
        SharedInputStream sis = new SharedInputStream(test);
        
        assertEquals(1,sis.read());
        assertEquals(3,sis.read());
        assertEquals(5,sis.read());
        assertEquals(7,sis.read());
        sis.mark(0);
        assertEquals(11,sis.read());
        assertEquals(13,sis.read());
        assertEquals(17,sis.read());
        assertEquals(19,sis.read());
        assertEquals(-1,sis.read());
        assertEquals(-1,sis.read());
        
        sis.reset();
        assertEquals(11,sis.read());
        assertEquals(13,sis.read());
        assertEquals(17,sis.read());
        assertEquals(19,sis.read());
        assertEquals(-1,sis.read());
        assertEquals(-1,sis.read());
        
        sis.close();
        
    }


    public void testMarkSupported() {
        SharedInputStream sis = new SharedInputStream(test);
        assertTrue(sis.markSupported());
        sis.close();
        
    }

    public void testSharedInputStreamByteArrayIntInt() {
        SharedInputStream sis = new SharedInputStream(test,2,5);
        
        assertEquals(5,sis.read());
        assertEquals(7,sis.read());
        assertEquals(11,sis.read());
        assertEquals(13,sis.read());
        assertEquals(17,sis.read());
        assertEquals(-1,sis.read());
        assertEquals(-1,sis.read());
        sis.close();
        
    }

}
