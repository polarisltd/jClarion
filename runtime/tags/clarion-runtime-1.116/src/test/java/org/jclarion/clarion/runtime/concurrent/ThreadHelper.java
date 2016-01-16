package org.jclarion.clarion.runtime.concurrent;

import junit.framework.TestCase;
import java.util.List;
import java.util.ArrayList;

public class ThreadHelper extends TestCase 
{
    public class MyHelper extends Thread
    {
        private boolean shutdown;
        private boolean running;
        private RuntimeException thrown;
        private Runnable next;
        
        public void run()
        {
            while ( true ) {
                Runnable task=null;
                synchronized(this) {
                    if (shutdown) break;
                    while (next==null) {
                        if (shutdown) break;
                        running=false;
                        notifyAll();
                        try {
                            wait();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    task=next;
                    next=null;
                }
                try {
                    task.run();
                } catch (RuntimeException ex) { 
                    synchronized(this) {
                        thrown=ex;
                    }
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
        
        public void next(Runnable r)
        {
            synchronized(this) {
            	while (next!=null) {
            		try {
						wait();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
            	}
                next=r;
                running=true;
                notifyAll();
            }
        }
        
        public void waitUntilFinished()
        {
            synchronized(this) {
                while (running) {
                    try {
                        wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                if (thrown!=null) throw thrown;
            }
        }
        
        public boolean isFinished(long wait)
        {
            long until=System.currentTimeMillis()+wait;
            synchronized(this) {
                while (running) {
                    long sleep = until-System.currentTimeMillis();
                    if (sleep<=0) return false;
                    try {
                        wait(sleep);
                    } catch (InterruptedException e) {
                        return false;
                    }
                }
                if (thrown!=null) throw thrown;
            }
            return true;
        }
    }
    
    private List<MyHelper> threads=new ArrayList<MyHelper>();

    public MyHelper getHelper()
    {
        MyHelper helper =new  MyHelper();
        threads.add(helper);
        helper.start();
        return helper;
    }
    
    @Override
    public void tearDown()
    {
        for (MyHelper helper : threads) {
            helper.shutdown();
        }
        threads.clear();
    }

}
