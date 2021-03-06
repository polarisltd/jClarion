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


import org.jclarion.clarion.runtime.ManyGlue;
import org.jclarion.clarion.runtime.OverGlue;

public abstract class ClarionObject extends ClarionMemoryModel
{
    private String name;
    
    private ClarionGroup owner;
    
    public abstract boolean isConstrained();
    
    public void setOwner(ClarionGroup owner)
    {
        this.owner=owner;
    }

    public ClarionGroup getOwner()
    {
        return owner;
    }
    
    /**
     * Set object to given value
     * 
     * @param object
     */
    public abstract void setValue(ClarionObject object);

    /**
     * Clear object value.
     * 
     * @param method
     */
    public abstract void clear(int method);
    
    /**
     * Return integer representation of the object
     * 
     * @return
     */
    public abstract int intValue();
    
    /**
     * Return boolen representation of the object
     * 
     * @return
     */
    public abstract boolean boolValue();

    /**
     * Do a numeric add. Result is returned as a new object
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject add(ClarionObject object);

    /**
     * Do a numeric multiply.  Result is returned as a new object 
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject multiply(ClarionObject object);
    
    /**
     * Do a numeric subtract.  Result is returned as a new object 
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject subtract(ClarionObject object);

    /**
     * Do a numeric divide.  Result is returned as a new object 
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject divide(ClarionObject object);

    /**
     * Do a numeric negation. Result is returned as a new object 
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject negate();

    /**
     * Do a numeric modulus. Result is returned as a new object 
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject modulus(ClarionObject object);

    /**
     * Do a numeric power. Result is returned as a new object 
     * 
     * @param object
     * @return
     */
    public abstract ClarionObject power(ClarionObject object);

    /**
     * Do a Comparison. Comparison type is preferentially numeric but 
     * if either object is a non numeric string then comparsion is a lexical
     * comparison 
     * 
     * @param object
     * @return
     */
    public abstract int compareTo(ClarionObject object);

    /**
     * Convert to string object
     * 
     * @return
     */
    public abstract ClarionString getString();
    
    /**
     * Convert to number object
     * 
     * @return
     */
    public abstract ClarionNumber getNumber();
    
    /**
     * Convert to real object
     * 
     * @return
     */
    public abstract ClarionReal getReal();
    
    /**
     * Convert to bool object
     * 
     * @return
     */
    public abstract ClarionBool getBool();

    /**
     * Convert to decimal object
     * 
     * @return
     */
    public abstract ClarionDecimal getDecimal();

    /**
     * set Value of this object
     * @param o
     */
    public void setValue(Object o)
    {
        setValue(Clarion.getClarionObject(o));
    }
    
    /**
     * Increment this object
     */
    public void increment(ClarionObject o) 
    {
        setValue(this.add(o));
    }

    /**
     * Decrement this object
     */
    public void decrement(ClarionObject o) 
    {
        setValue(this.subtract(o));
    }
    
    public void increment(Object value)
    {
        increment(Clarion.getClarionObject(value));
    }

    public void decrement(Object value)
    {
        decrement(Clarion.getClarionObject(value));
    }

    public ClarionObject add(Object value)
    {
        return add(Clarion.getClarionObject(value));
    }

    public ClarionObject subtract(Object value)
    {
        return subtract(Clarion.getClarionObject(value));
    }
    
    public ClarionObject divide(Object value)
    {
        return divide(Clarion.getClarionObject(value));
    }

    public ClarionObject multiply(Object value)
    {
        return multiply(Clarion.getClarionObject(value));
    }

    public ClarionObject power(Object value)
    {
        return power(Clarion.getClarionObject(value));
    }

    public ClarionObject modulus(Object value)
    {
        return modulus(Clarion.getClarionObject(value));
    }

    public int compareTo(Object o)
    {
        return compareTo(Clarion.getClarionObject(o));
    }

    /**
     * Do string concatination
     * 
     * @param obj
     * @return
     */
    public String concat(Object... obj)
    {
        return getString().concat(obj);
    }
    
    /**
     * Get character at given position
     * 
     * @param pos
     * @return
     */
    public ClarionString stringAt(Object pos)
    {
        return stringAt(Clarion.getClarionObject(pos));
    }
    
    public ClarionString stringAt(ClarionObject o)
    {
        return o.getString().stringAt(o);
    }

    /**
     *  Get sub string at given position
     *  
     * @param from
     * @param to
     * @return
     */
    public ClarionString stringAt(ClarionObject from,ClarionObject to)
    {
        return getString().stringAt(from,to);
    }

    public ClarionString stringAt(Object from,Object to)
    {
        return stringAt(Clarion.getClarionObject(from),Clarion.getClarionObject(to));
    }

    /**
     * Clear object
     */
    public void clear()
    {
        clear(0);
    }

    private boolean isNull;
    private boolean doNotClearNull;
    
    /**
     * Flag object as being 'null'. Used by SQL operations
     */
    public void setNull()
    {
        if (isNull==true) return;
        isNull=true;
        try {
            doNotClearNull=true;
            notifyChange();
        } finally {
            doNotClearNull=false;
        }
    }
    
    public void notifyChange()
    {
        if (isNull && !doNotClearNull) {
            isNull=false;
        }
        
        super.notifyChange();
    }

    /**
     * Flag object as being 'null'. Used by SQL operations
     */
    public void clearNull()
    {
        if (isNull==false) return;
        isNull=false;
        notifyChange();
    }
    
    public boolean isNull()
    {
        return isNull;
    }
    
    protected void doSetName(String name)
    {
        this.name=name;
    }
    
    public String getName()
    {
        return name;
    }
    
    public boolean isDecimal() {
        return false;
    }

    @Override
    public boolean equals(Object o) {
        return compareTo(Clarion.getClarionObject(o))==0;
    }

    private OverGlue glue;
    private void doSetOver(ClarionMemoryModel src,ClarionMemoryModel over) {
        if (glue!=null) {
            glue.destroy();
            glue=null;
        }
        glue = new OverGlue(src,over);
        glue.objectChanged(over);
    }
    
    public void destruct()
    {
        if (glue!=null) {
            glue.destroy();
            glue=null;
        }
    }

    public void doSetOver(ClarionMemoryModel over) {
        doSetOver(this,over);
    }

    public void doSetOver(ClarionMemoryModel over[]) {
        doSetOver(ManyGlue.array(over));
    }
    
    public void setOver(ClarionMemoryModel source[],ClarionMemoryModel target)
    {
        doSetOver(ManyGlue.array(source),target);
    }

    public abstract ClarionObject genericLike();

    public ClarionObject getValue() {
        return this;
    }

    public void concatSegment(StringBuilder target) 
    {
        target.append(toString());
    }
}
