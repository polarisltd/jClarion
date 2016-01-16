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
package org.jclarion.clarion.runtime;

/**
 * Used to help decode basic string expressions: specifically pictures
 * and Queue string order statements
 * 
 */
public class SimpleStringDecoder {
    
    private String value;
    private int pos;
    
    public SimpleStringDecoder(String value)
    {
        this.value=value.trim();
    }
    
    
    public boolean end() {
        return pos==value.length();
    }
    
    public boolean pop(char c) {
        
        if (pos>=value.length()) return false;
        char t = value.charAt(pos);
        if (t==c) {
            pos++;
            return true;
        }
        if (c>='a' && c<='z') {
            if (c-'a'+'A' == t) { pos++; return true; }
        }
        if (c>='A' && c<='Z') {
            if (c-'A'+'a' == t) { pos++; return true; }
        }
        
        return false;
    }

    public boolean popStrict(char c) {
        if (pos<value.length()) {
            if (value.charAt(pos)==c) {
                pos++;
                return true;
            }
        }
        return false;
    }
    
    public char popAny() {
        return value.charAt(pos++);
    }

    public boolean pop(char c[]) {
        if (pos<value.length()) {
            char test = value.charAt(pos);
            for (int scan=0;scan<c.length;scan++) {
                if (test==c[scan]) {
                    pos++;
                    return true;
                }
            }
        }
        return false;
    }
    
    public Integer popNumeric() {
        boolean any=false;
        int result=0;
        while ( true ) {
            if (pos==value.length()) break;
            char test = value.charAt(pos);
            if (test<'0' || test>'9') break;
            result=result*10+(test-'0');
            pos++;
            any=true;
        }
        if (any) return Integer.valueOf(result);
        return null;
    }
    
    
    public String popString(char delimiter) {
        int start = pos;
        while (true ) {
            if (pos==value.length()) break;
            if (value.charAt(pos)==delimiter) break;
            pos++;
        }
        return value.substring(start,pos);
    }
    
    public char peekChar(int offset) {
       if (pos+offset>=value.length()) return '\0';
       return value.charAt(pos+offset);
    }
    
    public void error(String message)
    {
        StringBuilder n = new StringBuilder();
        n.append(message).append('\n');
        n.append("Position:").append(pos).append('\n');
        if (pos<value.length()) {
            n.append("Char:").append(value.charAt(pos)).append('\n');
        } else {
            n.append("Char:<eos>\n");
        }
        n.append("Lead:").append(value.substring(0,pos)).append('\n');
        n.append("Remain:").append(value.substring(pos)).append('\n');
        
        String s = n.toString();
        System.err.println(s);
        throw new IllegalStateException(s);
    }
    
}
