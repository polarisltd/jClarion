package org.jclarion.clarion.runtime.concurrent;


import org.jclarion.clarion.constants.Wait;

public class IMutex extends IWaitableSyncObject 
{
    private int     count;
    private Thread  owner;
    
    public IMutex()
    {
        count=0;
    }
    
    @Override
    public void Release(int count) 
    {
        synchronized(this) {
            this.count-=count;
            if (this.count<0) this.count=0;
            notifyAll();
        }
    }

    @Override
    public int TryWait(int milliseconds) {
        long until = System.currentTimeMillis()+milliseconds;
        synchronized(this) {
            if (owner==Thread.currentThread()) {
                this.count++;
                return Wait.OK;
            }
            while (count>0) {
                long sleep = until-System.currentTimeMillis();
                if (sleep<=0) return Wait.TIMEOUT;
                try {
                    wait(sleep);
                } catch (InterruptedException e) {
                    return Wait.TIMEOUT;
                }
            }
            count=1;
            owner=Thread.currentThread();
            return Wait.OK;
        }
    }

    @Override
    public void Kill() {
        synchronized(this) {
            count=0;
            notifyAll();
        }
    }

    @Override
    public void Release() {
        synchronized(this) {
            if (count>0) {
                count--;
            }
            notifyAll();
        }
    }

    @Override
    public void Wait() {
        synchronized(this) {
            if (owner==Thread.currentThread()) {
                this.count++;
                return;
            }
            while (count>0) {
                try {
                    wait();
                } catch (InterruptedException e) { }
            }
            count=1;
            owner=Thread.currentThread();
            return;
        }
    }

}
