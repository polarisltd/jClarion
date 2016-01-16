/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.runtime.ref;

import org.jclarion.clarion.ClarionCloneable;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.ThreadStateGetter;

public class RefVariable<T> extends ClarionMemoryModel implements ClarionCloneable 
{
    public static class State
    {
        private Object variable;
        public State(State base) {
            variable=base.variable;
        }
        public State() {
        }
    }
    
    private static class StateFactory extends AbstractStateFactory<State>
    {
        @Override
        public State cloneState(State base) {
            return new State(base);
        }

        @Override
        public State createState() {
            return new State();
        }
    }
    private static StateFactory factory=new StateFactory();
    
    protected AbstractStateGetter<State> state=new GlobalStateGetter<State>(factory);
    
    public void initThread()
    {
        if (state.isThreaded()) return;
        state=new ThreadStateGetter<State>(factory,state);
        super.initThread();
    }
    
    public RefVariable<T> setThread()
    {
        initThread();
        return this;
    }
    
    public RefVariable()
    {
    }

    public RefVariable(T variable)
    {
        this.state.get().variable=variable;
    }

    public RefVariable(RefVariable<T> variable,Thread t)
    {
        this.state=variable.state.getLockedGetter(t);
    }
    
    @SuppressWarnings("unchecked")
    public T get()
    {
        return (T)state.get().variable;
    }
    
    public void set(T variable)
    {
        State s = state.get();
        if (variable!=s.variable) {
            s.variable=variable;
            notifyChange();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public void deserialize(CMem is) 
    {
        State s = state.get();
        T new_variable = (T)is.readObject();
        if (new_variable!=s.variable) {
            s.variable=new_variable;
            notifyChange();
        }
    }

    @Override
    public void serialize(CMem os) 
    {
    	os.writeObject(state.get().variable);
    }

    @SuppressWarnings("unchecked")
    @Override
    public Object getLockedObject(Thread t) {
        return new RefVariable(this,t);
    }

	@Override
	public Object clarionClone() {
		return new RefVariable<T>(get());
	}

	@Override
	public void clear(int method) {
		set(null);
	}

	@Override
	public void clear() {
		set(null);
	}

	@Override
	public void setValue(Object o) {
		if (o instanceof RefVariable<?>) {
			state.get().variable=((RefVariable<?>)o).state.get().variable;
			return;
		}
		T t = get();
		if (t==null) return;
		if (t instanceof ClarionCloneable) {
			((ClarionCloneable)t).setValue(o);
		}
	}
}
