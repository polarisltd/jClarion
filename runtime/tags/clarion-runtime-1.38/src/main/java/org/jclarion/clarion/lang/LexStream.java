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

public class LexStream {

    private StringBuilder token=new StringBuilder();
    
    private Reader  reader;
    private char[]  buffer;
    private int     bpos;
    private int     blen;
    private int     lineCount=1;
    
    public LexStream(Reader r)
    {
        this.reader=r;
        this.buffer=new char[128];
        this.bpos=0;
        this.blen=0;
    }
    
    public int getLineCount()
    {
        return lineCount;
    }

    public boolean eof()
    {
        return eof(0);
    }
    
    public boolean eof(int la)
    {
        while (bpos+la>=blen) {
            try {
                int c = reader.read();
                if (c==-1) return true;
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

    public void skip(int skip)
    {
        if (bpos+skip>blen) throw new IllegalStateException("Cannot skip without peeking");
        while (skip>0) {
            if (buffer[bpos]=='\n') lineCount++;
            bpos++;
            skip--;
        }
        if (bpos==blen) {
            bpos=0;
            blen=0;
        }
    }

    public void readUntil(char c)
    {
        while (true ) {
            if (eof()) break;
            if (read()==c) break;
        }
    }
    
    public void readNumber()
    {
        while ( true ) {
            if (eof()) break;
            char c = peek(0);
            if (c<'0' || c>'9') break;
            read();
        }
    }
    public boolean readString(String string)
    {
        return readString(string,false);
    }

    public boolean readString(String string,boolean ignoreWS)
    {
        if (ignoreWS) string=string.toLowerCase();
        
        for (int scan=0;scan<string.length();scan++) {
            char c = peek(scan);
            if (ignoreWS && c>='A' && c<='Z') c=(char)(c-'A'+'a');
            if (c!=string.charAt(scan)) return false;
        }
        skip(string.length());
        return true;
    }
    
    public char readAny(String bits)
    {
        if (eof()) return (char)0;
        char c = peek(0);
        for (int scan=0;scan<bits.length();scan++) {
            if (bits.charAt(scan)==c) {
                return read();
            }
        }
        return (char)0;
    }
    
    public void appendToToken(String add)
    {
        token.append(add);
    }
    
    public char read()
    {
        if (bpos<blen) {
            char result=buffer[bpos++];
            if (bpos==blen) {
                bpos=0;
                blen=0;
            }
            token.append(result);
            if (result=='\n') lineCount++;
            return result;
        }

        try {
            int c = reader.read();
            if (c==-1) return 0;
            char result = (char)c;
            token.append(result);
            if (result=='\n') lineCount++;
            return result;
        } catch (IOException e) {
            return 0;
        }
    }
    
    public String getToken()
    {
        String result = token.toString();
        token.setLength(0);
        return result;
    }
}
