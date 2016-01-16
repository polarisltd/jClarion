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

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class ClarionBool extends ClarionObject
{
    private boolean value;
    
    public ClarionObject getThreadLockedClone()
    {
        return this;
    }
    
    /**
     *  Create new clarion boolean. Defaults to false
     */
    public ClarionBool()
    {
        this.value=false;
    }

    /**
     * Create new boolean
     * @param value. 0 = false !0 = true
     */
    public ClarionBool(int value)
    {
        this.value=(value!=0);
    }

    /**
     * Create new boolean
     * @param value. 0 = false !0 = true
     */
    public ClarionBool(boolean  value)
    {
        this.value=value;
    }

    public String toString()
    {
        return value ? "1" : "";
    }
    
    /**
     * clone object
     * 
     * @return
     */
    public ClarionBool like()
    {
        return new ClarionBool(value);
    }

    
    @Override
    public ClarionObject add(ClarionObject object) {
        return getNumber().add(object);
    }

    @Override
    public int compareTo(ClarionObject object) {
        if (object instanceof ClarionBool) {
            return intValue() - object.intValue(); 
        }
        return -object.compareTo(this);
    }

    @Override
    public int intValue() {
        return value ? 1 : 0;
    }

    @Override
    public ClarionObject multiply(ClarionObject object) {
        return getNumber().multiply(object);
    }

    @Override
    public void setValue(ClarionObject object) {
        value=object.boolValue();
    }

    @Override
    public ClarionBool getBool() {
        return this;
    }

    @Override
    public ClarionNumber getNumber() {
        return new ClarionNumber(intValue());
    }

    @Override
    public ClarionReal getReal() {
        return new ClarionReal(intValue());
    }

    @Override
    public ClarionString getString() {
        return new ClarionString(toString());
    }

    @Override
    public ClarionObject divide(ClarionObject object) {
        return getNumber().divide(object);
    }

    @Override
    public ClarionObject modulus(ClarionObject object) {
        return getNumber().modulus(object);
    }

    @Override
    public ClarionObject power(ClarionObject object) {
        return getNumber().power(object);
    }

    @Override
    public ClarionObject subtract(ClarionObject object) {
        return getNumber().subtract(object);
    }

    @Override
    public boolean boolValue() {
        return value;
    }


    @Override
    public void clear(int method) {
        if (method>0) {
            setValue(true);
        } else {
            setValue(false);
        }
    }


    @Override
    public ClarionObject negate() {
        return new ClarionBool(!value);
    }


    @Override
    public ClarionDecimal getDecimal() {
        return new ClarionDecimal(intValue());
    }

    @Override
    public void deserialize(InputStream os) throws IOException
    {
        int val = os.read();
        if (val==-1) throw new IOException("Unexpected EOF");
        setValue(val);
    }

    @Override
    public void serialize(OutputStream is) throws IOException
    {
        is.write(value? 1 : 0 );
    }

    @Override
    public ClarionObject genericLike() {
        return like();
    }

    @Override
    public boolean isConstrained() {
        return false;
    }

    @Override
    public int getSize() {
        return 1;
    }
}
