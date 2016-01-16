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
    
    private static Pattern binaryPattern = Pattern.compile(
            "<"+binaryMatch+"(?:,"+binaryMatch+")*>");
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
    
    public static String string(String string,boolean javaFormat)
    {
        StringBuilder result=new StringBuilder(string.length()>>1);
        if (javaFormat) result.append('"');
        
        int scan=0;
        int len =string.length();
        
        String lastChar="";
        
        while (scan<len) {
            char c = string.charAt(scan++);
            
            if (c=='\'') {
                if (scan<len) {
                    c = string.charAt(scan++);
                    if (c=='\'') {
                        result.append(c);
                        lastChar="'";
                    }
                    continue;
                }
            }
            
            if (c=='<') {
                
                if (scan<len) {
                    if (string.charAt(scan)=='<') {
                        result.append('<');
                        lastChar="<";
                        scan++;
                        continue;
                    }
                }
                
                if (!binaryPattern.matcher(string).find(scan-1)) {
                    result.append(c);
                    lastChar="<";
                    continue;
                }
                
                int start = result.length();
                
                boolean end=false;
                int bin_start=scan;
                int bin_scan=scan;
                while ( !end ) {
                    char b = string.charAt(bin_scan);
                    if (b=='>') {
                        end=true;
                    }
                    if (b==',' || b=='>') {
                        char last = string.charAt(bin_scan-1);
                        
                        int ord=-1;
                        
                        if (last=='h' || last=='H') {
                            ord=Integer.parseInt(string.substring(bin_start,bin_scan-1),16);
                        } else 
                        if (last=='o' || last=='O') {
                            ord=Integer.parseInt(string.substring(bin_start,bin_scan-1),8);
                        } else 
                        if (last=='b' || last=='B') {
                            ord=Integer.parseInt(string.substring(bin_start,bin_scan-1),2);
                        } else {
                            ord=Integer.parseInt(string.substring(bin_start,bin_scan));
                        }
                        
                        appendOrd(result,(char)ord,javaFormat);
                        bin_start=bin_scan+1;
                    }
                    bin_scan++;
                }

                scan=bin_scan;
                lastChar=result.substring(start);
                continue;
            }

            if (c=='{') {

                if (scan<len) {
                    if (string.charAt(scan)=='{') {
                        result.append('{');
                        lastChar="{";
                        scan++;
                        continue;
                    }
                }
                
                
                int start = scan;
                int repeat_scan=scan;
                boolean legal=false;
                while (repeat_scan<len) {
                    char t = string.charAt(repeat_scan);
                    if (t=='}') {
                        legal=true;
                        break;
                    }
                    if (t<'0' || t>'9') break;
                    repeat_scan++;
                }
                
                if (!legal || repeat_scan==start) {
                    result.append('{');
                    lastChar="{";
                    continue;
                }
                
                int size = Integer.parseInt(string.substring(start,repeat_scan));
                
                while (size>1) {
                    result.append(lastChar);
                    size--;
                }
                
                scan=repeat_scan+1;
                continue;
            }
            
            int pos = result.length();
            if (appendOrd(result,c,javaFormat)) {
                lastChar=String.valueOf(c);
            } else {
                lastChar=result.substring(pos);
            }
        }
        
        if (javaFormat) result.append('"');
        return result.toString();
    }
    
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
        
        if (ord<20 || ord>126)
        {
            sb.append("\\u00");
            sb.append(hex[(ord>>4)&0x0f]);
            sb.append(hex[(ord)&0x0f]);
            return false;
        }
        
        sb.append(ord);
        return true;
    }
}
