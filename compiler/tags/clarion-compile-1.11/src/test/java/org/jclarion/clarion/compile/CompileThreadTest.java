package org.jclarion.clarion.compile;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.compile.java.ClassRepository;
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
        
        System.out.println(ClassRepository.get("Main").toJavaSource());
        
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
