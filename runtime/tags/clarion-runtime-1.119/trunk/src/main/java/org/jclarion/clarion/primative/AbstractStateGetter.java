package org.jclarion.clarion.primative;

public abstract class AbstractStateGetter<T> 
{
    public abstract T get(); 
    public abstract T get(Thread t); 
    public abstract boolean isThreaded();
    public abstract AbstractStateGetter<T> getLockedGetter(Thread t);
    public abstract void reset();
}
