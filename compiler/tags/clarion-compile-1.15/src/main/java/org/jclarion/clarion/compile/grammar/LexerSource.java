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
package org.jclarion.clarion.compile.grammar;

import org.jclarion.clarion.lang.Lexer;

public abstract class LexerSource 
{
    private static LexerSource instance;
    
    public static LexerSource getInstance()
    {
        return instance;
    }
    
    public static void setInstance(LexerSource instance)
    {
        LexerSource.instance=instance;
    }

    public String cleanName(String name)
    {
        name=name.toLowerCase();
        int lp;
        lp=name.lastIndexOf('/');
        if (lp>-1) name=name.substring(lp+1);
        lp=name.lastIndexOf('\\');
        if (lp>-1) name=name.substring(lp+1);
        
        return name;
    }
    
    
    public abstract Lexer getLexer(String name);
}
