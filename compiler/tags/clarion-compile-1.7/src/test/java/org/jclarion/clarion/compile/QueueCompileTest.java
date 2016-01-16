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
package org.jclarion.clarion.compile;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;

public class QueueCompileTest extends CompileTestHelper
{
    public void testCompileDefinitionOnly()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  queue,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "    code\n");
        
        ClarionQueue o = (ClarionQueue)instantiate(cl,ClarionCompiler.BASE+".Mygroup");
        
        assertNotNull(o.getGroupParam("f1"));
        assertNotNull(o.getGroupParam("f2"));
        assertNotNull(o.getGroupParam("f3"));
    }

    public void testCompileDefinitionAndVariable()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  queue\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "result   long\n",
                "    code\n",
                "    mygroup.f1=1\n",
                "    mygroup.f2=7\n",
                "    mygroup.f3=-5\n",
                "    result=mygroup.f1+mygroup.f2+mygroup.f3\n",
                "");
        
        runClarionProgram(cl);
        
        assertEquals(3,getMainVariable(cl,"result").intValue());
        
        ClarionQueue cg = (ClarionQueue)getMainObject(cl,"mygroup");
        assertEquals(1,cg.getGroupParam("f1").intValue());
        assertEquals(7,cg.getGroupParam("f2").intValue());
        assertEquals(-5,cg.getGroupParam("f3").intValue());
    }

    
    public void testCompileDoSomeInterestingWork()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  queue\n",
                "f1     pstring(20)\n",
                "f2     pstring(20)\n",
                "f3     pstring(20)\n",
                ".\n",
                "result   pstring(20)\n",
                "    code\n",
                "    if command(1)='put'\n",
                "        mygroup.f1=command(2)\n",
                "        mygroup.f2=command(3)\n",
                "        mygroup.f3=command(4)\n",
                "        add(mygroup,+mygroup.f1,-mygroup.f2)\n",
                "    .\n",
                "    if command(1)='get'\n",
                "        get(mygroup,int(command(2)))\n",
                "        result=mygroup.f3\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("",result.toString());
        
        runClarionProgram(cl);
        
        
        runClarionProgram(cl,"put","Paul","Simon","PS");
        runClarionProgram(cl,"put","Bob","Log III","BL");
        runClarionProgram(cl,"put","Paul","McCartney","PM");
        runClarionProgram(cl,"put","Paul","Weller","PW");

        runClarionProgram(cl,"put","Bob","Gandoff","BG");
        
        
        runClarionProgram(cl,"put","Robert","Johnson","RJ");

        runClarionProgram(cl,"put","The","Who","TW");
        runClarionProgram(cl,"put","The","Pogues","TP");
        runClarionProgram(cl,"put","The","Music","TM");

        String results[] = {
                "BL","BG","PW","PS","PM","RJ","TW","TP","TM"
        };
        
        for (int scan=0;scan<results.length;scan++) {
            runClarionProgram(cl,"get",String.valueOf(scan+1));
            assertEquals(results[scan],result.toString());
        }
        
    }

    public void testCompileCastingAmbiguity()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  queue\n",
                "f1     pstring(20)\n",
                "f2     pstring(20)\n",
                "f3     pstring(20)\n",
                ".\n",
                "result   pstring(20)\n",
                "    code\n",
                "    if command(1)='add'\n",
                "        mygroup.f1=command(3)\n",
                "        mygroup.f2=command(4)\n",
                "        mygroup.f3=command(5)\n",
                "        add(mygroup,command(2)+0)\n",
                "    .\n",
                "    if command(1)='get'\n",
                "        get(mygroup,command(2)+0)\n",
                "        result=mygroup.f3\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("",result.toString());
        
        runClarionProgram(cl);
        
        
        runClarionProgram(cl,"add","1","Paul","Simon","PS");
        runClarionProgram(cl,"add","2","Bob","Log III","BL");
        runClarionProgram(cl,"add","3","Paul","McCartney","PM");
        runClarionProgram(cl,"add","2","Paul","Weller","PW");

        runClarionProgram(cl,"get","1");
        assertEquals("PS",result.toString());

        runClarionProgram(cl,"get","2");
        assertEquals("PW",result.toString());

        runClarionProgram(cl,"get","3");
        assertEquals("BL",result.toString());

        runClarionProgram(cl,"get","4");
        assertEquals("PM",result.toString());
    }
    
    
    public void testCompileDoSomeInterestingWorkWithADangledVar()
    {
        ClassLoader cl = compile(
                "    program\n",
                "mygroup  myqueue\n",
                "myqueue  queue,type\n",
                "f1     pstring(20)\n",
                "f2     pstring(20)\n",
                "f3     pstring(20)\n",
                ".\n",
                "result   pstring(20)\n",
                "    code\n",
                "    if command(1)='put'\n",
                "        mygroup.f1=command(2)\n",
                "        mygroup.f2=command(3)\n",
                "        mygroup.f3=command(4)\n",
                "        add(mygroup,+mygroup.f1,-mygroup.f2)\n",
                "    .\n",
                "    if command(1)='get'\n",
                "        get(mygroup,int(command(2)))\n",
                "        result=mygroup.f3\n",
                "    .\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        assertEquals("",result.toString());
        
        runClarionProgram(cl);
        
        
        runClarionProgram(cl,"put","Paul","Simon","PS");
        runClarionProgram(cl,"put","Bob","Log III","BL");
        runClarionProgram(cl,"put","Paul","McCartney","PM");
        runClarionProgram(cl,"put","Paul","Weller","PW");

        runClarionProgram(cl,"put","Bob","Gandoff","BG");
        
        
        runClarionProgram(cl,"put","Robert","Johnson","RJ");

        runClarionProgram(cl,"put","The","Who","TW");
        runClarionProgram(cl,"put","The","Pogues","TP");
        runClarionProgram(cl,"put","The","Music","TM");

        String results[] = {
                "BL","BG","PW","PS","PM","RJ","TW","TP","TM"
        };
        
        for (int scan=0;scan<results.length;scan++) {
            runClarionProgram(cl,"get",String.valueOf(scan+1));
            assertEquals(results[scan],result.toString());
        }
        
    }
    
    public void testQueueExtendedFromGroup()
    {
        compile(
                "    program\n",
                "tlist   group,pre(tot)\n",
                "cn      decimal(10,2)\n",
                "dn      decimal(10,2)\n",
                "de      decimal(10,2)\n",
                "wi      decimal(10,2)\n",
                "i_sp    decimal(10,2)\n",
                "i_w     decimal(10,2)\n",
                "i_o     decimal(10,2)\n",
                "p       decimal(10,2)\n",
                ".\n",

                "dlist   queue(tlist),pre(dt)\n",
                "month   long\n",
                ".\n",
              
                "   code\n",
                "   add(dlist,+dt:month)\n",
                "   dt:p=1\n",
          "");
    }
    
    public void testShortenedNameAllowed()
    {
        compile(
                "    program\n",
                "tlist   group\n",
                "odh:cn      decimal(10,2)\n",
                ".\n",

                "   code\n",
                "   tlist.odh:cn=1\n",
                "   tlist.cn=1\n",
          "");
    }
    
    public void testEscalatedVars()
    {
        compile(
                "    program\n",
                
                "   map\n",
                "myproc procedure\n",
                "   .\n",

                "   code\n",
                "myproc procedure\n",
                "v long\n",
                "myqueue queue\n",
                "v2 like(v)\n",
                ".\n",
                "   code\n",
          "");
    }

    public void testEscalatedVars2()
    {
        compile(
                "    program\n",
                
                "   map\n",
                "myproc procedure\n",
                "   .\n",

                "   code\n",
                "myproc procedure\n",
                "v long\n",
                "myqueue queue\n",
                "v like(v)\n",
                ".\n",
                "   code\n",
          "");
    }

    public void testEnqueueAnyRef()
    {
        ClassLoader cl = compile(
                "    program\n",

                "q   queue\n",
                "item    any\n",
                ".\n",
                "v1 long\n",
                "v2 long\n",
                "v3 string(20)\n",
              
                "   code\n",
                "  v1=10\n",
                "  v2=15\n",
                "  v3='hello'\n",
                
                "   q.item&=v1\n",
                "   add(q)\n",

                "   q.item&=v2\n",
                "   add(q)\n",

                "   q.item&=v3\n",
                "   add(q)\n",
                
                "   get(q,1)\n",
                "   assert( q.item &= v1, 1)\n",

                "   get(q,2)\n",
                "   assert( q.item &= v2, 2)\n",

                "   get(q,3)\n",
                "   assert( q.item &= v3, 3)\n",

                "   get(q,2)\n",
                "   q.item=50\n",

                "   get(q,1)\n",
                "   assert( q.item = 10, 4)\n",
                "   get(q,2)\n",
                "   assert( q.item = 50, 5)\n",
                "   assert( v1 = 10, 6)\n",
                "   assert( v2 = 50, 6)\n",

                "   v1 = -2\n",
                "   assert( q.item = 50, 4)\n",
                "   get(q,1)\n",
                "   assert( q.item = -2, 5)\n",
                
                
          "");
        
        runClarionProgram(cl);
    }

    public void testEnqueueValues()
    {
        ClassLoader cl = compile(
                "    program\n",

                "q   queue\n",
                "item    any\n",
                ".\n",

                "   code\n",
                
                "   clear(q)\n",
                "   q.item=100\n",
                "   add(q)\n",

                "   clear(q)\n",
                "   q.item=200\n",
                "   add(q)\n",

                "   clear(q)\n",
                "   q.item=300\n",
                "   add(q)\n",
                
                "   get(q,1)\n",
                "   assert( q.item = 100, 1)\n",

                "   get(q,2)\n",
                "   assert( q.item = 200, 2)\n",

                "   get(q,3)\n",
                "   assert( q.item = 300, 3)\n",
                
                "   get(q,2)\n",
                "   q.item=50\n",

                "   get(q,1)\n",
                "   assert( q.item = 100, 4)\n",
                "   get(q,2)\n",
                
                // this behaviour is weird - it 'remembers' the change
                // even though it is supposed to be on the buffer
                // but this is exactly what C55 runtime does too
                // so behaviour is inconsistent with how non any types work 
                // in queue context. 
                "   assert( q.item = 50, 5)\n",
                
          "");
        
        runClarionProgram(cl);
    }

    public void testAnyToAnyInQueue()
    {
        ClassLoader cl = compile(
                "    program\n",

                "q  queue\n",
                "t1  any\n",
                "t2  any\n",
                ".\n",

                "v1  long(100)\n",
                "v2  long(100)\n",

                "   code\n",

                "   clear(q)\n",
                "   q.t1&=v1\n",
                "   q.t2=q.t1\n",
                "   add(q)\n",

                "   clear(q)\n",
                "   q.t1&=v2\n",
                "   q.t2=q.t1\n",
                "   add(q)\n",

                "   get(q,1)\n",
                "   assert(~(q.t1&=q.t2),'1')\n",
                "   assert(q.t1&=v1,'1b')\n",

                "   q.t1=10\n",
                "   q.t2=90\n",
                "   assert(q.t1=10,'2')\n",
                "   assert(q.t2=90,'3')\n",
                "   assert(v1=10,'4')\n",

                "   get(q,2)\n",
                "   get(q,1)\n",

                "   assert(q.t1=10,'5')\n",
                "   assert(q.t2=90,'6')\n",
                "   assert(v1=10,'7')\n",
                "");
        
        runClarionProgram(cl);
    }

    public void testAnyToRefAnyInQueue()
    {
        ClassLoader cl = compile(
                "    program\n",

                "q  queue\n",
                "t1  any\n",
                "t2  any\n",
                ".\n",

                "v1  long(100)\n",
                "v2  long(100)\n",

                "   code\n",

                "   clear(q)\n",
                "   q.t1&=v1\n",
                "   q.t2&=q.t1\n",
                "   add(q)\n",

                "   clear(q)\n",
                "   q.t1&=v2\n",
                "   q.t2=q.t1\n",
                "   add(q)\n",

                "   get(q,1)\n",
                "   assert(q.t1&=q.t2,'1')\n",
                "   assert(q.t1&=v1,'1b')\n",

                "   q.t1=10\n",
                "   q.t2=90\n",
                "   assert(q.t1=90,'2')\n",
                "   assert(q.t2=90,'3')\n",
                "   assert(v1=90,'4')\n",

                "   get(q,2)\n",
                "   get(q,1)\n",

                "   assert(q.t1=90,'5')\n",
                "   assert(q.t2=90,'6')\n",
                "   assert(v1=90,'7')\n",
                "");
        
        runClarionProgram(cl);
    }

    public void testGroupInQueue()
    {
        ClassLoader cl = compile(
                "    program\n",
                
                "mygroup group\n",
                "x   long\n",
                "y   long\n",
                ".\n",
                
                "myqueue  queue\n",
                "id    long\n",
                "pos   like(mygroup)\n",
                ".\n",
                "    code\n",
                "    myqueue.id=1\n",
                "    myqueue.pos.x=10\n",
                "    myqueue.pos.y=15\n",
                "    add(myqueue)\n",
                "    myqueue.id=2\n",
                "    myqueue.pos.x=20\n",
                "    myqueue.pos.y=25\n",
                "    add(myqueue)\n",
                "    \n",
                "    get(myqueue,1)\n",
                "    assert(myqueue.id=1,'a#1')\n",
                "    assert(myqueue.pos.x=10,'a#2')\n",
                "    assert(myqueue.pos.y=15,'a#3')\n",

                "    get(myqueue,2)\n",
                "    assert(myqueue.id=2,'a#4')\n",
                "    assert(myqueue.pos.x=20,'a#5')\n",
                "    assert(myqueue.pos.y=25,'a#6')\n",
        "");
                
        runClarionProgram(cl);
    }
    
}
