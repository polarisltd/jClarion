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

    private int value;
    private int encoding=LONG;
    
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
        value=number;
    }

    /**
     * Create number of specified value
     * 
     * @param value
     */
    public ClarionNumber(String value)
    {
        this(Integer.parseInt(value));
    }

    public String toString()
    {
        return String.valueOf(value);
    }
    
    @Override
    public void concatSegment(StringBuilder target)
    {
        target.append(value);
    }
    
    /**
     * Clone number
     * 
     * @return
     */
    public ClarionNumber like()
    {
        ClarionNumber n = new ClarionNumber();
        n.value=value;
        n.encoding=encoding;
        return n;
    }
    
    @Override
    public ClarionObject add(ClarionObject object) 
    {
        if (object.isDecimal()) return getDecimal().add(object);
        return new ClarionNumber(value+object.intValue());
    }

    @Override
    public void setValue(ClarionObject object) 
    {
        int new_value = object==null? 0 : object.intValue();
        if (new_value!=value) {
            value=new_value;
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
        
        int diff = value - object.intValue();
        if (diff<0) return -1;
        if (diff>0) return 1;
        return 0;
    }


    @Override
    public int intValue() {
        return value;
    }


    @Override
    public ClarionObject multiply(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().multiply(object);
        return new ClarionNumber(value*object.intValue());
    }
    
    /**
     * return 1d array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0'
     */ 
    public ClarionNumber[] dim(int size)
    {
        ClarionNumber r[] = new ClarionNumber[size+1];
        for (int scan=1;scan<=size;scan++) {
            r[scan]=like();
        }
        return r;
    }
    
    public ClarionNumber[] setOverAndDim(ClarionObject over,int size)
    {
        ClarionNumber r[] = dim(size);
        setOver(r,over);
        return r;
    }

    /**
     * return 2d array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0'
     */ 
    public ClarionNumber[][] dim(int s1,int s2)
    {
        ClarionNumber r[][] = new ClarionNumber[s1+1][s2+1];
        for (int scan_1=1;scan_1<=s1;scan_1++) {
            for (int scan_2=1;scan_2<=s2;scan_2++) {
                r[scan_1][scan_2]=like();
            }
        }
        return r;
    }

    /**
     * return 3d array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0'
     */ 
    public ClarionNumber[][][] dim(int s1,int s2,int s3)
    {
        ClarionNumber r[][][] = new ClarionNumber[s1+1][s2+1][s3+1];
        for (int scan_1=1;scan_1<=s1;scan_1++) {
            for (int scan_2=1;scan_2<=s2;scan_2++) {
                for (int scan_3=1;scan_3<=s3;scan_3++) {
                    r[scan_1][scan_2][scan_3]=like();
                }
            }
        }
        return r;
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
        return new ClarionReal(value);
    }


    @Override
    public ClarionString getString() {
        return new ClarionString(String.valueOf(value));
    }


    @Override
    public ClarionObject divide(ClarionObject object) {
        
        if (object  instanceof ClarionNumber) {
            int denom = ((ClarionNumber)object).value;
            if (denom==0) return new ClarionNumber(0);
            if (value%denom==0) return new ClarionNumber(value/denom);
        }
        
        //if (object.isDecimal()) return getDecimal().divide(object);
        //return new ClarionNumber(value/object.intValue());
        return getDecimal().divide(object);
    }


    @Override
    public ClarionObject modulus(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().modulus(object);
        return new ClarionNumber(value%object.intValue());
    }


    @Override
    public ClarionObject power(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().power(object);
        
        return new ClarionNumber(
                java.math.BigInteger.valueOf(value).pow(object.intValue()).intValue());
    }


    @Override
    public ClarionObject subtract(ClarionObject object) {
        if (object.isDecimal()) return getDecimal().subtract(object);
        return new ClarionNumber(value-object.intValue());
    }


    @Override
    public boolean boolValue() {
        return value!=0;
    }


    @Override
    public void clear(int method) {
        if (method==0) setValue(0);
        if (method>0) setValue(0x7fffffff);
        if (method<0) setValue(0x80000000);
    }


    @Override
    public ClarionObject negate() {
        return new ClarionNumber(-value);
    }


    @Override
    public ClarionDecimal getDecimal() {
        return new ClarionDecimal(java.math.BigDecimal.valueOf(value));
    }

    /**
     * Return absolute value for this object
     * 
     * @return
     */
    public ClarionNumber abs()
    {
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
    public void deserialize(InputStream is) throws IOException {
        //if (encoding==DATE) throw new RuntimeException("Not yet implemented");
        //if (encoding==TIME) throw new RuntimeException("Not yet implemented");
        
        int new_value=0;
        int v;

        if ((encoding & 0x70)!=0) {
            v = is.read();
            if (v==-1) throw new RuntimeException("Unexpected EOF");
            new_value=(v&0xff);
        }

        if ((encoding & 0x60)!=0) {
            v = is.read();
            if (v==-1) throw new RuntimeException("Unexpected EOF");
            new_value+=((v&0xff)<<8);
        }
        
        if ((encoding & 0x40)!=0) {
            v = is.read();
            if (v==-1) throw new RuntimeException("Unexpected EOF");
            new_value+=((v&0xff)<<16);
            v = is.read();
            if (v==-1) throw new RuntimeException("Unexpected EOF");
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
    public void serialize(OutputStream os) throws IOException {
    
        if (encoding==DATE) {
            //throw new RuntimeException("Not yet implemented");
        }
        if (encoding==TIME) {
            //throw new RuntimeException("Not yet implemented");
        }

        if ((encoding & 0x70)!=0) {
            os.write(value);
        }

        if ((encoding & 0x60)!=0) {
            os.write(value>>8);
        }
        
        if ((encoding & 0x40)!=0) {
            os.write(value>>16);
            os.write(value>>24);
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
    
}
