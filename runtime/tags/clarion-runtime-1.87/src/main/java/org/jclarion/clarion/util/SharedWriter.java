package org.jclarion.clarion.util;

import java.io.Writer;

import javax.swing.text.Segment;

public class SharedWriter extends Writer implements CharSequence
{
    private int pos;
    private char[] buffer;
    
    public SharedWriter()
    {
        buffer=new char[128];
    }
    
    public void reset()
    {
        pos=0;
    }
    
    public int getSize()
    {
        return pos;
    }
    
    public char[] getBuffer()
    {
        return buffer;
    }

    @Override
    public Writer append(char c)  
    {
        extendBuffer(1);
        buffer[pos++]=c;
        return this;
    }

    @Override
    public Writer append(CharSequence csq, int start, int end) {
        extendBuffer(end-start);
        for (int scan=start;scan<end;scan++) {
            buffer[pos++]=csq.charAt(scan);
        }
        return this;
    }

    @Override
    public void close()  
    {
    }

    @Override
    public void flush()  
    {
    }

    @Override
    public void write(char[] cbuf, int off, int len) {
        extendBuffer(len);
        System.arraycopy(cbuf,off,buffer,pos,len);
        pos+=len;
    }

    @Override
    public void write(int c) {
        extendBuffer(1);
        buffer[pos++]=(char)c;
    }

    @Override
    public void write(String str, int off, int len) {
        extendBuffer(len);
        str.getChars(off,off+len,buffer,pos);
        pos+=len;
    }

    private void extendBuffer(int len)
    {
        if (pos+len<=buffer.length) return;
        
        int nl=len;
        if (nl==0) nl=1;
        while (nl<pos+len) {
            nl=nl<<1;
        }
        
        char nb[]=new char[nl];
        System.arraycopy(buffer,0,nb,0,pos);
        buffer=nb;
    }

    @Override
    public char charAt(int index) {
        return buffer[index];
    }

    @Override
    public int length() {
        return pos;
    }

    @Override
    public CharSequence subSequence(int start, int end) 
    {
        return new Segment(buffer,start,end);
    }
    
    public String toString()
    {
        return new String(buffer,0,pos);
    }

    public boolean endsWith(char c) {
        return (buffer[pos-1]==c); 
    }
    
    public int getLastByte()
    {
        if (pos==0) return -1;
        return buffer[pos-1];
    }

    public char getLastByteNoCheck()
    {
        return buffer[pos-1];
    }
    
    public void shrink()
    {
        if (pos>0) pos--;
    }
    
    public boolean endsWith(char test[])
    {
        int t_scan = pos-test.length;
        if (t_scan<0) return false;
        for (char t : test ) {
            if (t!=buffer[t_scan++]) return false;
        }
        return true;
    }

    public void shrink(char test[])
    {
        int scan=test.length;
        while (pos>0 && scan>0) {
            scan--;
            if (buffer[pos-1]!=test[scan]) return;
            pos--;
        }
    }
    
    public boolean endsWith(byte test)
    {
        if (pos==0) return false;
        return buffer[pos-1]==test;
    }

    public void skip(long ofs)
    {
        pos+=ofs;
    }
        
}
