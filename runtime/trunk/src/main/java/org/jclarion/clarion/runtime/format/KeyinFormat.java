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

import java.util.logging.Logger;

import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.runtime.SimpleStringDecoder;
import org.mortbay.log.Log;

/**
 * 
 * @author robertsp
 * 
 * Key-in Template Pictures
   @K[@][#][<][x][\][?][^][_][|]K[B]
   
   @K All key-in template pictures begin with the @K delimiter and end with the K
delimiter. The case of the delimiters must be the same.
   @ Specifies only uppercase and lowercase alphabetic characters.
   # Specifies an integer 0 through 9.
   < Specifies an integer that is blank for high order zeros.
   x Represents optional constant display characters (any displayable character).
     These characters appear in the final result string.
   \ Indicates the following character is a display character. This allows you to include
     any of the picture formatting characters (@,#,<,\,?,^,_,|) within the string as a
     display character.
   ? Specifies any character may be placed in this position.
   ^ Specifies only uppercase alphabetic characters in this position.
   _ Underscore specifies only lowercase alphabetic characters in this position.
   | Allows the operator to "stop here" if there are no more characters to input. Only
     the data entered and any display characters up to that point will be in the string
     result.
   K All key-in template pictures must end with K. If a lower case @k delimiter is used,
     the ending K delimiter must also be lower case.
   B Specifies that the format displays as blank when the value is zero.
   
   Key-in pictures are used specifically with STRING, PSTRING, and CSTRING fields to allow
   custom field editing control and validation. Using a key-in picture containing any of the alphabet
   indicators ( @ ^ _ ) on a numeric entry field produces unpredictable results.
 *
 */
public class KeyinFormat extends Formatter 
{
	private static Logger log = Logger.getLogger(ClarionSQLFile.class.getName());
	int length=0;
    private String format;
    
    public KeyinFormat(String format) {
        super(format);
        SimpleStringDecoder decoder = new SimpleStringDecoder(format);
        if (!decoder.pop('@')) throw new IllegalArgumentException("Invalid Picture");

        char start = decoder.popAny();
        if (start!='k' && start!='K') decoder.error("Invalid Picture");
        
        format=decoder.popString(start);
        if (format==null) decoder.error("Invalid Picture");        
        length = format.length(); // approximate max length with length of picture
        log.info("KeinFormat format:"+format+" len:"+length);
        decoder.popAny();
        
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
        log.info("KeinFormat deformat:"+input.substring(0,scan));
        return input.substring(0,scan);
    }

    @Override
    public String format(String input) {
        clearError();

        input = deformat(input);
        log.info("KeinFormat format:"+input);

        return input;
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
