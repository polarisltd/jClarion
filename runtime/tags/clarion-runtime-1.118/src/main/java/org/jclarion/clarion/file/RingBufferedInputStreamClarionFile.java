package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.InputStream;
import org.jclarion.clarion.ClarionRandomAccessFile;


public abstract class RingBufferedInputStreamClarionFile extends ClarionRandomAccessFile
{
    private byte buffer[]=new byte[16384]; // ring buffer
    private int head;
    private int tail;
    

    private boolean						tailLoop; // track if tail has looped. Used for figuring back buffer
    private long                        pos;
    private long						nextPos;
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
    	seekToNextPos();
    	
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
        nextPos+=len;
        return len;
    }

    @Override
    public void seek(long ofs) throws IOException 
    {
    	nextPos=ofs;
    }
    
    private void seekToNextPos() throws IOException
    {
        // read backwards - into ring buffer
        if (nextPos<pos) {
            
            long back = pos-nextPos;
            
            // we need to work out what part of ring buffer is read-ahead. The remainder
            int readahead=tail-head;
            if (readahead<0) readahead+=buffer.length;
            // i.e. head=0, tail=4. readahead=4.
            // i.e. head=16382. tail=1. readahead=1-16382+16384 = 3
            
            // work out back buffer. it is size of ring buffer less readahead. Note that
            // what we cannot rollback so far that head=tail. As head=tail has special meaning:
            // buffer is empty.We can only go far back as head=tail+1; which is full buffer.
            int backbuffer = tailLoop ? buffer.length-readahead-1 : head;
            
            // only go back as far as the back buffer
            if (back>backbuffer) {
                back=backbuffer;
            }
            
            head=head-(int)back;
            if (head<0) head+=buffer.length;
            pos=pos-back;
        }

        // read backwards - start all over
        if (nextPos<pos) {
            closeStream();
        }
        
        if (nextPos>pos+buffer.length) {
        	// position is way infront. skip input stream to correct positioning
        	
        	// calculate actual position of input stream
        	long actualPos=pos;
        	if (tail>head) {
        		actualPos+=(tail-head);
        	}
        	if (tail<head) {
        		actualPos+=(tail+buffer.length-head);        		
        	}
        	
        	long skip = nextPos-actualPos-buffer.length/2;
        	if (skip>0) {
        		pos=actualPos;
           		initBuffer();
        		head=0;
        		tail=0;
        		tailLoop=false;
        		while (skip>0) {
        			long thisSkip = stream.skip(skip);
        			if (thisSkip<=0) break;
        			pos+=thisSkip;
        			skip-=thisSkip;
        		}
        	}
        }
        
        // read ahead
        while (nextPos>pos) {
            if (head==tail) fillBuffer();
            if (head==tail) break;
            
            long len = nextPos-pos;
            
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

    private void initBuffer() throws IOException
    {
        if (stream==null) {
            stream=createStream();
            head=0;
            tail=0;
            pos=0;
            tailLoop=false;
        }            	
    }
    
    private void fillBuffer() throws IOException
    {
    	initBuffer();
    	
        int read=buffer.length-tail;
        
        // only read half buffer at a time so that we have some backbuffer
        if (read>buffer.length/2) read=buffer.length/2;
        
        // do not allow tail to overrun head
        if (tail<head && tail+read>=head) read = head-tail-1;
        if (read==0) return;
     
        read = stream.read(buffer,tail,read);
        if (read<=0) return;
        tail+=read;
        if (tail==buffer.length) {
        	tail=0;
        	tailLoop=true;
        }
    }
    
    protected void closeStream() throws IOException
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

    @Override
    public long position() throws IOException {
        return nextPos;
    }
    
    protected void adjustPosition(long adjust)
    {
    	nextPos=nextPos+adjust;
    }
}
