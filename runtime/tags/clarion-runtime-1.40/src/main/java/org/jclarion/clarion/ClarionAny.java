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

import org.jclarion.clarion.runtime.CMemory;

public class ClarionAny extends ClarionObject implements ClarionMemoryChangeListener
{

    private ClarionObject value; 
    private ClarionObject reference; 

    public ClarionAny()
    {
        this(new ClarionString(""));
    }

    public ClarionAny(ClarionObject value)
    {
        setValue(value);
    }

    protected ClarionAny(ClarionObject value,ClarionObject reference)
    {
        if (reference!=null) {
            this.value=value;
            this.reference=reference;
        } else {
            this.value=value.genericLike();
        }
    }

    public ClarionAny like()
    {
        return (ClarionAny)genericLike();
    }
    
    public String toString()
    {
        return value.toString();
    }
    
    @Override
    public ClarionObject add(ClarionObject object) {
        return value.add(object);
    }

    @Override
    public boolean boolValue() {
        return value.boolValue();
    }

    @Override
    public void clear(int method) {
        value.clear(method);
    }

    @Override
    public int compareTo(ClarionObject object) {
        return value.compareTo(object);
    }

    @Override
    public ClarionObject divide(ClarionObject object) {
        return value.divide(object);
    }

    @Override
    public ClarionObject genericLike() {
        return new ClarionAny(value,reference);
    }

    @Override
    public ClarionBool getBool() {
        return value.getBool();
    }

    @Override
    public ClarionDecimal getDecimal() {
        return value.getDecimal();
    }

    @Override
    public ClarionNumber getNumber() {
        return value.getNumber();
    }

    @Override
    public ClarionReal getReal() {
        return value.getReal();
    }

    @Override
    public ClarionString getString() {
        return value.getString();
    }

    @Override
    public int intValue() {
        return value.intValue();
    }

    @Override
    public ClarionObject modulus(ClarionObject object) {
        return value.modulus(object);
    }

    @Override
    public ClarionObject multiply(ClarionObject object) {
        return value.multiply(object);
    }

    @Override
    public ClarionObject negate() {
        return value.negate();
    }

    @Override
    public ClarionObject power(ClarionObject object) {
        return value.power(object);
    }

    @Override
    public void setValue(ClarionObject object) {
        setValue(object,true);
    }

    public void setReferenceValue(ClarionObject object)
    {
        ClarionObject new_reference=null;
        
        if (object!=null) {
            object=object.getValue();
            new_reference=object;
            value=object;
        } else {
            new_reference=null;
            value=new ClarionString("");
        }
        
        if (new_reference!=reference) {
            reference=new_reference;
            notifyChange();
        }
    }

    public void setValue(ClarionObject object,boolean clone) {

        object=object.getValue();

        if (reference!=null) {
            reference.setValue(object);
            return;
        } 
        
        if (clone) object=object.genericLike();
        if (object==value) return;
        
        //if (this.value!=null) {
        //    this.value.removeChangeListener(this);
        //}
        
        this.value=object;
        
        //this.value.addChangeListener(this);
        
        notifyChange();
    }

    @Override
    public ClarionObject subtract(ClarionObject object) {
        return value.subtract(object);
    }

    /**
     * Assuming that serialization is serialization of address only
     */
    @Override
    public void deserialize(InputStream is) throws IOException {
        
        int m=0;
        
        m=0;
        for (int scan=0;scan<4;scan++) {
            int r = is.read();
            if (r==-1) throw new IOException("Unexpected EOF");
            m=(m<<8)+(r&0xff);
        }
        ClarionObject nv = (ClarionObject)CMemory.resolveAddress(m);
        if (nv==null) throw new RuntimeException("Address invalid");

        m=0;
        for (int scan=0;scan<4;scan++) {
            int r = is.read();
            if (r==-1) throw new IOException("Unexpected EOF");
            m=(m<<8)+(r&0xff);
        }
        ClarionObject nr = (ClarionObject)CMemory.resolveAddress(m);
     
        if (nv==value && nr==reference) return;
        this.value=nv;
        this.reference=nr;
        notifyChange();
    }

    @Override
    public void serialize(OutputStream os) throws IOException {
        
        int m = CMemory.address(value);
        
        os.write(m>>24);
        os.write(m>>16);
        os.write(m>>8);
        os.write(m);

        m = CMemory.address(reference);
        
        os.write(m>>24);
        os.write(m>>16);
        os.write(m>>8);
        os.write(m);
    }

    @Override
    public void objectChanged(ClarionMemoryModel model) {
        if (model!=value) return;
        notifyChange();
    }

    @Override
    public ClarionObject getValue()
    {
        return value.getValue();
    }

    public ClarionObject getReference()
    {
        return reference;
    }

    @Override
    public boolean isConstrained() 
    {
        return false;
    }

    @Override
    public ClarionObject getThreadLockedClone() {
        return this;
    }

    @Override
    public int getSize() {
        return -1;
    }
}
