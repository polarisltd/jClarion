package org.jclarion.clarion;

import java.util.ArrayList;
import java.util.List;

public class ThreadHelper
{
    public class TestThread extends Thread
    {
        private boolean             shutdown;
        private Runnable            task;
        private RuntimeException    error;
        
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
                            try {
                                wait();
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
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
            } catch (RuntimeException t ) {
                synchronized(this) {
                    error=t;
                    notifyAll();
                }
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
                    if (waitNow<=0) throw new RuntimeException("Waited too long");
                    if (error!=null) throw(error);
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

}
