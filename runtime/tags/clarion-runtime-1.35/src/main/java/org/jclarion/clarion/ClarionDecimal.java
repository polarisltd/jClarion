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

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;

/**
 * Model decimal. Internall stored as java.math.BigDecimal
 * 
 * @author barney
 *
 */
public class ClarionDecimal extends ClarionObject 
{
    public static final int DECIMAL = 1;
    public static final int PDECIMAL = 2;
    
    /**
     *  Value of decimal
     */
    private BigDecimal value;
    
    /**
     * Max size of the decimal. -1 = no limit.
     */
    private int size;
    
    /**
     *  Number of bits reserved for precision. -1 = no limit
     */
    private int precision;

    private int encoding=DECIMAL;
    
    /**
     * Create new clarion decimal. Unbounded size and precision. Defaults to 0
     */
    public ClarionDecimal()
    {
        value = BigDecimal.ZERO;
        size=-1;
        precision=-1;
    }

    @Override
    public boolean isConstrained() 
    {
        return size!=-1 || precision!=-1;
    }
    
    
    /**
     * Create new clarion decimal with given value. Size and precision are
     * unbounded
     */
    public ClarionDecimal(String value)
    {
        try {
            this.value = new BigDecimal(value);
        } catch (NumberFormatException ex) {
            this.value =BigDecimal.ZERO;
        }
        size=-1;
        precision=-1;
    }

    public ClarionDecimal(BigDecimal value)
    {
        this.value = value;
        size=-1;
        precision=-1;
    }

    /**
     * Create new clarion decimal with given size and zero precision.
     * Default value is 0
     */
    public ClarionDecimal(int value)
    {
        this.size=-1;
        precision=-1;
        
        this.value = BigDecimal.valueOf(value);
    }

    /**
     * Create new clarion decimal with given size and precision.
     * Default value is 0
     */
    public ClarionDecimal(int size,int precision)
    {
        this.size=size;
        this.precision=precision;
        this.value = cleanValue(BigDecimal.ZERO);
    }

    /**
     * Create new clarion decimal with given size and precision and value
     */
    public ClarionDecimal(int size,int precision,Object value)
    {
        this.size=size;
        this.precision=precision;
        try {
            this.value = cleanValue(new BigDecimal(value.toString()));
        } catch (NumberFormatException ex) {
            this.value = cleanValue(BigDecimal.ZERO);
        }
    }
    
    public String toString()
    {
        return value.toPlainString();
    }

    /**
     * clone object
     * @return
     */
    public ClarionDecimal like()
    {
        ClarionDecimal n = new ClarionDecimal(size,precision,value);
        n.setEncoding(encoding);
        return n;
    }
    
    /**
     * return array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0' 
     * 
     * @param size
     * @return
     */
    public ClarionDecimal[] dim(int size)
    {
        ClarionDecimal r[] = new ClarionDecimal[size+1];
        for (int scan=1;scan<=size;scan++) {
            r[scan]=like();
        }
        return r;
    }

    /**
     * return 2d array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0'
     */ 
    public ClarionDecimal[][] dim(int s1,int s2)
    {
        ClarionDecimal r[][] = new ClarionDecimal[s1+1][s2+1];
        for (int scan_1=1;scan_1<=s1;scan_1++) {
            for (int scan_2=1;scan_2<=s2;scan_2++) {
                r[scan_1][scan_2]=like();
            }
        }
        return r;
    }
    

    @Override
    public ClarionObject add(ClarionObject object) {
        return new ClarionDecimal(value.add(object.getDecimal().value));
    }

    @Override
    public int compareTo(ClarionObject object) {
        if (object instanceof ClarionString) {
            return -object.compareTo(this);
        }
        if (object instanceof ClarionReal) {
            return -object.compareTo(this);
        }
        return value.compareTo(object.getDecimal().value);
    }

    @Override
    public int intValue() {
        BigInteger i = value.toBigInteger();
        if (i.bitLength()>31) return 0; // number too big
        return i.intValue();
    }

    @Override
    public ClarionObject multiply(ClarionObject object) {
        return new ClarionDecimal(value.multiply(object.getDecimal().value));
    }

    @Override
    public void setValue(ClarionObject object) {
        BigDecimal new_value;
        if (object==null) {
            new_value=BigDecimal.ZERO;
        } else {
            new_value=cleanValue(object.getDecimal().value);
        }
        
        if (new_value.compareTo(value)!=0) {
            value=new_value;
            notifyChange();
        }
    }
    
    private BigDecimal cleanValue(BigDecimal i)
    {
        if (size==-1) return i;
        
        if (i.scale()!=precision) {
            i=i.setScale(precision,BigDecimal.ROUND_HALF_UP);
        }
        
        if (i.precision()>size) {
            
            char bits[] = new char[size];
            for (int scan=0;scan<bits.length;scan++) {
                bits[scan]='9';
            }
            BigInteger bi = new BigInteger(new String(bits));
            if (i.signum()<0) bi=bi.negate();
            i=new BigDecimal(bi,precision);
        }
        
        return i;
    }
    
    @Override
    public ClarionBool getBool() {
        return new ClarionBool(boolValue());
    }

    @Override
    public ClarionNumber getNumber() {
        return new ClarionNumber(value.intValue());
    }

    @Override
    public ClarionReal getReal() {
        return new ClarionReal(value.doubleValue());
    }

    @Override
    public ClarionString getString() {
        return new ClarionString(toString());
    }

    @Override
    public ClarionObject divide(ClarionObject object) {
        
        BigDecimal denom = object.getDecimal().value;
        if (denom.signum()==0) return new ClarionNumber(0);
        return new ClarionDecimal(value.divide(denom,MathContext.DECIMAL64));
    }

    @Override
    public ClarionObject modulus(ClarionObject object) {
        return new ClarionDecimal(value.remainder(object.getDecimal().value));
    }

    @Override
    public ClarionObject power(ClarionObject object) {
        return new ClarionDecimal(value.pow(object.intValue()));
    }

    @Override
    public ClarionObject subtract(ClarionObject object) {
        return new ClarionDecimal(value.subtract(object.getDecimal().value));
    }

    @Override
    public boolean boolValue() {
        return value.signum()!=0;
    }

    @Override
    public void clear(int method) {
        
        if (method==0) {
            setValue(BigDecimal.ZERO);
            return;
        }
        
        if (size==-1) {
            setValue(BigDecimal.ZERO);
            return;
        }
        
        char bits[] = new char[size];
        for (int scan=0;scan<bits.length;scan++) {
            bits[scan]='9';
        }
        BigInteger bi = new BigInteger(new String(bits));
        if (method<0) bi=bi.negate();
        setValue(new BigDecimal(bi,precision));
    }
    
    @Override
    public ClarionObject negate() {
        return new ClarionDecimal(value.negate());
    }

    @Override
    public ClarionDecimal getDecimal() {
        return this;
    }

    /**
     * Set external name, used by sql drivers etc
     * 
     * @param name
     * @return
     */
    public ClarionDecimal setName(String name)
    {
        doSetName(name);
        return this;
    }
 
    /**
     * Set memory model for encoding this object. Two options exists DECIMAL 
     * and PDECIMAL
     * 
     * @param encoding
     * @return
     */
    public ClarionDecimal setEncoding(int encoding)
    {
        this.encoding=encoding;
        return this;
    }

    /**
     * Return absolute value
     * 
     * @return
     */
    public ClarionDecimal abs()
    {
        return new ClarionDecimal(value.abs());
    }
    
    /**
     * Return rounded value. Rounding to nearest value specified by object.
     * This implementation differs from Clarion implementation in that
     * it will round to nearest multiple of the value. i.e. rounding to 0.55
     * will round to nearest multiple of 0.55, whereas clarion will convert 0.55
     * to '1' and round to that.
     * 
     * Rounding is Half Up based rounding.
     * 
     * @param object
     * @return
     */
    public ClarionDecimal round(ClarionObject object)
    {
        BigDecimal n = value;
        BigDecimal d = object.getDecimal().value;
        n = n.divide(d, 0, BigDecimal.ROUND_HALF_UP).multiply(d);
        return new ClarionDecimal(n);
    }

    public ClarionDecimal round(Object object)
    {
        return round(Clarion.getClarionObject(object));
    }

    /** 
     * Overlay this object with specified object
     *
     * @param object
     * @return
     */
    public ClarionDecimal setOver(ClarionMemoryModel object)
    {
        doSetOver(object);
        return this;
    }

    @Override
    public void deserialize(InputStream is) throws IOException {
        
        //BigInteger bi = value.unscaledValue();
        boolean negate=false;

        int read=size/2+1;
        
        int val=-1;
        
        if (encoding==DECIMAL) {
            val = is.read();
            read--;
            if (val==-1) throw new IOException("Unexpected EOF");
            
            if ((val&0xf0)!=0) {
                negate=true;
                val=val&0x0f;
            }
        }
        
        BigInteger result = BigInteger.ZERO;
        
        while ( true ) {
            if (val!=-1) {
                
                int hi = (val>>4)&0x0f;
                int lo = (val)&0x0f;
                int mul;
                int nval;
                if (encoding==PDECIMAL && read==0) {
                    mul=10;
                    nval=hi;
                    if (lo==0x0d) negate=true;
                } else {
                    mul=100;
                    nval=hi*10+lo;
                }
                result=result.multiply(BigInteger.valueOf(mul)).add(BigInteger.valueOf(nval));
            }
            
            if (read==0) break;
            
            val=is.read();
            read--;
            if (val==-1) throw new IOException("Unexpected EOF");
        }
        
        if (negate) result=result.negate();
        
        setValue( new BigDecimal(result,precision) );
    }

    /**
     * Decimal encoding is based on nybbles.
     * Nybble 0 = sign
     * Nybble 1 = MSD (most significant decimal)
     * Nybble 2 = LSD (least significant decimal)
     * 
     * Decimal always encodes odd # of places.
     * 
     */
    @Override
    public void serialize(OutputStream is) throws IOException 
    {
        if (size==-1) {
            getString().serialize(is);
            return;
        }
        
        byte result[] = new byte[size/2+1];
        BigInteger bi = value.unscaledValue().abs();
            
        int scan=0;
        if (encoding==PDECIMAL) {
            BigInteger results[] =bi.divideAndRemainder(BigInteger.TEN);
            bi=results[0];
            int val = results[1].intValue();
            result[result.length-1-scan]=(byte)((val)<<4);
            scan++;
        }
        
        while (bi.signum()>0) {
            BigInteger results[] =bi.divideAndRemainder(BigInteger.valueOf(100));
            bi=results[0];
                
            int val = results[1].intValue();
            try {
                result[result.length-1-scan]=(byte)(((val/10)<<4)+(val%10));
            } catch (ArrayIndexOutOfBoundsException ex) {
                throw(ex);
            }
            scan++;
        }
        if (encoding==DECIMAL) {
            if (value.signum()<0) {
                result[0]=(byte)(result[0]|0x80);
            }
        } else {
            if (value.signum()>0) {
                result[result.length-1]=(byte)(result[result.length-1]|0x0c);
            } else {
                result[result.length-1]=(byte)(result[result.length-1]|0x0d);
            }
        }
        is.write(result);
    }
    
    public boolean isDecimal()
    {
        return true;
    }

    @Override
    public ClarionObject genericLike() {
        return like();
    }
}