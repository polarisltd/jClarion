package org.jclarion.clarion.runtime.concurrent;

public class IReaderWriterLock {

    private class Reader extends ISyncObject
    {
        @Override
        public void Kill() {
            doKill();
        }

        @Override
        public void Release() {
            releaseReader();
        }

        @Override
        public void Wait() {
            getReader();
        }
    }

    private class Writer extends ISyncObject
    {
        @Override
        public void Kill() {
            doKill();
        }

        @Override
        public void Release() {
            releaseWriter();
        }

        @Override
        public void Wait() {
            getWriter();
        }
    }
    
    private Reader reader=new Reader();
    private Writer writer=new Writer();
    
    private int         readLockCount;
    private boolean     writeLock;
    private int         writePendingCount;
    private boolean     blockReadersOnWritePending;
    
    public IReaderWriterLock()
    {
        blockReadersOnWritePending=true;
    }

    public IReaderWriterLock(Boolean blockReadersOnWritePending)
    {
        if (blockReadersOnWritePending==null) {
            this.blockReadersOnWritePending=true;
        } else {
            this.blockReadersOnWritePending=blockReadersOnWritePending;
        }
    }
    
    public ISyncObject reader()
    {
        return reader;
    }
    
    public ISyncObject writer()
    {
        return writer;
    }
    
    public void Kill()
    {
        doKill();
    }
    
    private void doKill() {
        synchronized(this) {
            writeLock=false;
            writePendingCount=0;
            readLockCount=0;
            notifyAll();
        }
    }

    private void getReader()
    {
        synchronized(this) {
            while (writeLock || writePendingCount>0) {
                try {
                    wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            readLockCount++;
        }
    }

    private void releaseReader()
    {
        synchronized(this) {
            if (readLockCount>0) {
                readLockCount--;
                notifyAll();
            }
        }
    }

    private void getWriter()
    {
        synchronized(this) {
            if (blockReadersOnWritePending) writePendingCount++;
            while (writeLock || readLockCount>0) {
                try {
                    wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            if (blockReadersOnWritePending) writePendingCount--;
            writeLock=true;
        }
    }

    private void releaseWriter()
    {
        synchronized(this) {
            writeLock=false;
            notifyAll();
        }
    }
}
