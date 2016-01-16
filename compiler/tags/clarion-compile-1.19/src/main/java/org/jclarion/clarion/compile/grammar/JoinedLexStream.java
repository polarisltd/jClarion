package org.jclarion.clarion.compile.grammar;

import org.jclarion.clarion.lang.AbstractLexStream;

public class JoinedLexStream extends AbstractLexStream 
{
    private AbstractLexStream streams[];
    private int pos=0;
    
    public JoinedLexStream(AbstractLexStream ...streams)
    {
        this.streams=streams;
    }
    

    @Override
    public boolean eof(int ofs) 
    {
        if (pos>=streams.length) return true;
        
        int scan=pos;
        while ( true ) {
            if (!streams[scan].eof(ofs)) return false;
            if (scan+1==streams.length) return true;
            ofs-=streams[scan].getEOFPosition(ofs);
            scan++;
        }
    }

    @Override
    public char peek(int ofs) 
    {
        if (pos>=streams.length) return 0;
        int scan=pos;
        while ( true ) {
            if (!streams[scan].eof(ofs)) return streams[scan].peek(ofs);
            if (scan+1==streams.length) return 0;
            ofs-=streams[scan].getEOFPosition(ofs);
            scan++;
        }
    }

    @Override
    public int getEOFPosition(int ofs) 
    {
        
        int count=0;
        int scan=pos;
        
        while ( true ) {
            if (scan>=streams.length) return count;
            if (!streams[scan].eof(ofs)) return -1;
            int inc = streams[scan].getEOFPosition(ofs);
            
            count+=inc;
            ofs-=inc;
            scan++;
            if (ofs==0) return count;
        }
    }
    
    @Override
    protected char readChar() 
    {
        while ( true ) {
            if (pos>=streams.length) return 0;
            char c = streams[pos].read();
            if (c==0) {
                pos++;
                continue;
            }
            return c;
        }
    }


    @Override
    public int getLineCount() {
        if (pos>=streams.length) {
            if (pos==0) return 0;
            return streams[pos-1].getLineCount();
        }
        return streams[pos].getLineCount();
    }


    @Override
    public String getName() {
        if (pos>=streams.length) {
            if (pos==0) return "Unknown";
            return streams[pos-1].getName();
        }
        return streams[pos].getName();
    }


    
    
}
