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

import org.jclarion.clarion.runtime.SimpleStringDecoder;

/**
 * Decode a pattern
 * 
 * format is 
 *  '#' - match a number - if no number render '0'
 *  '<' - match a number or blank
 *  . - match exact character
 * 
 * Pattern decoding is made complicated by fact that '<'
 * is optional - so multiple decoding paths can exist. Solution needs
 * to employ recursion to discover correct path 
 * 
 * @author barney
 */
public class PatternFormat extends Formatter
{
    private String format;
    private boolean blank;
    
    public PatternFormat(String pattern)
    {
        super(pattern);
        SimpleStringDecoder decoder = new SimpleStringDecoder(pattern);
        
        if (!decoder.pop('@')) decoder.error("Invalid Picture");
        
        char start = decoder.popAny();
        if (start!='p' && start!='P') decoder.error("Invalid Picture");
        
        format=decoder.popString(start);
        if (format==null) decoder.error("Invalid Picture");
        decoder.popAny();
        if (decoder.pop('b')) blank=true;
    }

    
    private boolean deformat(FormatResolver fr)
    {
        while ( true ) {
            if (fr.isPatternFinished()) {
                if (fr.isInputFinished()) return true;
                return false;
            }
        
            char p = fr.pattern();
            /*
            if (p=='#') {
                if (fr.isInputFinished()) return false;
                char c =fr.input();
                if (c>='0' && c<='9') {
                    fr.append(c);
                    continue;
                }
                return false;
            }
            */

            if (p=='<' || p=='#') {
                if (fr.isInputFinished()) continue;
                Object o = fr.savepoint();
                char c =fr.input();
                if (c==' ') c='0';
                if (c>='0' && c<='9') {
                    fr.append(c);
                    if (deformat(fr)) continue;
                }
                fr.rollback(o);
                fr.append('0');
                continue;
            }
            
            if (fr.isInputFinished()) {
                Object o = fr.savepoint();
                if (deformat(fr)) continue;
                fr.rollback(o);
                return false;
            }
            
            if (fr.input(false)!=p) {
                Object o = fr.savepoint();
                if (deformat(fr)) continue;
                fr.rollback(o);
                return false;
            }
            fr.input();
        }
    }
    
    @Override
    public String deformat(String input) {
        input=input.trim();
        FormatResolver fr = new FormatResolver(input,format,true);
        clearError();
        
        if (!deformat(fr)) {
            setError();
            return "";
        }
        
        fr.trim('0');
        
        String result = fr.toString();
        return result;
    }

    public boolean format(FormatResolver fr)
    {
        int trim=0;
        
        while ( true ) {
            if (fr.isPatternFinished()) {
                if (fr.isInputFinished()) {
                    fr.trim('0',' ',trim);
                    return true;
                }
                return false;
            }

            char p = fr.pattern();
            
            if (p=='#') {
                fr.trim('0',' ',trim); 
                trim=0;
                char c;
                if (fr.isInputFinished()) {
                    c='0';
                } else {
                    c =fr.input();
                }
                if (c>='0' && c<='9') {
                    fr.append(c);
                    continue;
                }
                return false;
            }

            if (p=='<') {
                trim++;
                if (fr.isInputFinished()) {
                    fr.append('0');
                    continue;
                }
                char c =fr.input();
                if (c>='0' && c<='9') {
                    fr.append(c);
                    continue;
                }
                return false;
            }

            fr.trim('0',' ',trim); 
            trim=0;
            fr.append(p);
        }
    }

    @Override
    public String format(String input) {
        input=input.trim();
        
        int lead=0;
        while (lead<input.length()) {
            char c = input.charAt(lead);
            if (c!=' ' && c!='0') break;
            lead++;
        }
        if (lead>0) input=input.substring(lead);
        
        FormatResolver fr = new FormatResolver(input,format,true);
        clearError();
        
        if (!format(fr)) {
            setError();
            return format;
        }
        
        String result = fr.toString();
        if (blank) {
            boolean isBlank=true;
            for (int scan=0;scan<result.length();scan++) {
                char c= result.charAt(scan);
                if (c!=' ' && c!='0') {
                    isBlank=false;
                    break;
                }
            }
            if (isBlank) return "";
        }
        return result;
    }

    @Override
    public int getMaxLen() {
        return format.length();
    }


    @Override
    public String getPictureRepresentation() {
        return format;
    }

}
