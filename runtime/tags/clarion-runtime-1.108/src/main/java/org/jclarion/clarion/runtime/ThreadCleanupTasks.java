package org.jclarion.clarion.runtime;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.primative.ActiveThreadMap;
import org.jclarion.clarion.primative.Cleanup;

public class ThreadCleanupTasks 
{
    private static ThreadCleanupTasks instance;

    public static void cleanup()
    {
        ThreadCleanupTasks tct = instance;
        if (tct!=null) {
            tct.doCleanup();
        }
    }
    
    public static ThreadCleanupTasks getInstance()
    {
        if (instance==null) {
            synchronized(ThreadCleanupTasks.class) {
                if (instance==null) {
                    instance=new ThreadCleanupTasks();
                }
            }
        }
        return instance;
    }

    private static class Tasks implements Cleanup
    {
        private List<Cleanup> tasks=new ArrayList<Cleanup>();

        @Override
        public void cleanup() 
        {
            List<Cleanup> oldTasks;
            synchronized(this) {
                oldTasks=tasks;
                tasks=new ArrayList<Cleanup>();
            }
            
            for (Cleanup c : oldTasks ) {
                c.cleanup();
            }
        }
        
        public void add(Cleanup task)
        {
            synchronized(this) {
                tasks.add(task);
            }
        }

        /*
        public void remove(Cleanup task)
        {
            synchronized(this) {
                tasks.remove(task);
            }
        }
        */
        
    }

    private ActiveThreadMap<Tasks> tasks;
    
    public ThreadCleanupTasks()
    {
        tasks=new ActiveThreadMap<Tasks>();
        
        CRun.addShutdownHook(new Runnable() {
            @Override
            public void run() {
                instance=null;
                tasks.clear();
            }
        });
    }
    
    public void add(Cleanup c)
    {
        Thread thread=Thread.currentThread();
        Tasks threadTasks;
        synchronized(tasks) {
            threadTasks = tasks.get(thread);
            if (threadTasks==null) {
                threadTasks=new Tasks();
                tasks.put(thread,threadTasks);
            }
        }
        threadTasks.add(c);
    }
    
    public void doCleanup() 
    {
        Thread thread=Thread.currentThread();
        Tasks threadTasks;
        synchronized(tasks) {
            threadTasks = tasks.remove(thread);
        }
        if (threadTasks!=null) threadTasks.cleanup(); 
    }
}
