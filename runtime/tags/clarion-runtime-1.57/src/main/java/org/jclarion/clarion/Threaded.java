package org.jclarion.clarion;

public interface Threaded 
{
    public abstract void initThread();
    public abstract Object getLockedObject(Thread t);
    public abstract boolean isThreaded();
}
