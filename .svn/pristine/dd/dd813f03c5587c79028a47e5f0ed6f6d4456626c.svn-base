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

/**
 * Model number. Internally stored as java primitive 'int'
 * 
 * @author barney
 */
public class ClarionNumber extends ClarionObject {

    public static final int SIGNED  = 0x141;         // 32 bit signed
    public static final int BYTE    = 0x210;         // 8 bit unsigned
    public static final int LONG    = 0x341;         // 32 bit signed
    public static final int ULONG   = 0x440;         // 32 bit unsigned
    public static final int USHORT  = 0x520;         // 16 bit unsigned
    public static final int SHORT   = 0x621;         // 16 bit signed
    public static final int UNSIGNED= 0x740;         // 32 bit unsigned
    public static final int DATE    = 0x840;         // 32 bit
    public static final int TIME    = 0x940;         // 32 bit

    private int encoding=LONG;

    public static class State
    {
        private int    val;
        private boolean isNull;
        public State(ClarionNumber.State base) {
            val=base.val;
            isNull=base.isNull;
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

    public ClarionNumber setThread()
    {
        initThread();
        return this;
    }
    
    @Override
    public Object getLockedObject(Thread t) 
    {
        if (!state.isThreaded()) return this;
        return new ClarionNumber(this,t);
    }
    
    public ClarionNumber(ClarionNumber base,Thread lock)
    {
        super(base,lock);
        this.encoding=base.encoding;
        if (lock!=null) this.state=base.state.getLockedGetter(lock);
    }
    
    
    /**
     * Create 0 number
     */
    public ClarionNumber()
    {
        this(0);
    }
    
    /**
     * Create number of specified value
     * 
     * @param number
     */
    public ClarionNumber(int number)
    {
        state.get().val=number;
    }

    /**
     * Create number of specified value
     * 
     * @param value
     */
    public ClarionNumber(String value)
    {
    	int number=0;
    	try {
    		number = Integer.parseInt(value);
    	} catch (NumberFormatException ex) { }
        state.get().val=number;
    }

    public String toString()
    {
        return String.valueOf(state.get().val);
    }
    
    @Override
    public void concatSegment(StringBuilder target)
    {
        target.append(state.get().val); 
    }
    
    /**
     * Clone number
     * 
     * @return
     */
    public ClarionNumber like()
    {
        ClarionNumber n = new ClarionNumber(state.get().val);
        n.encoding=encoding;
        return n;
    }
    
    @Override
    public ClarionObject add(ClarionObject object) 
    {
        if (object.isDecimal()) return getDecimal().add(object);
        return new ClarionNumber(state.get().val+object.intValue());
    }

    @Override
    public void setValue(ClarionObject object) 
    {
        int new_value = object==null? 0 : object.intValue();
        State s = state.get();
        if (new_value!=s.val) {
            s.val=new_value;
            s.isNull=false;
            notifyChange();
        }
    }

    @Override
    public int compareTo(ClarionObject object) {
        
        if (object instanceof ClarionString) {
            // lexical comparison
            return -object.compareTo(this);
        }
        
        if (object instanceof ClarionDecimal) {
            // more accurate comparison
            return -object.compareTo(this);
        }

        if (object instanceof ClarionReal) {
            // more accurate comparison
            return -object.compareTo(this);
        }
        
        int v1 = state.get().val;
        int v2 = object.intValue();
        if (v1<v2) return -1;
        if (v1>v2) return 1;
        return 0;
    }


    @Override
    public int intValue() {
        return state.get().val;
    }


    @Override
    public ClarionObject multiply(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().multiply(object);
        return new ClarionNumber(state.get().val*object.intValue());
    }
    
    /**
     * return 1d array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0'
     */ 
    public ClarionArray<ClarionNumber> dim(int size)
    {
    	return new ClarionArray<ClarionNumber>(this,size);
    }
    
    
    /**
     * Set external name for object - used by SQL drivers etc
     * 
     * @param name
     * @return
     */
    public ClarionNumber setName(String name)
    {
        doSetName(name);
        return this;
    }
    
    /**
     * Set memory encoding. A multiple of options for this object type
     * 
     * @param encoding
     * @return
     */
    public ClarionNumber setEncoding(int encoding)
    {
        this.encoding=encoding;
        return this;
    }
    
    public int getEncoding()
    {
        return encoding;
    }


    @Override
    public ClarionBool getBool() {
        return new ClarionBool(boolValue());
    }


    @Override
    public ClarionNumber getNumber() {
        return this;
    }


    @Override
    public ClarionReal getReal() {
        return new ClarionReal(state.get().val);
    }


    @Override
    public ClarionString getString() {
        return new ClarionString(String.valueOf(state.get().val));
    }


    @Override
    public ClarionObject divide(ClarionObject object) {
        

        if (object  instanceof ClarionNumber) {
            int denom = object.getNumber().intValue();
            if (denom==0) return new ClarionNumber(0);
            int value = state.get().val;
            if (value%denom==0) return new ClarionNumber(value/denom);
        }
        
        //if (object.isDecimal()) return getDecimal().divide(object);
        //return new ClarionNumber(value/object.intValue());
        return getDecimal().divide(object);
    }


    @Override
    public ClarionObject modulus(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().modulus(object);
        return new ClarionNumber(state.get().val%object.intValue());
    }


    @Override
    public ClarionObject power(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().power(object);
        
        return new ClarionNumber(
                java.math.BigInteger.valueOf(state.get().val).pow(object.intValue()).intValue());
    }


    @Override
    public ClarionObject subtract(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().subtract(object);
        return new ClarionNumber(state.get().val-object.intValue());
    }


    @Override
    public boolean boolValue() {
        return state.get().val!=0;
    }


    @Override
    public void clear(int method) {
        if (method==0) setValue(0);
        if (method>0) {
        	switch(encoding) {
        		case BYTE:
        			setValue(255);
        			break;
        		case SHORT:
        			setValue(32767);
        			break;
        		case USHORT:
        			setValue(65535);
        			break;
        		case DATE:
        			setValue(2994626);
        			break;
        		case TIME:
        			setValue(8640000);
        			break;
        		default:
                	setValue(0x7fffffff);
                	break;
        	}		        	
        } else if (method<0) {
        	switch(encoding) {
        		case BYTE:
        		case ULONG:
        		case UNSIGNED:
        		case USHORT:
        		case DATE:
        		case TIME:
        			setValue(0);
        			break;
        		case SHORT:
        			setValue(-32768);
        			break;
    			default:
    				setValue(0x80000000);
    				break;
        	}
    	}		        	
    }


    @Override
    public ClarionObject negate() {
        return new ClarionNumber(-state.get().val);
    }


    @Override
    public ClarionDecimal getDecimal() {
        return new ClarionDecimal(java.math.BigDecimal.valueOf(state.get().val));
    }

    /**
     * Return absolute value for this object
     * 
     * @return
     */
    public ClarionNumber abs()
    {
        int value=state.get().val;
        return new ClarionNumber(value<0?-value:value);
    }
    
    /**
     * Overlay this object on another objects memory model
     */
    public ClarionNumber setOver(ClarionMemoryModel o)
    {
        doSetOver(o);
        return this;
    }
    
    /**
     * Bit shift a number.
     * 
     * @param value number to shift
     * @param shiftval +ve shift left. -ve = shift right.
     * @return resultant value
     */
    public static int shift(int value,int shiftval)
    {
        if (shiftval>0) {
            return value<<shiftval;
        }
        if (shiftval<0) {
            return value>>(-shiftval);
        }
        return value;
    }


    @Override
    public void deserialize(CMem is) {
        //if (encoding==DATE) throw new RuntimeException("Not yet implemented");
        //if (encoding==TIME) throw new RuntimeException("Not yet implemented");
        
        int new_value=0;
        int v;

        if ((encoding & 0x70)!=0) {
            v = is.readByte();
            new_value=(v&0xff);
        }

        if ((encoding & 0x60)!=0) {
            v = is.readByte();
            new_value+=((v&0xff)<<8);
        }
        
        if ((encoding & 0x40)!=0) {
            v = is.readByte();
            new_value+=((v&0xff)<<16);
            v = is.readByte();
            new_value+=((v&0xff)<<24);
        }

        
        if ((encoding & 0x01)!=0) {
            if ((encoding & 0x020)!=0 && (new_value&0x008000)!=0) {
                new_value = new_value | 0xffff0000;
            }

            if ((encoding & 0x010)!=0 && (new_value&0x000080)!=0) {
                new_value = new_value | 0xffffff00;
            }
        }
        
        setValue(new_value);
    }


    @Override
    public void serialize(CMem os) {
    
        int value = state.get().val;
        
        if (encoding==DATE) {
            //throw new RuntimeException("Not yet implemented");
        }
        if (encoding==TIME) {
            //throw new RuntimeException("Not yet implemented");
        }

        if ((encoding & 0x70)!=0) {
            os.writeByte(value);
        }

        if ((encoding & 0x60)!=0) {
            os.writeByte(value>>8);
        }
        
        if ((encoding & 0x40)!=0) {
            os.writeByte(value>>16);
            os.writeByte(value>>24);
        }


    }

    @Override
    public ClarionObject genericLike() {
        return like();
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

	@Override
	public void setNull() {
		State s = state.get();
		if (s.isNull) return;
		s.isNull=true;
		notifyChange();
	}

	@Override
	public void clearNull() {
		State s = state.get();
		if (!s.isNull) return;
		s.isNull=false;
		notifyChange();
	}


	@Override
	public boolean isNull() {
		return state.get().isNull;
	}    
}
