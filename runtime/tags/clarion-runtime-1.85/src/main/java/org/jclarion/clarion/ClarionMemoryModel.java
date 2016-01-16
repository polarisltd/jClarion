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
package org.jclarion.clarion;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.MyReference;
import org.jclarion.clarion.primative.MyStrongReference;
import org.jclarion.clarion.primative.MyWeakReference;
import org.jclarion.clarion.primative.ThreadStateGetter;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.OverGlue;


/**
 * Model clarion object on memory.
 * 
 * @author barney
 *
 */
public abstract class ClarionMemoryModel implements Threaded 
{
    public static class State
    {
        public State(State base) {
            listeners=base.listeners;
            base.listeners=null;
        }

        public State() {
        }

        private List<MyReference> listeners;
    }
    
    protected void lock(ClarionMemoryModel base,Thread t)
    {
        state=base.state.getLockedGetter(t);
    }
 
    public ClarionMemoryModel castTo(Class<? extends ClarionMemoryModel> clazz)
    {
        try {
            ClarionMemoryModel model = clazz.newInstance();
            if (model instanceof ClarionGroup) {
                ClarionGroup cg = (ClarionGroup)model;
                int cglen = CMemory.size(cg);
                int thislen = CMemory.size(this);
                if (thislen>cglen) {
                    cg.addVariable("__padding:"+cg.getVariableCount(),new ClarionString(thislen-cglen));
                }
            }
            (new OverGlue(model,this)).objectChanged(this);
            return model;
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
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
    
    private AbstractStateGetter<State> state;
    
    public ClarionMemoryModel() {
        state=new GlobalStateGetter<State>(factory);
    }

    public ClarionMemoryModel(ClarionMemoryModel base,Thread lock) {
        if (lock!=null) {
            state=base.state.getLockedGetter(lock);
        } else {
            state=new GlobalStateGetter<State>(factory);
        }
    }

    
    public void initThread()
    {
        if (!state.isThreaded()) {
            state=new ThreadStateGetter<State>(factory,state);
            state.get();
        }
    }

    /**
     * Write java object to memory as clarion would represent object in memory
     * 
     * @param is
     */
    public abstract void serialize(CMem is);
    
    /**
     * Read object from memory as clarion would represent object in memory
     */ 
    public abstract void deserialize(CMem os);
    
    /**
     * Listen for changes to the objects representation. Note that listener
     * is weakly referenced. You need to maintain a strong reference to the
     * listener object in order for it not to be garbage collected 
     * 
     * @param cmcl
     */
    public void addChangeListener(ClarionMemoryChangeListener cmcl)
    {
        addChangeListener(cmcl,false);
    }

    public void addChangeListener(ClarionMemoryChangeListener cmcl,boolean strong)
    {
        State s = state.get();
        synchronized(s) {
            if (s.listeners==null) {
                s.listeners = new ArrayList<MyReference>();
            }
            if (strong) {
                s.listeners.add(new MyStrongReference(cmcl));
            } else {
                s.listeners.add(new MyWeakReference(cmcl));
            }
        }
    }

    /**
     * Stop Listening for changes to the objects representation
     * 
     * @param cmcl
     */
    public void removeChangeListener(ClarionMemoryChangeListener cmcl)
    {
        State s = state.get();
        synchronized(s) {
            if (s.listeners==null) return;
            Iterator<MyReference> scan;
            scan = s.listeners.iterator();
            while (scan.hasNext()) {
                MyReference val = scan.next();
                ClarionMemoryChangeListener sval = val.get();
                if (sval==cmcl || sval==null) {
                    scan.remove();
                }
            }
            if (s.listeners.isEmpty()) s.listeners=null;
        }
    }
    
    public boolean isAnyoneInterestedInChange()
    {
        State s = state.get();
        synchronized(s) {
            return s.listeners!=null;
        }
    }
    
    public int getListenerCount()
    {
        State s = state.get();
        synchronized(s) {
            if (s.listeners==null) return 0;
            return s.listeners.size();
        }
    }
    
    public void notifyChange() {

        List<ClarionMemoryChangeListener> notify = null; 
        State s = state.get();
        synchronized(s) {
            if (s.listeners==null) return;
            Iterator<MyReference> scan;
            scan = s.listeners.iterator();
            while (scan.hasNext()) {
                MyReference val = scan.next();
                ClarionMemoryChangeListener sval = val.get();
                if (sval==null) {
                    scan.remove();
                } else {
                    if (notify==null) {
                        notify = new ArrayList<ClarionMemoryChangeListener>();                        
                    }
                    notify.add(sval);
                }
            }
            if (s.listeners.isEmpty()) s.listeners=null;
        }
        
        if (notify==null) return;
        
        for ( ClarionMemoryChangeListener scan : notify ) {
            scan.objectChanged(this);
        }
    }
    
    @Override
    public final boolean isThreaded() {
        return state.isThreaded();
    }
}
