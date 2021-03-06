package org.jclarion.clarion.primative;

public abstract class AbstractStateGetter<T> 
{
    public abstract T get(); 
    public abstract boolean isThreaded();
    public abstract AbstractStateGetter<T> getLockedGetter();
    public abstract void reset();
}
