package org.jclarion.clarion.primative;

public class GlobalStateGetter<T> extends AbstractStateGetter<T> 
{
    private T state;
    private AbstractStateFactory<T> factory;

    public GlobalStateGetter(AbstractStateFactory<T> factory)
    {
        this.factory=factory;
        reset();
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
        return false;
    }

    @Override
    public AbstractStateGetter<T> getLockedGetter() {
        return this;
    }

    @Override
    public void reset() {
        this.state=factory.createState();
    }
}
