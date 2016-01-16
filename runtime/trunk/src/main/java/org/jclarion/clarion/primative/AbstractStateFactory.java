package org.jclarion.clarion.primative;

public abstract class AbstractStateFactory<T> 
{
    public abstract T createState();
    public abstract T cloneState(T base);
}
