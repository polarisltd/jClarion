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

import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.ThreadStateGetter;

public class ClarionAny extends ClarionObject implements ClarionMemoryChangeListener
{
    public static class State
    {
        private ClarionObject value; 
        private ClarionObject reference; 

        public State(State base) {
            value=base.value;
            reference=base.reference;
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
    
    private AbstractStateGetter<State> state=new GlobalStateGetter<State>(factory);
    
    public void initThread()
    {
        if (!state.isThreaded()) state=new ThreadStateGetter<State>(factory,state); 
        super.initThread();
    }

    @Override
    public Object getLockedObject(Thread t) 
    {
        if (!state.isThreaded()) return this;
        return new ClarionAny(this,t);
    }
    
    public ClarionAny()
    {
        this(new ClarionString(""));
    }

    public ClarionAny(ClarionObject value)
    {
        setValue(value);
    }

    public ClarionAny(ClarionAny base,Thread lock)
    {
        super(base,lock);
        if (lock!=null) this.state=base.state.getLockedGetter(lock);
    }
    
    
    protected ClarionAny(ClarionObject value,ClarionObject reference)
    {
        State s = state.get();
        if (reference!=null) {
            s.value=value;
            s.reference=reference;
        } else {
            s.value=value.genericLike();
        }
    }

    public ClarionAny like()
    {
        return (ClarionAny)genericLike();
    }
    
    public String toString()
    {
        State s = state.get();
        return s.value.toString();
    }
    
    @Override
    public ClarionObject add(ClarionObject object) {
        return state.get().value.add(object);
    }

    @Override
    public boolean boolValue() {
        State s = state.get();
        return s.value.boolValue();
    }

    @Override
    public void clear(int method) {
        State s = state.get();
        s.value.clear(method);
    }

    @Override
    public int compareTo(ClarionObject object) {
        State s = state.get();
        return s.value.compareTo(object);
    }

    @Override
    public ClarionObject divide(ClarionObject object) {
        State s = state.get();
        return s.value.divide(object);
    }

    @Override
    public ClarionObject genericLike() {
        State s = state.get();
        return new ClarionAny(s.value,s.reference);
    }

    @Override
    public ClarionBool getBool() {
        return state.get().value.getBool();
    }

    @Override
    public ClarionDecimal getDecimal() {
        return state.get().value.getDecimal();
    }

    @Override
    public ClarionNumber getNumber() {
        return state.get().value.getNumber();
    }

    @Override
    public ClarionReal getReal() {
        return state.get().value.getReal();
    }

    @Override
    public ClarionString getString() {
        return state.get().value.getString();
    }

    @Override
    public int intValue() {
        return state.get().value.intValue();
    }

    @Override
    public ClarionObject modulus(ClarionObject object) {
        return state.get().value.modulus(object);
    }

    @Override
    public ClarionObject multiply(ClarionObject object) {
        return state.get().value.multiply(object);
    }

    @Override
    public ClarionObject negate() {
        return state.get().value.negate();
    }

    @Override
    public ClarionObject power(ClarionObject object) {
        return state.get().value.power(object);
    }

    @Override
    public void setValue(ClarionObject object) {
        setValue(object,true);
    }

    public void setReferenceValue(ClarionObject object)
    {
        State s =state.get();
        ClarionObject new_reference=null;
        
        if (object!=null) {
            object=object.getValue();
            new_reference=object;
            s.value=object;
        } else {
            new_reference=null;
            s.value=new ClarionString("");
        }
        
        if (new_reference!=s.reference) {
            s.reference=new_reference;
            notifyChange();
        }
    }

    public void setValue(ClarionObject object,boolean clone) {
        State s =state.get();

        object=object.getValue();

        if (s.reference!=null) {
            s.reference.setValue(object);
            return;
        } 
        
        if (clone) object=object.genericLike();
        if (object==s.value) return;
        
        //if (this.value!=null) {
        //    this.value.removeChangeListener(this);
        //}
        
        s.value=object;
        
        //this.value.addChangeListener(this);
        
        notifyChange();
    }

    @Override
    public ClarionObject subtract(ClarionObject object) {
        return state.get().value.subtract(object);
    }

    /**
     * Assuming that serialization is serialization of address only
     */
    @Override
    public void deserialize(CMem is) {
        
        State s =state.get();
        
        ClarionObject nv = (ClarionObject)is.readObject();
        if (nv==null) throw new RuntimeException("Address invalid");

        ClarionObject nr = (ClarionObject)is.readObject();
     
        if (nv==s.value && nr==s.reference) return;
        s.value=nv;
        s.reference=nr;
        notifyChange();
    }

    @Override
    public void serialize(CMem os) {
        State s =state.get();
        os.writeObject(s.value);
        os.writeObject(s.reference);
    }

    @Override
    public void objectChanged(ClarionMemoryModel model) {
        if (model!=state.get().value) return;
        notifyChange();
    }

    @Override
    public ClarionObject getValue()
    {
        return state.get().value.getValue();
    }

    public ClarionObject getReference()
    {
        return state.get().reference;
    }

    @Override
    public boolean isConstrained() 
    {
        return false;
    }


    @Override
    public int getSize() {
        return -1;
    }
    
    public ClarionAny setThread()
    {
        initThread();
        return this;
    }

	@Override
	public void setNull() {
		state.get().value.setNull();
		// TODO Auto-generated method stub
		
	}

	@Override
	public void clearNull() {
		state.get().value.clearNull();
	}

	@Override
	public boolean isNull() {
		return state.get().value.isNull();
	}

    
}
