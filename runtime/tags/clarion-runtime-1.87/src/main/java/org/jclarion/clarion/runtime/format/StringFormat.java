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

public class StringFormat extends Formatter 
{
    int length=0;
    
    public StringFormat(String format) {
        super(format);
        SimpleStringDecoder decoder = new SimpleStringDecoder(format);
        if (!decoder.pop('@')) throw new IllegalArgumentException("Invalid Picture");
        if (!decoder.pop("sS".toCharArray())) throw new IllegalArgumentException("Invalid Picture");
        
        Integer result = decoder.popNumeric();
        if (result==null) throw new IllegalArgumentException("Invalid Picture");
        
        length=result;
        
        if (!decoder.end()) throw new IllegalArgumentException("Invalid Picture");
    }

    @Override
    public String deformat(String input) {
        clearError();
        // return space trimmed string
        int scan = input.length();
        while (scan>0) {
            if (input.charAt(scan-1)!=' ') break;
            scan--;
        }
        
        return input.substring(0,scan);
    }

    @Override
    public String format(String input) {
        clearError();

        input = deformat(input);

        char result[]=new char[length];
        
        if (input.length()>length && isStrict()) {
            return errorString();
        } else {
            input.getChars(0,input.length() > length ? length : input.length() ,result,0);
            for (int scan=input.length();scan<length;scan++) {
                result[scan]=' ';
            }
        }
        
        return new String(result);
    }

    @Override
    public int getMaxLen() {
        // TODO Auto-generated method stub
        return length;
    }
    
    private String errorString() {
        setError();
        char e[]=new char[length];
        for (int scan=0;scan<e.length;scan++) {
            e[scan]='$';
        }
        return new String(e);
    }

    @Override
    public String getPictureRepresentation() {
        char e[]=new char[length];
        for (int scan=0;scan<e.length;scan++) {
            e[scan]='$';
        }
        return new String(e);
    }
}
