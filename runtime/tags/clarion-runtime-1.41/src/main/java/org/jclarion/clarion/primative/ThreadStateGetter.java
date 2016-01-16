package org.jclarion.clarion.primative;


public class ThreadStateGetter<T> extends AbstractStateGetter<T> 
{
    private AbstractStateFactory<T> factory;
    private ActiveThreadMap<T> threadedState;
    private AbstractStateGetter<T> state;
    
    public ThreadStateGetter(AbstractStateFactory<T> aFactory,AbstractStateGetter<T> aState)
    {
        this.factory=aFactory;
        this.state=aState;
        threadedState=new ActiveThreadMap<T>();
    }
    
    @Override
    public T get() {
        return get(Thread.currentThread());
    }
    
    @Override
    public T get(Thread t) {
        T result;
        synchronized(threadedState) {
            result=threadedState.get(t);
            if (result==null) {
                result=factory.cloneState(state.get());
                threadedState.put(t,result);
            }
        }
        return result;
    }
    
    @Override
    public boolean isThreaded() {
        return true;
    }

    @Override
    public AbstractStateGetter<T> getLockedGetter() {
        return new LockedStateGetter<T>(get());
    }

    @Override
    public void reset() {
        synchronized(threadedState) {
            state.reset();
            threadedState.clear();
        }
    }
}
