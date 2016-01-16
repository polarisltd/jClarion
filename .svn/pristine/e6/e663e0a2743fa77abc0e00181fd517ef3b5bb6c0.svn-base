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

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.ThreadStateGetter;
import org.jclarion.clarion.runtime.CMemory;

public class RefVariable<T> extends ClarionMemoryModel 
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
    public void deserialize(InputStream is) throws IOException 
    {
        int m=0;
        for (int scan=0;scan<4;scan++) {
            int r = is.read();
            if (r==-1) throw new IOException("Unexpected EOF");
            m=m+((r&0xff)<<(scan*8));
        }
        
        State s = state.get();
        T new_variable = (T)CMemory.resolveAddress(m);
        if (new_variable!=s.variable) {
            s.variable=new_variable;
            notifyChange();
        }
    }

    @Override
    public void serialize(OutputStream os) throws IOException 
    {
        int m = CMemory.address(state.get().variable);
        os.write(m);
        os.write(m>>8);
        os.write(m>>16);
        os.write(m>>24);
    }

}
