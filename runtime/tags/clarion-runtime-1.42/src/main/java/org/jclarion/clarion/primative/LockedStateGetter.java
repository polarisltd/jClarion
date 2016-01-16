package org.jclarion.clarion.primative;

public class LockedStateGetter<T> extends AbstractStateGetter<T> 
{
    private T state;

    public LockedStateGetter(T state)
    {
        this.state=state;
    }
    
    @Override
    public T get() {
        return state;
    }

    @Override
    public T get(Thread t) {
        return state;
    }

    @Override
    public boolean isThreaded() {
        return true;
    }

    @Override
    public AbstractStateGetter<T> getLockedGetter() {
        return this;
    }

    @Override
    public void reset() {
        throw new IllegalStateException("Cannot reset a locked getter");
    }
}
