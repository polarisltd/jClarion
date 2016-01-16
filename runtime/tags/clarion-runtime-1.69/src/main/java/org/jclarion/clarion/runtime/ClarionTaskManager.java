package org.jclarion.clarion.runtime;

import java.util.Timer;

public class ClarionTaskManager 
{
    private static ClarionTaskManager instance;
    
    public static ClarionTaskManager getInstance()
    {
        if (instance==null) {
            synchronized(ClarionTaskManager.class) {
                if (instance==null) {
                    instance=new ClarionTaskManager();
                }
            }
        }
        return instance;
    }
    
    private Timer timer;
    
    public ClarionTaskManager()
    {
        timer=new Timer(true);
        CRun.addShutdownHook(new Runnable() {
            @Override
            public void run() {
                instance=null;
                timer.cancel();
            }
        });
    }
    
    public Timer getTimer()
    {
        return timer;
    }
    
    
}
