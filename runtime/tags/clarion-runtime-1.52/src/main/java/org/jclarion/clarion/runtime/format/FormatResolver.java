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
package org.jclarion.clarion.runtime.format;

public class FormatResolver {
    
    private String input;
    private int inputPosition=0;
    
    private String pattern;
    private int patternPosition =0;
    
    private boolean reverse;
    
    private StringBuilder result=new StringBuilder();
    
    
    public FormatResolver(String input,String pattern,boolean reverse)
    {
        this.input=input;
        this.pattern=pattern;
        this.reverse=reverse;
    }
        
    public Object savepoint() {
        int sp[] = new int[] { inputPosition, patternPosition, result.length() };
        return sp;
    }

    public void rollback(Object o) {
        int sp[] = (int[]) o;
        inputPosition = sp[0];
        patternPosition = sp[1];
        result.setLength(sp[2]);
    }

    public boolean isPatternFinished() {
        return patternPosition == pattern.length();
    }

    public boolean isInputFinished() {
        return inputPosition == input.length();
    }

    public char pattern()
    {
        return pattern(true);
    }
    
    public char pattern(boolean consume) {
        char r = pattern.charAt(reverse?pattern.length()-1-patternPosition:patternPosition);
        if (consume)
            patternPosition++;
        return r;
    }

    public char input()
    {
        return input(true);
    }

    public char input(boolean consume) {
        char r = input.charAt(reverse?input.length()-1-inputPosition:inputPosition);
        if (consume)
            inputPosition++;
        return r;
    }

    public void append(char c) {
        result.append(c);
    }

    public String toString()
    {
        if (reverse) {
            char cr[] = new char[result.length()];
            for (int scan=0;scan<cr.length;scan++) {
                cr[scan]=result.charAt(cr.length-1-scan);
            }
            return new String(cr);
            
        }
        return result.toString();
    }

    public void trim(char c) {
        while (result.length()>1) {
            if (result.charAt(result.length()-1)!=c) break;
            result.setLength(result.length()-1);
        }
    }
    
    public void trim(char c,char r,int trim) {
        int pos = result.length(); 
        while (pos>0 && trim>0) {
            if (result.charAt(pos-1)!=c) break;
            result.setCharAt(pos-1,r);
            pos--;
            trim--;
        }
    }
}
