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

import java.io.CharArrayReader;
import java.io.CharArrayWriter;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.lang.Lexer;

/**
 * Source lexer objects from pre-packaged memory objects
 * 
 * @author barney
 *
 */
public class MemoryLexerSource extends LexerSource
{
    private Map<String,char[]> lexers=new HashMap<String, char[]>();
    
    public void addLexer(String name,String... contents) {
        CharArrayWriter caw = new CharArrayWriter();
        for (int scan=0;scan<contents.length;scan++)
        {
            try {
                caw.write(contents[scan]);
            } catch (Exception e) { }
        }
        lexers.put(name.toLowerCase(),caw.toCharArray());
    }
    
    @Override
    public Lexer getLexer(String name) {
        char c[] = lexers.get(cleanName(name));
        if (c==null) return null;
        return new Lexer(new CharArrayReader(c));
    }

    public void empty() {
        lexers.clear();
    }
}
