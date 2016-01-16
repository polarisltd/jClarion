package org.jclarion.clarion;


import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.ThreadStateGetter;

public class AbstractThreaded implements Threaded
{
    public static class State
    {
        public State() { }
    }
    
    private static class StateFactory extends AbstractStateFactory<State>
    {
        @Override
        public State cloneState(State base) {
            return new State();
        }

        @Override
        public State createState() {
            return new State();
        }
    }
    private static StateFactory factory=new StateFactory();
    
    private AbstractStateGetter<State> state=new GlobalStateGetter<State>(factory);
    
    @Override
    public Object getThreadState(Thread t) {
        return state.get(t);
    }
    
    public Object getThread()
    {
        initThread();
        return this;
    }

    @Override
    public void initThread() {
        if (!state.isThreaded()) {
            state=new ThreadStateGetter<State>(factory,state);
            state.get();
        }
    }

}
