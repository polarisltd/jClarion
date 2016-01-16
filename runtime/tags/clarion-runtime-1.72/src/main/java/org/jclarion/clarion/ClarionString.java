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

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jclarion.clarion.constants.Match;
import org.jclarion.clarion.lang.Constant;
import org.jclarion.clarion.lang.StringEncoding;
import org.jclarion.clarion.memory.CMem;
import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.ThreadStateGetter;
import org.jclarion.clarion.runtime.format.Formatter;


/**
 * Model a string in clarion
 * 
 * Internal storage of string uses following parameters:
 * 
 *  lState.string           - String
 *  lState.chararray        - chararray
 *  lState.chararray_len    - string len in char array
 *  
 *  lState.chararry is the accurate representation. and lState.string is non null
 *  when requested and chararray has not subsequently mutated
 *  
 *  it is possible for string to be defined by chararray not to be defined
 *  when first mutation is needed - chararray is retrieved from the string
 * 
 * 
 * @author barney
 *
 */
public class ClarionString extends ClarionObject 
{
    public static final int STRING=1;
    public static final int CSTRING=2;
    public static final int PSTRING=3;
    public static final int ASTRING=4;

    private boolean contentConstructed;     // true if object was constructed via content
    private int encoding=STRING;
    private int size=-1;

    public static class State
    {
        private String string;
        private char[] chararray;
        private int    len;

        public State(ClarionString.State base) {
            string=base.string;
            len=base.len;
            if (base.chararray!=null) chararray=base.chararray.clone(); 
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
    
    public ClarionString setThread()
    {
        initThread();
        return this;
    }
    
    @Override
    public Object getLockedObject(Thread t) 
    {
        if (!state.isThreaded()) return this;
        return new ClarionString(this,t);
    }
    
    public ClarionString(ClarionString base,Thread lock)
    {
        super(base,lock);
        this.encoding=base.encoding;
        this.contentConstructed=base.contentConstructed;
        this.size=base.size;
        if (lock!=null) this.state=base.state.getLockedGetter(lock);
    }
    
    
    
    /**
     * Create undefined string
     */
    public ClarionString()
    {
    }

    /**
     * Create empty string of specified size. space padded.
     */
    public ClarionString(int size)
    {
        this.size=size;
        clear();
    }

    /**
     * Create string of given size defaulted to specified content.
     */
    public ClarionString(String content)
    {
        State lState = state.get();

        this.size=content.length();
        this.contentConstructed=true;

        lState.string=content;
    }

    /**
     * Create string of given size defaulted to specified content.
     */
    public ClarionString(char content[])
    {
        State lState = state.get();

        this.size=content.length;
        lState.chararray=content;
        lState.len=content.length;
    }
    
    public String toString()
    {
        State lState = state.get();
        
        if (lState.string==null) { 
            if (lState.chararray!=null) {
                lState.string=new String(lState.chararray,0,lState.len);
            } else if (size==-1) {
                lState.string="";
            }
        }
        return lState.string;
    }
    
    /**
     * clone string
     * 
     * @return
     */
    public ClarionString like()
    {
        ClarionString cs = new ClarionString();
        cs.encoding=this.encoding;
        cs.size=this.size;
        cs.state.get().string=this.toString();
        return cs;
    }
    
    private void getChars(int begin,int end,char dest[],int d_ofs)
    {
        State lState = state.get();
        
        if (lState.chararray!=null) {
            System.arraycopy(lState.chararray,begin,dest,d_ofs,end-begin);
            return;
        }
        
        if (lState.string!=null) {
            lState.string.getChars(begin,end, dest,d_ofs);
            return;
        }
    }
    
    
    private char charAt(int ofs)
    {
        State lState = state.get();

        if (lState.chararray!=null) {
            if (ofs<0 || ofs>=lState.len) return 0;
            return lState.chararray[ofs];
        }
        
        if (lState.string!=null) {
            if (ofs<0 || ofs>=lState.string.length()) return 0;
            return lState.string.charAt(ofs);
        }
        return 0;
    }
    
    private int getLength()
    {
        State lState = state.get();

        if (lState.chararray!=null) {
            return lState.len;
        }
        if (lState.string!=null) {
            return lState.string.length();
        }
        return 0;
    }

    private boolean getCharArray(int len,boolean cloneIfTooSmall)
    {
        State lState = state.get();

        int size=allowedSize();
        if (lState.chararray==null) {
            if (lState.string==null) {
                lState.chararray=new char[size>len?size:len];
                lState.len=0;
            } else {
                lState.chararray=lState.string.toCharArray();
                lState.len=lState.chararray.length;
            }
        }
        
        if (lState.chararray.length<len) {
            char t[]=new char[size>len?size:len];
            if (cloneIfTooSmall) {
                System.arraycopy(lState.chararray,0,t,0,lState.len);
            } else {
                lState.len=0;
            }
            lState.chararray=t;
            lState.string=null;
            return true;
        }
        return false;
    }

    private boolean writeAndReportChange(ClarionString source,int len)
    {
        return writeAndReportChange(0,source,len);
    }
    
    private boolean writeAndReportChange(int ofs,ClarionString source,int len)
    {
        State lState = state.get();

        boolean change=getCharArray(ofs+len,false);
        if (!change && !isAnyoneInterestedInChange()) change=true; 

        lState.len=ofs+len;
        
        if (!change) {
            while (len>0) {
                len--;
                char c = source.charAt(len);
                if (c!=lState.chararray[ofs+len]) {
                    change=true;
                    lState.chararray[ofs+len]=c;
                    break;
                }
                lState.chararray[ofs+len]=c;
            }
        }
        if (len>0) {
            source.getChars(0,len,lState.chararray,ofs);
        }
        
        return change;
    }
    
    @Override
    public void setValue(ClarionObject object) {
        State lState = state.get();
        
        ClarionString st = null;
        if (object!=null) {
            st = object.getString();
        } else {
            st=new ClarionString();
        }

        int allowedSize=allowedSize();

        if (allowedSize==-1) {
            // when size of recipient string is not restricted
        	int o_len = getLength();
            if (writeAndReportChange(st,st.getLength())) {
                lState.string=null;
                notifyChange();
            } else {
                if (lState.string!=null && lState.len!=lState.string.length()) {
                    lState.string=null;
                    notifyChange();
                } else if (o_len != getLength()) {
                	notifyChange();
                }
            }
            return;
        }

        if (encoding==STRING) {
            getCharArray(0,false);
            if (st.getLength()<size) {
                boolean change = writeAndReportChange(st,st.getLength());
                while (lState.len<size) {
                    if (lState.chararray[lState.len]!=' ') {
                        lState.chararray[lState.len]=' ';
                        change=true;
                    }
                    lState.len++;
                }
                if (change) {
                    lState.string=null;
                    notifyChange();
                }
                return;
            } else {
                if (writeAndReportChange(st,size)) {
                    lState.string=null;
                    notifyChange();
                }
                return;
            }
        }
        
        if (st.getLength()>allowedSize) {
            if (writeAndReportChange(st,allowedSize)) {
                lState.string=null;
                notifyChange();
            }
            return;
        } else {
            
            boolean lengthChange = encoding!=STRING && getLength()!=st.getLength();
            
            if (writeAndReportChange(st,st.getLength())) {
                lState.string=null;
                notifyChange();
            }
            
            if (lengthChange) {
                lState.string=null;
                notifyChange(); 
            }
            
            return;
        }
    }

    @Override
    public ClarionObject add(ClarionObject object) {
        return toNumber().add(object);
    }

    @Override
    public int compareTo(ClarionObject object) {
        
        object=object.getValue();
        
        if (object instanceof ClarionNumber || object instanceof ClarionDecimal || object instanceof ClarionReal || object instanceof ClarionBool) 
        {
            boolean numeric=true;
            
            for (int scan=getLength()-1;scan>=0;scan--) {
                char c=charAt(scan);
                if (c!=' ' && c!=0) {
                    numeric=false;
                }
            }
            if (!numeric) numeric=isNumeric(true,false);
            
            if (numeric) {
                if (isDecimal()) {
                    return getDecimal().compareTo(object);
                } else {
                    return getNumber().compareTo(object);
                }
            }
        }
        
        ClarionString r = object.getString();
        
        int l1 = getLength();
        int l2 = r.getLength();
        
        while (l1>0) {
            char f = charAt(l1-1);
            if (f!=' ') break;
            l1--;
        }

        while (l2>0) {
            char f = r.charAt(l2-1);
            if (f!=' ') break;
            l2--;
        }
        
        
        int min = l1;
        if (l2<l1) min=l2;
        
        for (int scan=0;scan<min;scan++) {
            int diff = charAt(scan)-r.charAt(scan);
            if (diff<0) return -1;
            if (diff>0) return 1;
        }
        
        if (l1<l2) return -1;
        if (l1>l2) return 1;
        
        return 0;
    }

    @Override
    public int intValue() {
        if (isNumeric(false)) {
            try {
                return Integer.parseInt(toString().trim());
            } catch (NumberFormatException ex) { 
                return 0;
            }
        }
        if (isNumeric(true)) {
            
            String bit = toString();
            int dot = bit.indexOf('.');
            if (dot==0) return 0;
            try {
                return Integer.parseInt(bit.substring(0,dot).trim());
            } catch (NumberFormatException ex) { 
                return 0;
            }
        }
        return 0;
    }

    @Override
    public ClarionObject multiply(ClarionObject object) 
    {
        return toNumber().multiply(object);
    }

    /**
     *  Set external name for the object - used by external systems like SQL driver
     * @param name
     * @return
     */
    public ClarionString setName(String name)
    {
        doSetName(name);
        return this;
    }


    /**
     * return 1d array clone of the object based on size. Note java object
     * array returned is one larger than specified as clarion starts arrays at
     * offset '1' whilst java as offset '0'
     */ 
    public ClarionArray<ClarionString> dim(int size)
    {
    	return new ClarionArray<ClarionString>(this,size);
    }
    

    
    /**
     * Set string encoding. A few options exists
     * 
     * String - fixed width
     * pstring - fixed width memory footprint but first char specifies string length 
     * cstring - fixed width memory footprint - 0x00 terminated string 
     * astring - no idea 
     * 
     * @param encoding
     * @return
     */
    public ClarionString setEncoding(int encoding)
    {
        State lState = state.get();

        if (contentConstructed) {
            size++; // resize in memory
        } else {
            if (encoding!=STRING) {
                lState.string=null;
                lState.chararray=new char[0];
                lState.len=0;
            }
        }
        this.encoding=encoding;
        return this;
    }

    /**
     * Overlay string onto another clarion object
     * 
     * @param o
     * @return
     */
    public ClarionString setOver(ClarionMemoryModel o)
    {
        doSetOver(o);
        return this;
    }


    @Override
    public ClarionObject divide(ClarionObject object) {
        return toNumber().divide(object);
    }

    @Override
    public ClarionBool getBool() {
        return new ClarionBool(boolValue());
    }

    @Override
    public ClarionNumber getNumber() {
        return new ClarionNumber(intValue());
    }

    @Override
    public ClarionReal getReal() {
        return new ClarionReal(toString().trim());
    }

    @Override
    public ClarionString getString() {
        return this;
    }

    @Override
    public ClarionObject modulus(ClarionObject object) {
        return toNumber().modulus(object);
    }

    @Override
    public ClarionObject power(ClarionObject object) {
        return toNumber().power(object);
    }

    @Override
    public ClarionObject subtract(ClarionObject object) {
        return toNumber().subtract(object);
    }

    @Override
    public boolean boolValue() {
        for (int scan=0;scan<getLength();scan++) {
            char f = charAt(scan);
            if (f!=' ' && f!='\u0000') return true;
        }
        return false;
    }

    @Override
    public void clear(int method) {
        
        boolean zero=false;
        int size=allowedSize();
        char fill=' ';
        
        if (method==0) {
            if (encoding==STRING) {
            } else {
                zero=true;
            }
        }
        if (method<0) {
            if (encoding==STRING) {
                fill='\u0000';
            } else {
                zero=true;
            }
        }
        if (method>0) {
            if (encoding==STRING) {
                fill='\u00ff';
            } else {
                if (size==-1) {
                    size=1;
                }
                fill='\u00ff';
            }
        }
        
        if (zero || size<=0) {
            setValue("");
        } else {
            char nstring[]=new char[size];
            for (int i=0;i<nstring.length;i++) {
                nstring[i]=fill;
            }
            setValue(new String(nstring));
        }
    }

    /**
     *  Modify contents of char at given position
     * @param index
     * @param string
     */
    public void setStringAt(ClarionObject index,ClarionObject string) 
    {
        State lState = state.get();

        int i = index.intValue();
        if (i<0) throw new IllegalArgumentException("Index invalid. i="+i);
        if (i>size && size>=0) throw new IllegalArgumentException("Index invalid. i="+i+" size:"+size);

        ClarionString s = string.getString();
        if (s.getLength()==0) throw new IllegalArgumentException("String invalid");

        i--;
        boolean change = getCharArray(i+1,true);
        while (lState.len<i) {
            lState.chararray[lState.len++]=' ';
        }
        if (!change) {
            char c = s.charAt(0);
            if (c!=lState.chararray[i]) { 
                lState.chararray[i]=c;
                change=true;
            }
        } else {
            lState.chararray[i]=s.charAt(0);
        }
        if (lState.len==i) {
            lState.len++;
            change=true;
        }
        lState.string=null;
        
        if (change) notifyChange();
    }
    
    public void setStringAt(Object from,Object string) 
    {
        setStringAt(Clarion.getClarionObject(from),Clarion.getClarionObject(string));
    }

    /**
     *  Modify contents of string at given position
     * @param index
     * @param string
     */
    public void setStringAt(ClarionObject from,ClarionObject to,ClarionObject string) {
        State lState = state.get();

        int f = from.intValue();
        int t = to.intValue();
        if (f<0) throw new IllegalArgumentException("Index invalid");
        if (f>t) throw new IllegalArgumentException("Index invalid"); 
        if (t>size && size>=0) throw new IllegalArgumentException("Index invalid");

        ClarionString s = string.getString();
        int size = t-f+1;
        f--;
        t--;
        boolean change = getCharArray(t+1,true);
        while (lState.len<=t) {
            lState.chararray[lState.len++]=' ';
        }

        int l = lState.len;
        
        if (size>s.getLength()) {
            if (writeAndReportChange(f,s,s.getLength())) change=true;
            size-=s.getLength();
            f+=s.getLength();
        } else {
            if (writeAndReportChange(f,s,size)) change=true;
            size=0;
        }

        lState.len=l;
        
        while (size>0) {
            if (!change && lState.chararray[f]!=' ') {
                change=true;
            }
            lState.chararray[f]=' ';
            f++;
            size--;
        }
        lState.string=null;
        if (change) {
            notifyChange();
        }
    }

    public void setStringAt(Object from,Object to,Object string) {
        setStringAt(
                Clarion.getClarionObject(from),
                Clarion.getClarionObject(to),
                Clarion.getClarionObject(string));
    }
    
    /**
     *  Return source string repeated upto 255 characters
     *  
     * @param source
     * @return
     */
    public ClarionString all()
    {
        return all(255);
    }

    /**
     *  Return this string repeated upto src characters long
     *  
     * @param source
     * @return
     */
    public ClarionString all(int src)
    {
        if (getLength()==0) throw new IllegalStateException("Cannot report empty string");
        
        char result[]=new char[src];
        
        int scan=0;
        while (scan<result.length) {
            int scanTo = scan + getLength();
            if (scanTo>result.length) scanTo=result.length;
            
            getChars(0,scanTo-scan,result,scan);
            scan=scanTo;
        }
        return new ClarionString(result);
    }
    
    
    @Override
    public ClarionObject negate() {
        return toNumber().negate();
    }

    /**
     * Return ascii character value of string (assume 1 char string)
     * @return
     */
    public int val()
    {
        if (getLength()>0) return charAt(0);
        return 32;
    }

    /**
     * Return true is string encodes a legitimate numeric
     * @return
     */
    public boolean isNumeric()
    {
        return isNumeric(true);
    }

    /**
     * return true if string is upper case. If string length>1 then
     * only test first char 
     * 
     * @return
     */
    public boolean isUpper()
    {
        if (getLength()==0) return false;
        char c = charAt(0);
        return (c>='A' && c<='Z');
    }

    /**
     * return true if string is only alpha characters.If string length>1 then
     * only test first char 
     * @return
     */
    public boolean isAlpha()
    {
        if (getLength()==0) return false;
        char c = charAt(0);
        return ( (c>='A' && c<='Z') || (c>='a' && c<='z') );
    }

    @Override
    public ClarionDecimal getDecimal() {
        return new ClarionDecimal(toString().trim());
    }

    /**
     * Format string as per specified picture formatter
     * 
     * @param aFormat
     * @return
     */
    public ClarionString format(String aFormat)
    {
        Formatter f = Formatter.construct(aFormat);
        return new ClarionString(f.format(toString()));
    }
    
    /**
     * Remove formatting characters from format
     * 
     * For numeric - remove everything but numeric formatters
     * 
     * For date, convert back to date format
     * 
     * For time, convert back to time format
     * 
     * For picture/key tokens return placeholder tokens
     * 
     * @param aFormat
     * @return
     */
    public ClarionString deformat(String aFormat)
    {
        Formatter f = Formatter.construct(aFormat);
        return new ClarionString(f.deformat(toString()));
    }

    /**
     * Get string length - result dependent upon encoding system used
     * 
     * @return
     */
    public int len() {
        if (encoding==STRING && size>=0) {
            return size;
        }
        return getLength();
    }

    /** 
     * Convert ascii code into a string
     * 
     * @param ascii
     * @return
     */
    public static ClarionString chr(int ascii) {
        return new ClarionString(String.valueOf((char)ascii));
    }

    /**
     * Return string left shifted.
     * 
     * @param offset - length of resultant string. 
     * @return
     */
    public ClarionString left(int offset)
    {
        char c[] = new char[offset];
        
        int len = getLength();
        int start =0;
        while (start<len) {
            if (charAt(start)!=' ') break;
            start++;
        }
        
        if (len-start>offset) len=offset+start;
        getChars(start,len,c,0);
        
        for (int scan=len-start;scan<offset;scan++) {
            c[scan]=' ';
        }
     
        return new ClarionString(c);
    }

    /**
     * return left(len())
     * @return
     */
    public ClarionString left()
    {
        return left(len());
    }

    /**
     * Return string right justified 
     * @param offset length of resultant string
     * @return
     */
    public ClarionString right(int offset)
    {
        char c[] = new char[offset];
        
        int len = getLength();
        int start =0;
        while (start<len) {
            if (charAt(len-1)!=' ') break;
            len--;
        }
        
        if (len-start>offset) start=len-offset;
        
        // RIGHT...  (start=0, len=5, offset=8)
        // ...RIGHT  
        getChars(start,len,c,offset-len+start);
        
        for (int scan=offset-len+start-1;scan>=0;scan--) {
            c[scan]=' ';
        }
     
        return new ClarionString(c);
    }

    /**
     * return right justified string
     * 
     */
    public ClarionString right()
    {
        return right(len());
    }

    /**
     * Return center justified string
     * @param offset resultant length of new string
     * @return
     */
    public ClarionString center(int offset)
    {
        char c[] = new char[offset];
        
        int len = getLength();
        int start =0;
        while (start<len) {
            if (charAt(len-1)!=' ') break;
            len--;
        }

        while (start<len) {
            if (charAt(start)!=' ') break;
            start++;
        }
        
        int size=len-start;
        
        // work out center offset for new text biased towards righting if diff is odd
        int c_offset=offset-size;
        if ((c_offset & 1) == 1) {
            c_offset=(c_offset+1)/2;
        } else {
            c_offset=c_offset/2;
        }
        
        // now if c_offset<0 then we need to realign
        if (c_offset<0) {
            start=start-c_offset;
            c_offset=0;
        }
        
        // now if length overruns offset we need to relaign that too
        if (len-start+c_offset>offset) {
            len=offset+start-c_offset;
        }
        
        getChars(start,len,c,c_offset);
        
        // left pad
        for (int scan=0;scan<c_offset;scan++) {
            c[scan]=' ';
        }
    
        // right pad
        for (int scan=len-start+c_offset;scan<offset;scan++) {
            c[scan]=' ';
        }
     
        return new ClarionString(c);
    }
    
    /**
     * Return center justified string
     * @return
     */
    public ClarionString center()
    {
        return center(len());
    }

    /**
     * return sub string from given offset. 
     * 
     * @param offset
     * @return
     */
    public ClarionString sub(int offset)
    {
        if (offset<0) offset=len()+1+offset;
        return sub(offset,len()-offset+1);
    }

    /**
     * Return sub string of offset and length
     * @param offset
     * @param len
     * @return
     */
    public ClarionString sub(int offset,int len)
    {
        int f = offset;
        if (f<0) f=len()+1+f;
        int t = f+len-1;

        if (f<=0) throw new IllegalArgumentException("Invalid position");
        if (t>size && size>=0) t=size;
        
        return stringAt(new ClarionNumber(f),new ClarionNumber(t));
    }

    /**
     * Return uppercased string
     * @return
     */
    public ClarionString upper()
    {
        return new ClarionString(toString().toUpperCase());
    }

    /**
     * Return lower cased string
     * @return
     */
    public ClarionString lower()
    {
        return new ClarionString(toString().toLowerCase());
    }

    /**
     * return clipped string - trailing whitespace removed. 
     * @return
     */
    public ClarionString clip()
    {
        int len=getLength();
        
        if (len==0) return this;
        if (charAt(len-1)!=' ') {
            return this;
        }
        len--;
        
        while (len>0) {
            if (charAt(len-1)!=' ') break;
            len--;
        }
        return new ClarionString(toString().substring(0,len));
    }

    /**
     * Find position of string in another string
     * @param search
     * @return
     */
    public int inString(String search) {
        return inString(search,search.length(),1);
    }

    /**
     * find position of a string in another string
     * @param search
     * @param step
     * @param ofs
     * @return
     */
    public int inString(String search,int step,int ofs) {
        
        int scan=ofs-1;
        while (scan+search.length()<=getLength()) {
            boolean match=true;
            for (int ss=0;ss<search.length();ss++) {
                if (charAt(scan+ss)!=search.charAt(ss)) {
                    match=false;
                    break;
                }
            }
            if (match) return scan+1;
            scan+=step;
        }
        return 0;
    }
    
    
    @SuppressWarnings("unchecked")
	@Override
    public void deserialize(CMem is)
    {
        State lState = state.get();
        if (encoding==STRING) {
            int size=allowedSize();
            if (size==-1) size=is.remaining();
            if (size==-1) size=0;
            boolean change = getCharArray(size,false);
            for (int scan=0;scan<size;scan++) {
                char c = is.readChar();
                if (!change && lState.chararray[scan]!=c) change=true;
                lState.chararray[scan]=c;
            }
            lState.len=size;
            if (change) {
                lState.string=null;
                notifyChange();
            }
            return;
        }

        if (encoding==PSTRING) {
            int len = is.readByte();
            
            if (!is.hasRemaing(len)) len=is.remaining();
            
            boolean change = len != getLength();
            if (getCharArray(len,false)) change=true;

            for (int scan=0;scan<size-1;scan++) 
            {
                char c = is.readChar();
                if (scan<len) {
                    if (!change && lState.chararray[scan]!=c) change=true;
                    lState.chararray[scan]=(char)c;
                }
            }
            lState.len=len;
            if (change) {
                lState.string=null;
                notifyChange();
            }
            return;
        }
        
        if (encoding==CSTRING) {

            boolean end=false;
            boolean change = getCharArray(size-1,false);
            
            for (int scan=0;scan<size-1;scan++) 
            {
            	if (!is.hasRemaing(1)) break; 
            	char c = is.readChar();
                if (!end) {
                    if (c==0) {
                        end=true;
                        if (!change && scan!=getLength()) change=true; 
                        lState.len=scan;
                    } else {
                        if (!change && lState.chararray[scan]!=c) change=true;
                        lState.chararray[scan]=(char)c;
                    }
                }
            }
            is.readChar();
            if (!end) {
                if (!change && getLength()-1!=size) change=true;
                lState.len=size-1;
            }

            if (change) {
                lState.string=null;
                notifyChange();
            }
            return;
        }

        if (encoding==ASTRING) {
            Object o = is.readObject();
            if (o instanceof AbstractStateGetter) {
            	state=(AbstractStateGetter<State>)o;
            } else {
            	throw new RuntimeException("Address invalid:"+o);
            }
            notifyChange();
            return;
        }
        throw new RuntimeException("Not yet implemented");
    }
    
    private void serializeString(CMem is)
    {
        int len = getLength();
        for (int scan=0;scan<len;scan++) {
            is.writeChar(charAt(scan));
        }
    }

    private void serializePadding(CMem is,char pad,int len)
    {
        while (len>0) {
            is.writeChar(pad);
            len--;
        }
    }

    @Override
    public void serialize(CMem is)
    {
        
        if (encoding==STRING) {
            serializeString(is);
            return;
        }

        if (encoding==PSTRING) {
            is.writeByte(getLength());
            serializeString(is);
            serializePadding(is,' ',size-1-getLength());
            return;
        }
        
        if (encoding==CSTRING) {
            serializeString(is);
            is.writeByte(0x00);
            serializePadding(is,' ',size-1-getLength());
            return;
        }

        if (encoding==ASTRING) {
        	is.writeObject(state);
            return;
        }
        
        // ASTRING Encoding not yet supported
        throw new RuntimeException("Not yet implemented:"+encoding);
    }

    public ClarionString stringAt(ClarionObject o)
    {
        int pos = o.intValue();

        if (pos<=0) return new ClarionString(" ");
        if (pos>getLength()) return new ClarionString(" ");
        return new ClarionString(toString().substring(pos-1,pos));
    }
    
    public ClarionString stringAt(ClarionObject from,ClarionObject to)
    {
        int f = from.intValue();
        int t = to.intValue();

        if (f<=0) f=1;
        if (t<f) return new ClarionString("");
        if (t>size && size>=0) t=size;
        
        char result[] = new char[t-f+1];
        
        //int copy=result.length;
        if (t>getLength()) {
            getChars(f-1,getLength(),result,0);
            for (int scan=getLength()-(f-1);scan<result.length;scan++) {
                result[scan]=' ';
            }
        } else {
            getChars(f-1,t,result,0);
        }

        return new ClarionString(result);
    }
    
    
    public int allowedSize()
    {
        if (size==-1) return -1;
        switch(encoding) {
            case PSTRING:
            case CSTRING:
                return size-1;
            case ASTRING:
                return -1;
            default:
                return size;
        }
    }

    private ClarionObject toNumber()
    {
        if (isNumeric(true,true)) {
            return getDecimal();
        }
        if (isNumeric(false)) {
            return getNumber();
        }
        return new ClarionNumber(0);
    }

    private boolean isNumeric(boolean allowDecimal)
    {
        return isNumeric(allowDecimal,false);
    }
    
    private boolean isNumeric(boolean allowDecimal,boolean mustDecimal)
    {
        int scan=0;
        if (getLength()>0) {
            char f = charAt(0);
            if (f=='-') scan++;
        }
        
        if (getLength()==scan) return false;
        char f = charAt(scan);
        if (f<'0' || f>'9') {
            if (f!='.' || !allowDecimal) return false;
        }
        
        int lead=0;
        int trail=0;
        
        while (scan<getLength()) {
            f = charAt(scan);
            if (f<'0' || f>'9') break;
            lead++;
            scan++;
        }

        if (mustDecimal && scan==getLength()) return false;
        
        if (allowDecimal && scan<getLength()) {
            char dp = charAt(scan);
            if (dp=='.') {
                scan++;
                while (scan<getLength()) {
                    f = charAt(scan);
                    if (f<'0' || f>'9') break;
                    trail++;
                    scan++;
                }
            } else {
                if (mustDecimal) return false;
            }
        }

        if (lead==0 && trail==0) return false;
        
        while (scan<getLength()) {
            f = charAt(scan);
            if (f!=' ') return false;
            scan++;
        }
        
        return true; 
    }
    
    public boolean isDecimal() {
        if (isNumeric(true) && !isNumeric(false)) return true;
        return false;
    }

    @Override
    public ClarionObject genericLike() {
        return like();
    }

    @Override
    public boolean isConstrained() 
    {
        return size!=-1;
    }

    /**
     * Do string concatination
     * 
     * @param obj
     * @return
     */
    @Override
    public String concat(Object... obj)
    {
        StringBuilder target=new StringBuilder();
        concatSegment(target);
        return staticConcat(target,obj);
        
    }
    
    public static String staticConcat(Object... obj)
    {
        StringBuilder target=new StringBuilder();
        return staticConcat(target,obj);
    }
    
    public static String staticConcat(StringBuilder target,Object... obj)
    {
        for (Object o : obj) {
            if (o instanceof ClarionObject) {
                ((ClarionObject) o).concatSegment(target);
                continue;
            }
            
            if (o instanceof String) {
                target.append((String)o);
                continue;
            }

            if (o instanceof Integer) {
                target.append(((Integer)o).intValue());
                continue;
            }
            
            Clarion.getClarionObject(o).concatSegment(target);
        }
        
        return target.toString();
    }
    
    @Override
    public void concatSegment(StringBuilder target)
    {
        State lState = state.get();
        if (lState.chararray!=null) {
            target.append(lState.chararray,0,lState.len);
            return;
        }
        
        if (lState.string!=null) {
            target.append(lState.string);
            return;
        }
    }

    public static String rtrim(String in)
    {
        int last = in.length();
        while (last>0) {
            char c = in.charAt(last-1);
            if (c!=' ') break;
            last--;
        }
        if (last==in.length()) return in;
        return in.substring(0,last);
    }

    @Override
    public void notifyChange() {
        State lState = state.get();

        if (encoding==ClarionString.CSTRING) {
            for (int scan=0;scan<lState.len;scan++) {
                if (lState.chararray[scan]==0) {
                    lState.len=scan;
                    break;
                }
            }
        }
        super.notifyChange();
    }

    public static String capitalize(String input)
    {
        StringBuilder builder=new StringBuilder(input.length());
        char last=' ';
        for (int scan=0;scan<input.length();scan++) {
            char c=input.charAt(scan);
            if (Character.isWhitespace(last)) {
                c=Character.toUpperCase(c);
            }
            builder.append(c);
        }
        
        return builder.toString();
    }

    @Override
    public int getSize() {
        return size;
    }

    public static Pattern getClarionWildCardEx(String pattern,boolean ignoreCase)
    {
        StringBuilder sb = new StringBuilder(pattern.length());
        sb.append("^");
        for (int scan=0;scan<pattern.length();scan++) {
            char c = pattern.charAt(scan);
            switch (c) {
                case '*':
                    sb.append(".*");
                    break;
                case '?':
                    sb.append('.');
                    break;
                case '(':
                case ')':
                case '{':
                case '}':
                case '[':
                case ']':
                case '^':
                case '$':
                    sb.append('\\');
                    sb.append(c);
                    break;
                default:
                    sb.append(c);
                    break;
            }
        }
        sb.append("$");
        return Pattern.compile(sb.toString(),ignoreCase ? Pattern.DOTALL+Pattern.CASE_INSENSITIVE : Pattern.DOTALL);
    }
    
    public static Pattern getClarionRegEx(String pattern,boolean ignoreCase)
    {
        StringBuilder sb = new StringBuilder(pattern.length());
        boolean inBlock=false;
        for (int scan=0;scan<pattern.length();scan++) {
            char lastChar=scan>0?pattern.charAt(scan-1):0;
            char c = pattern.charAt(scan);
            
            if (c=='{' && lastChar!='\\' && !inBlock) {
                sb.append('(');
                continue;
            }
            
            if (c=='}' && lastChar!='\\' && !inBlock) {
                sb.append(')');
                continue;
            }
            
            if (c=='[' && lastChar!='\\') {
                inBlock=true;
            }
            if (c==']' && lastChar!='\\') {
                inBlock=false;
            }
            if (c=='(' && !inBlock && lastChar!='\\') {
                sb.append('\\');
            }
            if (c==')' && !inBlock && lastChar!='\\') {
                sb.append('\\');
            }
            sb.append(c);
        }
        return Pattern.compile(sb.toString(),ignoreCase ? Pattern.DOTALL+Pattern.CASE_INSENSITIVE : Pattern.DOTALL);
    }
    
    public int strpos(String regex)
    {
        return strpos(regex,false);
    }
    
    public int strpos(String regex,boolean mode)
    {
        Pattern p = getClarionRegEx(regex,mode);
        Matcher m = p.matcher(toString());
        if (m.find()) {
            return m.start()+1;
        }
        return 0;
    }

    public boolean match(String regex)
    {
        return match(regex,Match.WILD);
    }
    
    public boolean match(String regex,int mode)
    {
        boolean ignoreCase=false;
        if ( (mode & Match.NOCASE)!=0 ) {
            ignoreCase=true;
            mode=mode^Match.NOCASE;
        }
        
        switch(mode) {
            case Match.SIMPLE:
                if (ignoreCase) {
                    return toString().equalsIgnoreCase(regex);
                } else {
                    return toString().equals(regex);
                }
            case Match.WILD:
                return getClarionWildCardEx(regex,ignoreCase).matcher(toString()).find();
            case Match.REGULAR:
                return getClarionRegEx(regex,ignoreCase).matcher(toString()).find();
            default:
                throw new RuntimeException("Not supported");
        }
    }
    
    public String quote()
    {
        return quote(false);
    }
    
    /**
     * Quote. See clarion 6 doco. What exactly this does will remain a mystery
     * 
     * when mode is false - generate clarion encoded string. Clarion 6 is actually buggy,
     * this implementation mirrors that bugginess perfectly
     * 
     * When mode is true - do something strange and unexplicable. See clarion 6 doco
     * 
     * @param mode
     * @return
     */
    public String quote(boolean mode)
    {
        StringEncoding enc = new StringEncoding(toString());
        while (enc.remaining()>0) {
            char c = enc.read();
            if (c=='<') {
                if (!enc.matches(Constant.binaryPattern,-1)) {
                    if (!mode) enc.append(c);
                } else {
                    if (mode) {
                        // do something weird - perform clarion escape
                        Constant.encodeBinary(enc,false);
                        continue;
                    }
                }
            }
            if (c=='{') {
                if (!enc.matches(Constant.repeatPattern,-1)) {
                    if (!mode) enc.append(c); 
                } else {
                    if (mode && enc.pos()>1) {
                        // do something weird - perform clarion escape
                        int repeat = Constant.getRepeat(enc);
                        char last = enc.peek(-2);
                        while (repeat>1) {
                            enc.append(last);
                            repeat--;
                        }
                        continue;
                    }
                }
            }
            if (c=='\'') {
                enc.append(c);
            }
            enc.append(c);
        } 
        return enc.getBuilder().toString();
    }

    public String unquote()
    {
        StringEncoding enc = new StringEncoding(toString());
        while (enc.remaining()>0) {
            char c = enc.read();
            if (c=='\'' || c=='{' || c=='<') {
                if (enc.remaining()>0 && enc.peek(0)==c) {
                    enc.read(); // skip
                }
            }
            enc.append(c);
        }
        return enc.getBuilder().toString();
    }

}
