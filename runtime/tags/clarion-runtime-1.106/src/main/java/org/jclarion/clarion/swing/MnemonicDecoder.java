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
package org.jclarion.clarion.swing;

public class MnemonicDecoder {
    
    private String string;
    private int    mnemonicPos=-1; // -1 = no mnemonic
    private char   mnemonicChar;
    
    public MnemonicDecoder(String input)
    {
        StringBuilder out = new StringBuilder(input.length());
        boolean escape=false;
        for (int scan=0;scan<input.length();scan++) {
            char c = input.charAt(scan);
            if (c=='&') {
                if (escape==true) {
                    escape=false;
                } else {
                    escape=true;
                    continue;
                }
            }
            if (escape) {
                mnemonicPos=out.length();
               	mnemonicChar=Character.toUpperCase(c);
                escape=false;
            }
            out.append(c);
        }
        string=out.toString().trim();
    }
    
    public String getString()
    {
        return string; 
    }
    
    
    public boolean isMnemonic()
    {
        return mnemonicPos>-1;
    }
    
    public int getMnemonicPos()
    {
        return mnemonicPos;
    }

    public char getMnemonicChar()
    {
        return mnemonicChar;
    }
}
