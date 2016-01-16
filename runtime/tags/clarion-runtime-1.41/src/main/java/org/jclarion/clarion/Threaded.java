package org.jclarion.clarion;

public interface Threaded 
{
    public abstract void initThread();
    public abstract Object getThreadState(Thread t);
}
