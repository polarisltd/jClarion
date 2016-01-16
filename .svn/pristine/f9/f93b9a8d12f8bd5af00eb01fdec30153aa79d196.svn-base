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
package org.jclarion.clarion.util;

import java.io.InputStream;

public class SharedInputStream extends InputStream 
{
    private byte[]  source;
    private int     size;
    private int     pos;
    private int     suggSize; 
    private int     mark;
    
    public SharedInputStream(byte source[])
    {
        this(source,0,source.length);
    }

    public SharedInputStream(byte source[],int pos,int size)
    {
        this(source,pos,size,size);
    }
    
    public SharedInputStream(byte source[],int pos,int size,int suggSize)
    {
        this.source=source;
        this.pos=pos;
        this.size=size+pos;
        this.suggSize=pos+suggSize;
    }
    
    @Override
    public void close() {
    }
    
    public int getSize()
    {
        return size;
    }
    
    public byte[] getBytes()
    {
        return source;
    }

    @Override
    public int read() {
        if (pos==size) return -1;
        return (source[pos++]&0xff);
    }

    @Override
    public int available() {
        return suggSize-pos;
    }

    @Override
    public synchronized void mark(int readlimit) {
        mark=pos;
    }

    @Override
    public boolean markSupported() {
        return true;
    }

    @Override
    public int read(byte[] b) {
        return read(b,0,b.length);
    }

    @Override
    public int read(byte[] b, int off, int len) {
        if (pos==size) return -1;
        
        if (len>size-pos) len=size-pos;
        
        System.arraycopy(source,pos,b,off,len);
        pos+=len;
        
        return len;
    }

    @Override
    public synchronized void reset() {
        pos=mark;
    }

    @Override
    public long skip(long n) {
        if (pos+n>size) n=size-pos;
        pos+=n;
        return n;
    }
}
