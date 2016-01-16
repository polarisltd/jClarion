package org.jclarion.clarion.runtime.concurrent;

public abstract class ISyncObject {

    public abstract void Wait();
    public abstract void Release();
    public abstract void Kill();
    
    public int handleOf()
    {
        return hashCode();
    }
}
