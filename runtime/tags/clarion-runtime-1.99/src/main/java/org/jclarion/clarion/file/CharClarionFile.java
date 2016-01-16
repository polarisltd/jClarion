package org.jclarion.clarion.file;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import java.nio.charset.CoderResult;
import java.nio.charset.CodingErrorAction;

import org.jclarion.clarion.ClarionRandomAccessCharFile;
import org.jclarion.clarion.ClarionRandomAccessFile;

/**
 * Wrap random access file as a char array
 * 
 * Seek positions are all based on BYTE position 
 * 
 * @author barney
 *
 */

public class CharClarionFile extends ClarionRandomAccessCharFile
{
    private ClarionRandomAccessFile file;
    private Charset                 charset;
    private CharsetEncoder          encoder;
    private CharsetDecoder          decoder;
    private int                     decoderEnd;
    
    private byte                    readBytes[];
    private char                    readChars[];
    private ByteBuffer              readByteBuffer; 
    private CharBuffer              readCharBuffer;
    private int 					readLength;
    
    private Integer                 headerLength;
    
    public CharClarionFile(ClarionRandomAccessFile file)
    {
        this.file=file;
        try {
            charset=Charset.forName(System.getProperty("file.encoding"));
        } catch (RuntimeException ex) { 
            charset=Charset.defaultCharset();
        }
        encoder=charset.newEncoder();
        decoder=charset.newDecoder();
        decoder.onMalformedInput(CodingErrorAction.REPLACE);
        decoder.onUnmappableCharacter(CodingErrorAction.REPLACE);
        encoder.onMalformedInput(CodingErrorAction.REPLACE);
        encoder.onUnmappableCharacter(CodingErrorAction.REPLACE);
        
        readBytes=new byte[512];
        readChars=new char[1];
        readByteBuffer=ByteBuffer.wrap(readBytes);
        readCharBuffer=CharBuffer.wrap(readChars);

        resetRead();
    }
    
    @Override
    public void close() throws IOException 
    {
        file.close();
    }
    
    @Override
    public String getName() {
        return file.getName();
    }

    @Override
    public long length() throws IOException 
    {
        return file.length();
    }
    
    @Override
    public int read() throws IOException {
        
        MAIN: while ( true ) {
            CoderResult result=null;
            switch (decoderEnd) {
                case 0:
                    result = decoder.decode(readByteBuffer,readCharBuffer,false);
                    break;
                case 1:
                    result = decoder.decode(readByteBuffer,readCharBuffer,true);
                    decoderEnd++;
                    break;
                case 2:
                    result = decoder.flush(readCharBuffer);
                    break;
                default:
                    break MAIN;
            }
            
            if (result.isOverflow()) break;
            
            if (result.isUnderflow()) {
                if (decoderEnd==2) {
                    decoderEnd=3;
                } else {
                	if (readByteBuffer.limit()<readLength)
                	{
                		readByteBuffer.limit(readByteBuffer.limit()+1);
                	} else {
                		readByteBuffer.clear();
                		int len = file.read(readBytes,0,readBytes.length);
                		if (len<=0) {
                			readByteBuffer.limit(0);
                			decoderEnd=1;
                			readLength=0;
                		} else {
                			readByteBuffer.limit(1);
                			readLength=len;
                		}
                    }
                	if (!readCharBuffer.hasRemaining()) {
                		break; 
                	}                	                
                }
                continue;
            }
            
            // assume error. Skip character and continue
            readCharBuffer.clear();
        }
        if (readCharBuffer.position()==1) {
            readCharBuffer.clear();
        	if (readByteBuffer.limit()<readLength && !readByteBuffer.hasRemaining()) {
        		readByteBuffer.limit(readByteBuffer.limit()+1);
        	}
            return readChars[0];
        } else {
            return -1;
        }
    }
    
    @Override
    public void seek(long l) throws IOException {
        file.seek(l);
        resetRead();
    }
    
    @Override
    public void write(char[] bytes, int ofs, int len) throws IOException {
        long position=position();
        file.seek(position);
        encoder.reset();
        
        CharBuffer write=CharBuffer.wrap(bytes,ofs,len);

        if (position>0 && (headerLength==null || headerLength>0) ) {
            readByteBuffer.clear();
            
            readCharBuffer.clear();
            readCharBuffer.limit(0);
            
            encoder.encode(readCharBuffer,readByteBuffer,false);
            headerLength=readByteBuffer.position();
            
            readCharBuffer.clear();
        }
        
        while ( true ) {
            readByteBuffer.clear();
            CoderResult result = encoder.encode(write,readByteBuffer,false);
            file.write(readBytes,0,readByteBuffer.position());
            if (result==CoderResult.UNDERFLOW) {
                break;
            }
        }
        
        readByteBuffer.clear();
        CoderResult result = encoder.encode(write,readByteBuffer,true);
        file.write(readBytes,0,readByteBuffer.position());
        
        while ( true ) {
            readByteBuffer.clear();
            result = encoder.flush(readByteBuffer);
            file.write(readBytes,0,readByteBuffer.position());
            if (result==CoderResult.UNDERFLOW) {
                break;
            }
        }
        readByteBuffer.clear();
        resetRead();
    }

    @Override
    public long position() throws IOException {
        return file.position()-readLength+readByteBuffer.position();
    }

    public void resetRead()
    {
        readByteBuffer.clear();
        readByteBuffer.limit(0);
        decoder.reset();
        decoderEnd=0;
        readLength=0;
    }
}
