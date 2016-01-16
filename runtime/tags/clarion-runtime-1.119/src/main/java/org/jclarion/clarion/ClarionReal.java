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

import java.math.BigDecimal;

import org.jclarion.clarion.memory.CMem;

/**
 * Model floating point number. We will use java primitive double for this.
 * 
 * Would not of bothered writing this except that BrowseManager ABC class 
 * seems to want one
 * 
 * @author barney
 *
 */
public class ClarionReal extends ClarionObject 
{
    private double value;
    private boolean isNull;

    public ClarionReal()
    {
    }
    
    public static final int REAL=1;
    public static final int SREAL=2;
    
    public ClarionReal setEncoding(int enc)
    {
    	return this;
    }
    
    public ClarionReal(double value)
    {
        this.value=value;
    }

    public ClarionReal(String value)
    {
        this(Double.parseDouble(value));
    }

    public double getDouble()
    {
        return value;
    }
    
    @Override
    public ClarionObject add(ClarionObject object) 
    {
        return new ClarionReal(object.getReal().value+value);
    }

    @Override
    public int compareTo(ClarionObject object) {
        
        double d = object.getReal().value;
        
        if (value==d) return 0;
        if (value>d) return 1;
        return -1;
    }

    @Override
    public ClarionBool getBool() {
        return new ClarionBool(value!=0.0);
    }

    @Override
    public ClarionNumber getNumber() {
        return new ClarionNumber((int)value);
    }

    @Override
    public ClarionReal getReal() {
        return this;
    }

    
    public String toString()
    {
        return (new BigDecimal(value)).toString();
    }
    
    @Override
    public ClarionString getString() {
        return new ClarionString(toString());
    }

    @Override
    public int intValue() {
        return (int)value;
    }

    @Override
    public ClarionObject multiply(ClarionObject object) 
    {
        return new ClarionReal(value*object.getReal().value);
    }

    @Override
    public void setValue(ClarionObject object) {
        double new_value = object.getReal().value;
        if (new_value==value) return;
        value=new_value;
        isNull=false;
        notifyChange();
    }

    @Override
    public boolean boolValue() {
        return value!=0;
    }

    @Override
    public ClarionObject divide(ClarionObject object) {
        return new ClarionReal(value/object.getReal().value);
    }

    @Override
    public ClarionObject modulus(ClarionObject object) {
        return new ClarionReal(value%object.getReal().value);
    }

    @Override
    public ClarionObject power(ClarionObject object) {
        return new ClarionReal(Math.pow(value,object.getReal().value));
    }

    @Override
    public ClarionObject subtract(ClarionObject object) {
        return new ClarionReal(value-object.getReal().value);
    }

    @Override
    public void clear(int method) {
        double new_value = value;
        if (method==0) {
            new_value=0;
        }
        if (method>0) {
            new_value=Double.MAX_VALUE;
        }
        if (method<0) {
            new_value=-Double.MAX_VALUE;
        }
        
        if (new_value==value) return;
        value=new_value;
        notifyChange();
    }

    @Override
    public ClarionObject negate() {
        return new ClarionReal(-value);
    }

    @Override
    public ClarionDecimal getDecimal() {
        return new ClarionDecimal(new BigDecimal(value));
    }

    @Override
    public void deserialize(CMem os) 
    {
        long l = 
        	((((long)os.readInt())&0xffffffffl)<<32)+  
        	((((long)os.readInt())&0xffffffffl));  

        double new_value = Double.longBitsToDouble(l);
                    
        if (new_value==value) return;
        value=new_value;
        notifyChange();
    }

    @Override
    public void serialize(CMem is) 
    {
        long long_value = Double.doubleToRawLongBits(value);
        is.writeInt((int)(long_value>>32));
        is.writeInt((int)(long_value));
    }

    @Override
    public ClarionObject genericLike() {
        return new ClarionReal(value);
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
    public Object getLockedObject(Thread t) {
        return this;
    }


	@Override
	public void setNull() {
		if (isNull) return;
		isNull=true;
		notifyChange();
	}

	@Override
	public void clearNull() {
		if (!isNull) return;
		isNull=false;
		notifyChange();
	}

	@Override
	public boolean isNull() {
		return isNull;
	}
}
