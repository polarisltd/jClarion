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

import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;
import java.util.regex.Pattern;

public class Constant {
    
    public static String number(String input)
    {
        char lc=0;
        if (input.length()>0) lc=input.charAt(input.length()-1);
        
        if (lc=='h' || lc=='H') {
            return "0x"+Long.toHexString(
                    Long.parseLong(input.substring(0,input.length()-1),16));
        }
        if (lc=='o' || lc=='O') {
            return "0x"+Long.toHexString(
                    Long.parseLong(input.substring(0,input.length()-1),8));
        }
        if (lc=='b' || lc=='B') {
            return "0x"+Long.toHexString(
                    Long.parseLong(input.substring(0,input.length()-1),2));
        }

        // remove excessive leading 0s
        while (input.startsWith("0")) {
            input=input.substring(1,input.length());
        }

        if (input.startsWith(".")) {
            input="0"+input;
        }
        
        if (input.length()==0) {
            input="0";
        }
        
        return input;
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
            if (appendOrd(encoding.getBuilder(),c,javaFormat)) {
                lastChar=String.valueOf(c);
            } else {
                lastChar=encoding.getMark();
            }
        }
        
        if (javaFormat) encoding.append('"');
        return encoding.getBuilder().toString();
    }
    
    public static String encodeBinary(StringEncoding encoding, boolean javaFormat) {
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
                
                appendOrd(encoding.getBuilder(),(char)ord,javaFormat);
                bin_start=encoding.pos();
            }
        }
        return encoding.getMark();
    }

    private static CharsetEncoder enc=Charset.defaultCharset().newEncoder();
    
    private static boolean appendOrd(StringBuilder sb,char ord,boolean javaFormat)
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
        
        if (ord<20 || !enc.canEncode(ord)) 
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
