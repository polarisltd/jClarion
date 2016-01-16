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

import java.io.IOException;
import java.io.Reader;

public class LexStream extends AbstractLexStream {

    private Reader  reader;
    private char[]  buffer;
    private int     bpos;
    private int     blen;

    public LexStream(Reader r,String name)
    {
        this(r);
        setName(name);
    }
    
    public LexStream(Reader r)
    {
        this.reader=r;
        this.buffer=new char[128];
        this.bpos=0;
        this.blen=0;
    }

    @Override
    public int getEOFPosition(int ofs) {
        if (!eof(ofs)) return -1;
        return blen-bpos;
    }
    
    
    public boolean eof(int la)
    {
        while (bpos+la>=blen) {
            try {
                if (reader==null) return true;
                int c = reader.read();
                if (c==-1 || c==27 || c==26) { // abpopup in clarion 6 has 26
                    reader=null;
                    return true;
                }
                buffer[blen++]=(char)c;
            } catch (IOException e) {
                return true;
            }
        }
        return false;
    }
    
    public char peek(int la)
    {
        if (eof(la)) return 0;
        return buffer[bpos+la];
    }

    @Override
    protected char readChar()
    {
        if (bpos<blen) {
            char result=buffer[bpos++];
            if (bpos==blen) {
                bpos=0;
                blen=0;
            }
            return result;
        }

        try {
            if (reader==null) return 0;
            int c = reader.read();
            if (c==-1) {
                reader=null;
                return 0;
            }
            char result = (char)c;
            return result;
        } catch (IOException e) {
            return 0;
        }
    }

}
