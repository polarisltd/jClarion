package org.jclarion.clarion.runtime.concurrent;

public class ICriticalSection extends ISyncObject 
{
    private Thread  lockHolder;
    private int     lockCount;

    @Override
    public void Kill() 
    {
        synchronized(this) {
            lockCount=0;
            notifyAll();
        }
    }

    @Override
    public void Release() {
        synchronized(this) {
            if (lockCount>0) lockCount--;
            notifyAll();
        }
    }

    @Override
    public void Wait() {
        synchronized(this) {
            if (lockCount>0 && lockHolder!=Thread.currentThread()) { 
                while (lockCount>0) {
                    try {
                        wait();
                    } catch (InterruptedException e) {
                    }
                }
            }
            lockCount=1;
            lockHolder=Thread.currentThread();
        }
    }
}
