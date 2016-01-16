package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.InputStream;
import org.jclarion.clarion.ClarionRandomAccessFile;


public abstract class RingBufferedInputStreamClarionFile extends ClarionRandomAccessFile
{
    private byte buffer[]=new byte[16384]; // ring buffer
    private int head;
    private int tail;
    
    
    private long                        pos;
    private InputStream                 stream;

    public RingBufferedInputStreamClarionFile()
    {
    }
    
    @Override
    public void close() throws IOException 
    {
        closeStream();
    }

    private long lengthCache=-1;
    @Override
    public long length() throws IOException 
    {
        if (lengthCache==-1) {
            byte buffer[]=null;
            InputStream is = createStream();
            try {
                lengthCache=0;
                while (true) {
                    long len = is.skip(65536);
                    if (len>0) {
                        lengthCache+=len;
                        continue;
                    }
                    if (buffer==null) {
                        if (is.read()==-1) break;
                        lengthCache++;
                        buffer=new byte[1024];
                    } else {
                        len = is.read(buffer);
                        if (len<=0) break;
                        lengthCache+=len;
                    }       
                } 
            } finally {
                is.close();
            }
        }
        return lengthCache;
    }

    @Override
    public int read(byte[] target, int ofs, int len) throws IOException 
    {
        if (head==tail) fillBuffer();
        if (head==tail) return 0;
        
        int end=tail;
        if (end<head) {
            end=buffer.length;
        }
        if (head+len>end) {
            len=end-head;
        }
        
        System.arraycopy(buffer,head,target,ofs,len);

        head+=len;
        if (head==buffer.length) head=0;

        pos+=len;
        return len;
    }

    @Override
    public void seek(long ofs) throws IOException 
    {
        // read backwards - into ring buffer
        if (ofs<pos) {
            
            long back = pos-ofs;
            
            // we need to work out what part of ring buffer is read-ahead. The remainder
            int readahead=tail-head;
            if (readahead<0) readahead+=buffer.length;
            // i.e. head=0, tail=4. readahead=4.
            // i.e. head=16382. tail=1. readahead=1-16382+16384 = 3
            
            // work out back buffer. it is size of ring buffer less readahead. Note that
            // what can be held in a ring buffer is 1 less the buffer size
            int backbuffer = buffer.length-1-readahead;
            
            // only go back as far as the back buffer
            if (back>backbuffer) {
                back=backbuffer;
            }
            
            head=head-(int)back;
            if (head<0) head+=buffer.length;
            pos=pos-back;
        }

        // read backwards - start all over
        if (ofs<pos) {
            closeStream();
        }
        
        // read ahead
        while (ofs>pos) {
            if (head==tail) fillBuffer();
            if (head==tail) break;
            
            long len = ofs-pos;
            
            int end=tail;
            if (end<head) {
                end=buffer.length;
            }
            if (head+len>end) {
                len=end-head;
            }
            
            head+=(int)len;
            if (head==buffer.length) head=0;
            pos+=len;
        }
    }

    @Override
    public void write(byte[] arg0, int arg1, int arg2) throws IOException 
    {
        throw new IOException("Not supported");
    }
    
    protected abstract InputStream createStream() throws IOException;

    private void fillBuffer() throws IOException
    {
        if (stream==null) {
            stream=createStream();
            head=0;
            tail=0;
            pos=0;
        }
        
        int read=buffer.length-tail;
        
        // only read half buffer at a time so that we have some backbuffer
        if (read>buffer.length/2) read=buffer.length/2;
        
        // do not allow tail to overrun head
        if (tail<head && tail+read>=head) read = head-tail-1;
        if (read==0) return;
     
        read = stream.read(buffer,tail,read);
        if (read<=0) return;
        tail+=read;
        if (tail==buffer.length) tail=0;
    }
    
    private void closeStream() throws IOException
    {
        try {
            if (stream!=null) {
                stream.close();
            }
        } finally {
            stream=null;
            head=0;
            tail=0;
            pos=0;
        }
    }
}
