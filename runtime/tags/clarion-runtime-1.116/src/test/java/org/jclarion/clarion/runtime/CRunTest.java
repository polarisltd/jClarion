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
package org.jclarion.clarion.runtime;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

import junit.framework.TestCase;

public class CRunTest extends TestCase {

    public void testInit() {
        CRun.init(new String [] { });
    }

    public void testRandom()
    {
        int r1 = CRun.random(10000,20000);
        int r2 = CRun.random(10000,20000);
        assertTrue(r1>=10000);
        assertTrue(r1<20000);
        assertTrue(r2>=10000);
        assertTrue(r2<20000);
        assertTrue(r1!=r2); 
    }
    
    public void testCommand() {
        CRun.init(new String [] { "somecrap", "source=c9", "/spares", "/workshop" });
        
        assertEquals("somecrap source=c9 /spares /workshop",CRun.command("").toString());
        
        assertEquals("java",CRun.command("0").toString());
        
        assertEquals("somecrap",CRun.command("1").toString());
        assertEquals("source=c9",CRun.command("2").toString());
        assertEquals("/spares",CRun.command("3").toString());
        assertEquals("/workshop",CRun.command("4").toString());
        assertEquals("",CRun.command("5").toString());

        assertEquals("1",CRun.command("/spares").toString());
        assertEquals("1",CRun.command("/workshop").toString());
        assertEquals("",CRun.command("/miner").toString());
        
        assertEquals("c9",CRun.command("source").toString());
        assertEquals("",CRun.command("destination").toString());
    }

    public void testGetThreadID()
    {
        int id = CRun.getThreadID();
        assertTrue(id>0);
    }
    
    public void testBoolChoose()
    {
        ClarionObject o1 = new ClarionString("hello");
        ClarionObject o2 = new ClarionString("world");
        
        assertSame(o1,CRun.choose(true,o1,o2));
        assertSame(o2,CRun.choose(false,o1,o2));

        assertNotSame(o1,CRun.choose(true,null,o2));
        assertNotSame(o2,CRun.choose(false,o1,null));
        assertNotSame(o1,CRun.choose(true,null,null));
        assertNotSame(o2,CRun.choose(false,null,null));

        assertEquals(1,CRun.choose(true,null,o2).intValue());
        assertEquals(0,CRun.choose(false,o1,null).intValue());
        assertEquals(1,CRun.choose(true,null,null).intValue());
        assertEquals(0,CRun.choose(false,null,null).intValue());
    }

    public void testInList()
    {
        assertEquals(1,CRun.inlist("Hello",new ClarionString[] { 
                new ClarionString("Hello"),
                new ClarionString("World") }).intValue());

        assertEquals(2,CRun.inlist("World",new ClarionString[] { 
                new ClarionString("Hello"),
                new ClarionString("World") }).intValue());

        assertEquals(0,CRun.inlist("Junk",new ClarionString[] { 
                new ClarionString("Hello"),
                new ClarionString("World") }).intValue());

        assertEquals(1,CRun.inlist("Hello   ",new ClarionString[] { 
                new ClarionString("Hello"),
                new ClarionString("World") }).intValue());

        assertEquals(1,CRun.inlist("Hello",new ClarionString[] { 
                new ClarionString("Hello   "),
                new ClarionString("World") }).intValue());

        assertEquals(0,CRun.inlist(" Hello",new ClarionString[] { 
                new ClarionString("Hello   "),
                new ClarionString("World") }).intValue());

        assertEquals(0,CRun.inlist("Hello",new ClarionString[] { 
                new ClarionString(" Hello   "),
                new ClarionString("World") }).intValue());

        assertEquals(1,CRun.inlist(" Hello",new ClarionString[] { 
                new ClarionString(" Hello   "),
                new ClarionString("World") }).intValue());
    }

    public void testInRange() {
        assertTrue(CRun.inRange(new ClarionNumber(2),new ClarionNumber(1),new ClarionNumber(3)));
        assertTrue(CRun.inRange(new ClarionNumber(2),new ClarionNumber(2),new ClarionNumber(3)));
        assertTrue(CRun.inRange(new ClarionNumber(2),new ClarionNumber(1),new ClarionNumber(2)));
        assertFalse(CRun.inRange(new ClarionNumber(2),new ClarionNumber(3),new ClarionNumber(3)));
        assertFalse(CRun.inRange(new ClarionNumber(2),new ClarionNumber(1),new ClarionNumber(1)));
    }
    
    
    /*
    public void testCommand() {
        fail("Not yet implemented");
    }

    public void test_assertBoolean() {
        fail("Not yet implemented");
    }

    public void test_assertBooleanString() {
        fail("Not yet implemented");
    }

    public void testHalt() {
        fail("Not yet implemented");
    }

    public void testStop() {
        fail("Not yet implemented");
    }

    public void testInlist() {
        fail("Not yet implemented");
    }

    public void testChooseIntClarionObjectArray() {
        fail("Not yet implemented");
    }

    public void testChooseBooleanClarionObjectClarionObject() {
        fail("Not yet implemented");
    }

    public void testChooseBoolean() {
        fail("Not yet implemented");
    }

    public void testGetThreadID() {
        fail("Not yet implemented");
    }


    public void testStart() {
        fail("Not yet implemented");
    }

    public void testYield() {
        fail("Not yet implemented");
    }

    */
}
