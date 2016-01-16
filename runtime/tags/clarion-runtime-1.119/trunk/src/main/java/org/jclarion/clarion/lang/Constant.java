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
package org.jclarion.clarion.lang;

import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;
import java.util.regex.Pattern;

public class Constant {
	
    public static String number(String input)
    {
    	return number(input,true);
    }
    
    public static String number(String input,boolean javaMode)
    {
        char lc=0;
        if (input.length()>0) lc=input.charAt(input.length()-1);
        
        int base=10;
        
        switch(lc) {
        	case 'h':
        	case 'H':
        		base=16;
        		break;
        	case 'o':
        	case 'O':
        		base=8;
        		break;
        	case 'b':
        	case 'B':
        		base=2;
        		break;
        }
        
        if (base!=10) {
        	long val=Long.parseLong(input.substring(0,input.length()-1),base);
        	if (javaMode) {
                return "0x"+Long.toHexString(val);
        	}
        	return Long.toString(val);
        }

        int start = 0;
        int end = input.length();
        
        while (start<end && input.charAt(start)=='0') {
        	start++;
        }

        boolean prefix=false;
        
        if (start<end && input.charAt(start)=='.') {
        	if (start==0 || input.charAt(start-1)!='0') {
        		prefix=true;
        	} else {
        		start--;
        	}
        }
        
        
        if (start==end) {
        	return "0";
        }
        
        if (prefix) {
        	return "0"+input.substring(start,end);
        }
        
        if (start==0 && end==input.length()) {
        	return input;
        }
        return input.substring(start,end);
    }
    
    private static String binaryMatch = 
        "(?:"+
            "[0-9]+|"+
            "(?:[0-9a-fA-F]+[hH])|"+
            "(?:[0-7]+[oO])|"+
            "(?:[01]+[bB])"+
        ")";
        
    private static char[] hex = "0123456789abcdef".toCharArray();
    
    public static Pattern binaryPattern = Pattern.compile(
            "<"+binaryMatch+"(?:,"+binaryMatch+")*>");
    
    public static Pattern repeatPattern = Pattern.compile("\\{[0-9]+\\}");
            
    public static Integer getRepeat(StringEncoding encoding) 
    {
        encoding.mark();
        int value=-1;
        while (encoding.remaining()>0) {
            char t = encoding.read();
            if (t=='}') {
                if (value==-1) break;
                return value;
            }
            if (t<'0' || t>'9') break;
            if (value==-1) value=0;
            value=value*10+t-'0';
        }
        encoding.reset();
        return null;
    }
    
    /**
     * Convert clarion string into java string
     * 
     * Features of a clarion string
     * 
     *   '' = '
     *   <{number}[ohb],*> = ascii character(s)
     *   
     *   {number} = repeat last atom number times
     * 
     * @param string
     * @return
     */
    
    public static String string(String string)
    {
        return string(string,true);
    }
    
    public static String string(String str,boolean javaFormat)
    {
        StringEncoding encoding = new StringEncoding(str);
        if (javaFormat) encoding.append('"');
        
        String lastChar="";
        
        while (encoding.remaining()>0) {
            char c = encoding.read();
            
            if (c=='\'') {
                if (encoding.remaining()>0) {
                    c = encoding.read();
                    if (c=='\'') {
                        encoding.append(c);
                        lastChar="'";
                    }
                    continue;
                }
            }
            
            if (c=='<') {
                
                if (encoding.remaining()>0) {
                    if (encoding.peek(0)=='<') {
                        encoding.append('<');
                        lastChar="<";
                        encoding.read();
                        continue;
                    }
                }
                
                if (!encoding.matches(binaryPattern,-1)) {
                    encoding.append(c);
                    lastChar="<";
                    continue;
                }

                lastChar = encodeBinary(encoding,javaFormat);
                
                continue;
            }

            if (c=='{') {

                if (encoding.remaining()>0) {
                    if (encoding.peek(0)=='{') {
                        encoding.append('{');
                        lastChar="{";
                        encoding.read();
                        continue;
                    }
                }
                
                Integer i_size = getRepeat(encoding);
                if (i_size==null) {
                    encoding.append('{');
                    lastChar="{";
                    continue;
                }
                
                int size = i_size;
                
                while (size>1) {
                    encoding.append(lastChar);
                    size--;
                }
                
                continue;
            }
            
            encoding.mark();
            if (appendOrd(encoding.getBuilder(),c,javaFormat,false)) {
                lastChar=String.valueOf(c);
            } else {
                lastChar=encoding.getMark();
            }
        }
        
        if (javaFormat) encoding.append('"');
        return encoding.getBuilder().toString();
    }

    public static Charset charset = Charset.defaultCharset();
    
    public static String encodeBinary(StringEncoding encoding, boolean javaFormat) {

    	encoding.mark();
    	int size=1;
        while ( true ) {
            char b = encoding.read();
            if (b=='>') break;
            if (b==',') size++;
        }
        encoding.reset();
        
        byte res[] = new byte[size];
        size=0;
    	
    	
    	encoding.mark();
        boolean end=false;
        int bin_start=encoding.pos();
        

        while ( !end ) {
            char b = encoding.read();
            if (b=='>') {
                end=true;
            }
            if (b==',' || b=='>') {
                char last = encoding.peek(-2);
                int ord=-1;
                if (last=='h' || last=='H') {
                    ord=Integer.parseInt(encoding.toString().substring(bin_start,encoding.pos()-2),16);
                } else 
                if (last=='o' || last=='O') {
                    ord=Integer.parseInt(encoding.toString().substring(bin_start,encoding.pos()-2),8);
                } else 
                if (last=='b' || last=='B') {
                    ord=Integer.parseInt(encoding.toString().substring(bin_start,encoding.pos()-2),2);
                } else {
                    ord=Integer.parseInt(encoding.toString().substring(bin_start,encoding.pos()-1));
                }
     
                res[size++]=(byte)ord;
                bin_start=encoding.pos();
            }
        }
        
        if (size==4 && res[0]==-1 && (res[1]==1 || res[1]==2) && (res[3]==0 || res[3]==127)) {
        	for (int scan=0;scan<size;scan++) {
                appendOrd(encoding.getBuilder(),(char)(res[scan]&0xff),javaFormat,true);        	
        	}
        } else {
        	CharBuffer cc = charset.decode(ByteBuffer.wrap(res,0,size));
        	while (cc.hasRemaining()) {
        		appendOrd(encoding.getBuilder(),cc.get(),javaFormat,false);        	
        	}
        }
        return encoding.getMark();
    }

    private static CharsetEncoder enc=Charset.defaultCharset().newEncoder();
    
    private static boolean appendOrd(StringBuilder sb,char ord,boolean javaFormat,boolean binary)
    {
        if (!javaFormat) {
            sb.append(ord);
            return true;
        }
        
        if (ord=='\\') {
            sb.append("\\\\");
            return false;
        }
        
        if (ord=='\r') {
            sb.append("\\r");
            return false;
        }

        if (ord=='"') {
            sb.append("\\\"");
            return false;
        }

        if (ord=='\\') {
            sb.append("\\\\");
            return false;
        }

        if (ord=='\n') {
            sb.append("\\n");
            return false;
        }
        
        if (ord<20 || (binary && ord>126) || !enc.canEncode(ord)) 
        {
            sb.append("\\u");
            sb.append(hex[(ord>>12)&0x0f]);
            sb.append(hex[(ord>>8)&0x0f]);
            sb.append(hex[(ord>>4)&0x0f]);
            sb.append(hex[(ord)&0x0f]);
            return false;
        }
        
        sb.append(ord);
        return true;
    }
}
