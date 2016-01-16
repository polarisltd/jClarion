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
package org.jclarion;

import junit.framework.TestCase;

import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.memory.CMem;

public class TestUtil 
{
    public static void testSerialize(String output,ClarionMemoryModel model)
    {
        byte o[]=new byte[output.length()];
        for (int scan=0;scan<output.length();scan++) {
            o[scan]=(byte)output.charAt(scan);
        }
        testSerialize(model,o);
    }

    public static void testSerialize(ClarionMemoryModel model,byte... i)
    {
        byte result[]=null;
		CMem baos = CMem.create();
		model.serialize(baos);
		result = CMem.toByteArray(baos);
        
        TestCase.assertEquals(result.length,i.length);
        
        for (int scan=0;scan<result.length;scan++) {
            TestCase.assertEquals(""+scan,result[scan],(byte)i[scan]);
        }
    }

    public static void testDeserialize(String output,ClarionMemoryModel model)
    {
        byte o[]=new byte[output.length()];
        for (int scan=0;scan<output.length();scan++) {
            o[scan]=(byte)output.charAt(scan);
        }
        testDeserialize(model,o);
    }
    
    
    public static void testDeserialize(ClarionMemoryModel model,byte... result)
    {
       	CMem mem = CMem.create();
       	for (byte b : result) {
       		mem.writeByte(b);
       	}
        model.deserialize(mem);
        TestCase.assertEquals(0,mem.remaining());
    }
    
    public static void triggerGC()
    {
        System.gc();
        Thread.yield();
        try {
            Thread.sleep(50);
        } catch (InterruptedException ex) { }
    }
    
}
