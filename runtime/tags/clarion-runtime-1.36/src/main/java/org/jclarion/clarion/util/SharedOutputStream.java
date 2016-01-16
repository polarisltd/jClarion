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

import java.io.OutputStream;

public class SharedOutputStream extends OutputStream
{
    private byte target[];
    private int pos;
    private int size;
    
    public SharedOutputStream()
    {
        this(new byte[256],0,256);
    }

    public SharedOutputStream(int size)
    {
        this(new byte[size],0,size);
    }
    
    public SharedOutputStream(byte target[],int pos,int size)
    {
        this.target=target;
        this.pos=pos;
        this.size=size+pos;
    }
    
    public SharedInputStream getInputStream()
    {
        return new SharedInputStream(target,0,pos);
    }

    public SharedInputStream getInputStream(int size)
    {
        return new SharedInputStream(target,0,size);
    }

    public SharedInputStream getFullInputStream()
    {
        return new SharedInputStream(target,0,target.length,pos);
    }

    public SharedOutputStream like()
    {
        byte bits[] = toByteArray();
        SharedOutputStream like = new SharedOutputStream(bits,bits.length,0);
        return like;
    }
    
    @Override
    public void write(int b)
    {
        resize(pos+1);
        target[pos++]=(byte)b;
    }

    @Override
    public void write(byte[] b, int off, int len)
    {
        resize(pos+len);
        System.arraycopy(b,off,target,pos,len);
        pos+=len;
    }

    @Override
    public void write(byte[] b) 
    {
        write(b,0,b.length);
    }
    
    public void pack()
    {
        target=toByteArray();
        size=target.length;
    }
    
    public void reset()
    {
        pos=0;
    }
    
    public void skip(long ofs)
    {
        pos+=ofs;
    }
    
    public byte[] getBytes()
    {
        return target;
    }

    public int getLastByte()
    {
        if (pos==0) return -1;
        return target[pos-1];
    }
    
    public void shrink()
    {
        if (pos>0) pos--;
    }
    
    public int getSize()
    {
        return pos;
    }
    
    public byte[] toByteArray()
    {
        byte b[]=new byte[pos];
        System.arraycopy(target,0,b,0,pos);
        return b;
    }
    
    private void resize(int reqSize) {
        if (reqSize<=size) return;
        if (size<target.length) {
            size=target.length; 
            if (reqSize<=size) return;
        }
        
        int nsize=size;
        if (nsize<=0) nsize=256; 
        while (nsize<=reqSize) { nsize=nsize<<1; } // times 2
        
        byte nbuffer[] = new byte[nsize];
        
        System.arraycopy(target,0,nbuffer,0,pos);
        
        target=nbuffer;
        size=nsize;
    }
    
    public boolean equals(Object o) {
        if (o instanceof SharedOutputStream) {
            SharedOutputStream so = (SharedOutputStream)o;
            if (so.pos!=this.pos) return false;
            for (int scan=0;scan<this.pos;scan++) {
                if (so.target[scan]!=this.target[scan]) return false;
            }
            return true;
        }
        return false;
    }
    
    private static char[] hex="0123456789abcdef".toCharArray();
    
    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        for (int scan=0;scan<pos;scan++) {
            byte b=target[scan];
            sb.append(hex[(b>>4)&0x0f]);
            sb.append(hex[(b)&0x0f]);
        }
        return sb.toString();
    }
}
