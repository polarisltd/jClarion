package org.jclarion.clarion.runtime.concurrent;

import org.jclarion.clarion.constants.Wait;

public class ISemaphore extends IWaitableSyncObject {

    private int initial;
    private int allocated;
    private int max;
    
    public ISemaphore(Integer initial,Integer max)
    {
        if (initial==null) initial=0;
        if (max==null) max=1;
        allocated=initial;
        
        this.initial=initial;
        this.max=max;
    }
    
    public int getInitial()
    {
        return initial;
    }
    
    public int getMax()
    {
        return max;
    }
    
    @Override
    public void Release(int count) {
        synchronized(this) {
            allocated-=count;
            if (allocated<0) allocated=0;
            notifyAll();
        }
    }

    @Override
    public int TryWait(int milliseconds) {
        long until = System.currentTimeMillis()+milliseconds;
        synchronized(this) {
            while (allocated==max) {
                long sleep = until-System.currentTimeMillis();
                if (sleep<=0) return Wait.TIMEOUT;
                try {
                    wait(sleep);
                } catch (InterruptedException e) {
                    return Wait.TIMEOUT;
                }
            }
            allocated++;
            return Wait.OK;
        }
    }

    @Override
    public void Kill() {
        synchronized(this) {
            allocated=0;
            notifyAll();
        }
    }

    @Override
    public void Release() {
        Release(1);
    }

    @Override
    public void Wait() {
        synchronized(this) {
            while (allocated==max) {
                try {
                    wait();
                } catch (InterruptedException e) {
                }
            }
            allocated++;
            return;
        }
    }

}
