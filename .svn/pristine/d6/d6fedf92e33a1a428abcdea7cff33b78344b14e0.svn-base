package org.jclarion.clarion.compile;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionObject;
public class CompileThreadTest  extends CompileTestHelper
{
    private class TestThread extends Thread
    {
        private boolean             shutdown;
        private Runnable            task;
        
        @Override
        public void run()
        {
            try {
                while ( true ) {
                    Runnable nextTask=null;
                    synchronized(this) {
                        if (shutdown) return;
                        if (task!=null) {
                            nextTask=task;
                        } else {
                            wait();
                            continue;
                        }
                    }
                    nextTask.run();
                    synchronized(this) {
                        if (nextTask==task) {
                            task=null;
                            notifyAll();
                        }
                    }
                }
            } catch (Throwable t ) {
            }
        }
        
        public void shutdown()
        {
            synchronized(this) {
                shutdown=true;
                notifyAll();
            }
            try {
                join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        public void runAndWait(Runnable newTask,int wait)
        {
            long until = System.currentTimeMillis()+wait;
            synchronized(this) {
                this.task=newTask;
                notifyAll();
                while (task!=null) {
                    long waitNow = until-System.currentTimeMillis();
                    if (waitNow<=0) fail("Waited too long");
                    try {
                        wait(waitNow);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
    
    private List<TestThread> threads=new ArrayList<TestThread>();
    
    
    public TestThread createThread()
    {
        TestThread newThread=new TestThread();
        newThread.start();
        threads.add(newThread);
        return newThread;
    }
    
    public void tearDown()
    {
        for (TestThread tt : threads ) {
            tt.shutdown();
        }
        threads.clear();
    }
    
    public void testInstanceAssignToRef()
    {
        ClassLoader cl = compile(
                "    program\n",
                "r1 long\n",
                "r2 long\n",
                "baseclass class,thread\n",
                "val long\n",
                "run procedure,long\n",
                ".\n",
                "nref &baseclass\n",
                "nref2 &baseclass\n",
                "    code\n",
                "    if command(1)='init'\n",
                "         nref&=baseclass\n",
                "         nref2&=instance(baseclass,0)\n",
                "         return\n",
                "    .\n",
                "     r1=nref.run()\n",
                "     r2=nref2.run()\n",
                "baseclass.run procedure\n",
                "   code\n",
                "   SELF.val+=1\n",
                "   return SELF.val\n",
        "");

        ClarionObject r1 = getMainVariable(cl,"r1");
        ClarionObject r2 = getMainVariable(cl,"r2");
        runClarionProgram(cl,"init");

        runClarionProgram(cl);
        assertEquals(1,r1.intValue());
        assertEquals(1,r2.intValue());

        runClarionProgram(cl);
        assertEquals(2,r1.intValue());
        assertEquals(2,r2.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(1,r1.intValue());
        assertEquals(3,r2.intValue());

        runClarionProgram(cl);
        assertEquals(3,r1.intValue());
        assertEquals(4,r2.intValue());
        
        runClarionProgram(tt,cl);
        assertEquals(2,r1.intValue());
        assertEquals(5,r2.intValue());
        
        runClarionProgram(cl);
        assertEquals(4,r1.intValue());
        assertEquals(6,r2.intValue());
    }

    public void testInstanceAssignToRefAlsoThreaded()
    {
        ClassLoader cl = compile(
                "    program\n",
                "r1 long\n",
                "r2 long\n",
                "baseclass class,thread\n",
                "val long\n",
                "run procedure,long\n",
                ".\n",
                "nref &baseclass,thread\n",
                "nref2 &baseclass,thread\n",
                "tid long\n",
                "    code\n",
                "    if tid=0 then tid=thread().\n",
                "    if command(1)='init'\n",
                "         nref&=baseclass\n",
                "         nref2&=instance(baseclass,tid)\n",
                "         return\n",
                "    .\n",
                "     r1=nref.run()\n",
                "     r2=nref2.run()\n",
                "baseclass.run procedure\n",
                "   code\n",
                "   SELF.val+=1\n",
                "   return SELF.val\n",
        "");

        ClarionObject r1 = getMainVariable(cl,"r1");
        ClarionObject r2 = getMainVariable(cl,"r2");
        runClarionProgram(cl,"init");

        runClarionProgram(cl);
        assertEquals(1,r1.intValue());
        assertEquals(1,r2.intValue());

        runClarionProgram(cl);
        assertEquals(2,r1.intValue());
        assertEquals(2,r2.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl,"init");
        
        runClarionProgram(tt,cl);
        assertEquals(1,r1.intValue());
        assertEquals(3,r2.intValue());

        runClarionProgram(cl);
        assertEquals(3,r1.intValue());
        assertEquals(4,r2.intValue());
        
        runClarionProgram(tt,cl);
        assertEquals(2,r1.intValue());
        assertEquals(5,r2.intValue());
        
        runClarionProgram(cl);
        assertEquals(4,r1.intValue());
        assertEquals(6,r2.intValue());
    }
    
    public void testInstanceOnThreadedClass()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "baseclass class\n",
                ".\n",
                "myclass class(baseclass),thread\n",
                ".\n",
                "    code\n",
                "    result=instance(myclass)\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        
        int r1 = result.intValue();
        
        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        
        int r2 = result.intValue();
        
        assertTrue(r1!=r2);
    }

    public void testInstanceOnUnthreadedClass()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "baseclass class\n",
                ".\n",
                "myclass class(baseclass)\n",
                ".\n",
                "    code\n",
                "    result=instance(myclass)\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        
        int r1 = result.intValue();
        
        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        
        int r2 = result.intValue();
        
        assertTrue(r1==r2);
    }

    public void testInstanceOnThreadedObject()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclass string(20),thread\n",
                "    code\n",
                "    result=instance(myclass)\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        
        int r1 = result.intValue();
        
        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        
        int r2 = result.intValue();
        
        assertTrue(r1!=r2);
    }

    public void testInstancePassesThreadExplicitly()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclass string(20),thread\n",
                "    code\n",
                "    if command(1)='thread'\n",
                "        result=thread()\n",
                "    elsif command(1)='instance'\n",
                "        result=instance(myclass,command(2))\n",
                "    else\n",
                "        result=instance(myclass)\n",
                "    .\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        
        int r1 = result.intValue();
        
        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        
        int r2 = result.intValue();
        
        assertTrue(r1!=r2);
        
        int t1=(int)Thread.currentThread().getId();
        int t2=(int)tt.getId();
        
        runClarionProgram(cl,"instance",""+t1);
        assertEquals(r1,result.intValue());
        runClarionProgram(cl,"instance",""+t2);
        assertEquals(r2,result.intValue());
        runClarionProgram(cl,"instance","0");
        assertEquals(r1,result.intValue());
        
        runClarionProgram(tt,cl,"instance",""+t1);
        assertEquals(r1,result.intValue());
        runClarionProgram(tt,cl,"instance",""+t2);
        assertEquals(r2,result.intValue());
        runClarionProgram(tt,cl,"instance","0");
        assertEquals(r2,result.intValue());
    }
    
    public void testInstanceOnUnthreadedObject()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclass string(20)\n",
                "    code\n",
                "    result=instance(myclass)\n",
        "");

        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        
        int r1 = result.intValue();
        
        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        
        int r2 = result.intValue();
        
        assertTrue(r1==r2);
    }
    
    public void testThreadedReference()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "tresult &long,thread\n",
                "    code\n",
                "   if tresult&=null " +
                "        tresult&=new long",
                "        tresult=5\n",
                "   .\n",
                "   tresult+=1\n",
                "   result=tresult\n");
        ClarionObject result = getMainVariable(cl,"result");

        runClarionProgram(cl);
        assertEquals(6,result.intValue());
        runClarionProgram(cl);
        assertEquals(7,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(6,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(7,result.intValue());

        runClarionProgram(cl);
        assertEquals(8,result.intValue());
    }

    public void testThreadedReferenceToClass()
    {
        ClassLoader cl = compile(
                "    program\n",
                "myclass class,type\n",
                "value long(5)\n",
                ".\n",
                "result long\n",
                "tresult &myclass,THREAD\n",
                "    code\n",
                "   if tresult&=null then tresult&=new myclass\n.",
                "   tresult.value+=1\n",
                "   result=tresult.value\n");
        ClarionObject result = getMainVariable(cl,"result");

        runClarionProgram(cl);
        assertEquals(6,result.intValue());
        runClarionProgram(cl);
        assertEquals(7,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(6,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(7,result.intValue());

        runClarionProgram(cl);
        assertEquals(8,result.intValue());
    }
    
    public void testThreadedClassA()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclass  class,thread\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "doit  procedure,long\n",
                ".\n",
                "    code\n",
                "    result=myclass.doit\n",
                "myclass.doit  procedure\n",
                "    code\n",
                "    SELF.f1+=1\n",
                "    SELF.f2+=self.f1+2\n",
                "    SELF.f3+=self.f2+3\n",
                "    return SELF.f1+self.f2+self.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
    }

    public void testThreadedClassB()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclasstype  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "doit  procedure,long\n",
                ".\n",
                "myclass myclasstype,thread\n",
                "    code\n",
                "    result=myclass.doit\n",
                "myclasstype.doit  procedure\n",
                "    code\n",
                "    SELF.f1+=1\n",
                "    SELF.f2+=self.f1+2\n",
                "    SELF.f3+=self.f2+3\n",
                "    return SELF.f1+self.f2+self.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
    }

    public void testThreadedClassWithRefVars()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclasstype  class,type\n",
                "f1     long\n",
                "f2     &long\n",
                "f3     &long\n",
                "doit  procedure,long\n",
                ".\n",
                "myclass myclasstype,thread\n",
                "    code\n",
                "    result=myclass.doit\n",
                "myclasstype.doit  procedure\n",
                "    code\n",
                "    if SELF.f2&=NULL\n",
                "      SELF.f2&=new long\n",
                "      SELF.f3&=new long\n",
                "    .\n",
                "    SELF.f1+=1\n",
                "    SELF.f2+=self.f1+2\n",
                "    SELF.f3+=self.f2+3\n",
                "    return SELF.f1+self.f2+self.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
    }
    
    public void testThreadedInheritance()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "superclass  class,type\n",
                "f1     long\n",
                "f2     long\n",
                ".\n",
                "myclasstype  class(superclass),type\n",
                "f3     long\n",
                "doit  procedure,long\n",
                ".\n",
                "myclass myclasstype,thread\n",
                "    code\n",
                "    result=myclass.doit\n",
                "myclasstype.doit  procedure\n",
                "    code\n",
                "    SELF.f1+=1\n",
                "    SELF.f2+=self.f1+2\n",
                "    SELF.f3+=self.f2+3\n",
                "    return SELF.f1+self.f2+self.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
    }

    public void testThreadedClassWithGroup()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "superclass  group,type\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "myclasstype  class,type\n",
                "f1     long\n",
                "sc     superclass\n",
                "doit  procedure,long\n",
                ".\n",
                "myclass myclasstype,thread\n",
                "    code\n",
                "    result=myclass.doit\n",
                "myclasstype.doit  procedure\n",
                "    code\n",
                "    SELF.f1+=1\n",
                "    SELF.sc.f2+=self.f1+2\n",
                "    SELF.sc.f3+=self.sc.f2+3\n",
                "    return SELF.f1+self.sc.f2+self.sc.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
    }
    
    
    public void testThreadedDeepClass()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "superclass  class,type\n",
                "f2     long\n",
                "f3     long\n",
                ".\n",
                "myclasstype  class,type\n",
                "f1     long\n",
                "sc     superclass\n",
                "doit  procedure,long\n",
                ".\n",
                "myclass myclasstype,thread\n",
                "    code\n",
                "    result=myclass.doit\n",
                "myclasstype.doit  procedure\n",
                "    code\n",
                "    SELF.f1+=1\n",
                "    SELF.sc.f2+=self.f1+2\n",
                "    SELF.sc.f3+=self.sc.f2+3\n",
                "    return SELF.f1+self.sc.f2+self.sc.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
    }
    
    public void testThreadedAndUnthreaded()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "myclasstype  class,type\n",
                "f1     long\n",
                "f2     long\n",
                "f3     long\n",
                "doit  procedure,long\n",
                ".\n",
                "myclass myclasstype,thread\n",
                "myclass2 myclasstype\n",
                "    code\n",
                "    if command(1)=2\n",
                "        result=myclass2.doit\n",
                "     else\n",
                "        result=myclass.doit\n",
                "     .\n",
                "myclasstype.doit  procedure\n",
                "    code\n",
                "    SELF.f1+=1\n",
                "    SELF.f2+=self.f1+2\n",
                "    SELF.f3+=self.f2+3\n",
                "    return SELF.f1+self.f2+self.f3\n",
                "");
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl);
        assertEquals(10,result.intValue());
        runClarionProgram(cl);
        assertEquals(25,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(10,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(25,result.intValue());

        TestThread tt = createThread();
        runClarionProgram(tt,cl);
        assertEquals(10,result.intValue());
        runClarionProgram(tt,cl);
        assertEquals(25,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(46,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(74,result.intValue());
    }
    
    
    public void testThreadedString()
    {
        TestThread tt = createThread();
        
        ClassLoader cl = compile(
            "   program\n",
            "result pstring(20)\n",
            "localresult pstring(20),thread\n",
            "   code\n",
            "   localresult=localresult&command(1)\n",
            "   result=localresult\n"
            );
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl,"a");
        assertEquals("a",result.toString());
        runClarionProgram(cl,"b");
        assertEquals("ab",result.toString());
        runClarionProgram(tt,cl,"c");
        assertEquals("c",result.toString());
        runClarionProgram(tt,cl,"d");
        assertEquals("cd",result.toString());
        runClarionProgram(cl,"e");
        assertEquals("abe",result.toString());

    }

    public void testThreadedGroup()
    {
        TestThread tt = createThread();
        
        ClassLoader cl = compile(
            "   program\n",
            "result pstring(20)\n",
            "localgroup group,thread\n",
            "result pstring(20)\n",
            ".\n",
            "   code\n",
            "   localgroup.result=localgroup.result&command(1)\n",
            "   result=localgroup.result\n"
            );
        
        System.out.println(compiler.repository().get("Main").toJavaSource(compiler));
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl,"a");
        assertEquals("a",result.toString());
        runClarionProgram(cl,"b");
        assertEquals("ab",result.toString());
        runClarionProgram(tt,cl,"c");
        assertEquals("c",result.toString());
        runClarionProgram(tt,cl,"d");
        assertEquals("cd",result.toString());
        runClarionProgram(cl,"e");
        assertEquals("abe",result.toString());

    }
    
    public void testThreadedNumber()
    {
        TestThread tt = createThread();
        
        ClassLoader cl = compile(
            "   program\n",
            "result long\n",
            "localresult long,thread\n",
            "   code\n",
            "   localresult=localresult+command(1)\n",
            "   result=localresult\n"
            );
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl,"1");
        assertEquals(1,result.intValue());
        runClarionProgram(cl,"2");
        assertEquals(3,result.intValue());
        runClarionProgram(tt,cl,"3");
        assertEquals(3,result.intValue());
        runClarionProgram(tt,cl,"4");
        assertEquals(7,result.intValue());
        runClarionProgram(cl,"5");
        assertEquals(8,result.intValue());

    }

    public void testThreadedDecimal()
    {
        TestThread tt = createThread();
        
        ClassLoader cl = compile(
            "   program\n",
            "result decimal(5,2)\n",
            "localresult decimal(5,2),thread\n",
            "   code\n",
            "   localresult=localresult+command(1)\n",
            "   result=localresult\n"
            );
        
        ClarionObject result = getMainVariable(cl,"result");
        runClarionProgram(cl,"1");
        assertEquals("1.00",result.toString());
        runClarionProgram(cl,"2");
        assertEquals("3.00",result.toString());
        runClarionProgram(tt,cl,"3");
        assertEquals("3.00",result.toString());
        runClarionProgram(tt,cl,"4");
        assertEquals("7.00",result.toString());
        runClarionProgram(cl,"5");
        assertEquals("8.00",result.toString());

    }
    
    public void runClarionProgram(TestThread tt,final ClassLoader cl,final String ...params)
    {
        tt.runAndWait(new Runnable() {

            @Override
            public void run() {
                runClarionProgram(cl,params);
            } } ,5000);
    }
}
