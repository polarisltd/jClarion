package org.jclarion.clarion.runtime.concurrent;

public abstract class IWaitableSyncObject extends ISyncObject
{
    public abstract int TryWait(int milliseconds);
    public abstract void Release(int count);
}
