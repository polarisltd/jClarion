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
package org.jclarion.clarion;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.file.ClarionFileFactory;
import org.jclarion.clarion.runtime.CErrorImpl;
import org.jclarion.clarion.util.SharedOutputStream;

public class ClarionBinaryFile extends ClarionFile 
{
    private ClarionRandomAccessFile     file;    
    private SharedOutputStream          stream;
    private int                         recordSize;

    private byte[]  buffer=new byte[512];   // read buffer
    private int     buffer_size;            // # of bytes in buffer
    private int     buffer_offset;          // position inside buffer
    private long    buffer_position;        // position of buffer relative to file's seek
    
    private int     position;
    
    
    @Override
    public void add() 
    {
        add(recordSize);
    }

    @Override
    public void add(int size) {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        try {
            write(file.length(),size);
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(05,ex.getMessage());
        }
    }

    @Override
    public boolean bof() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void buffer(Integer pagesize, Integer behind, Integer ahead,
            Integer timeout) {
    }

    @Override
    public void build() {
    }

    @Override
    public void close() 
    {
        if (file!=null) {
            try {
                file.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            file=null;
        }
    }

    @Override
    public void create() {
        String fname=getProperty(Prop.NAME).toString().trim();
        CErrorImpl.getInstance().clearError();
        if (!Boolean.TRUE.equals(ClarionFileFactory.getInstance().create(fname))) {
            CErrorImpl.getInstance().setError(5,"Could not create");
        }
    }

    @Override
    public void delete() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public boolean eof() {
        if (file==null) return true;
        try {
            return buffer_position+buffer_offset==file.length();
        } catch (IOException e) {
            return true;
        }
    }

    @Override
    public void flush() {
    }

    @Override
    public void freeState(int state) {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void get(ClarionKey akey) {
        throw new RuntimeException("Not supported");
    }

    private byte get_buffer[];
    
    @Override
    public void get(ClarionString pointer, Integer len) 
    {
        String s = pointer.toString();
        position = 
            ((s.charAt(0)&0xff)<<24)+
            ((s.charAt(1)&0xff)<<16)+
            ((s.charAt(2)&0xff)<<8)+
            ((s.charAt(3)&0xff));

        get(position,len);
    }
        
    @Override
    public void get(ClarionNumber position, Integer len) 
    {
        get(position.intValue(),len);
    }

    public void get(int position, Integer len) 
    {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
            return;
        }

        position--;
        int ilen=recordSize;
        if (len!=null) ilen=len;

        stream.reset();
        
        if (get_buffer==null) get_buffer=new byte[512];

        if (ilen>recordSize) ilen=recordSize;
        
        try {
            file.seek(position);
            
            while(true) {
                int read = ilen-stream.getSize();
                if (read<=0) break;
                if (read>get_buffer.length) read=get_buffer.length;
                read = file.read(get_buffer,0,read);
                if (read<=0) break;
                stream.write(get_buffer,0,read);
            }
            
            copyStreamToRecord();
            
        } catch (IOException ex) { 
            CErrorImpl.getInstance().setError(35,ex.getMessage());
        }
    }

    @Override
    public ClarionString getNulls() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public int getPointer() 
    {
        return (int)(position)+1;
    }

    @Override
    public ClarionString getPosition(ClarionKey key) 
    {
        if (key!=null) {
            throw new RuntimeException("Not supported");
        }
        
        char bits[] = new char[4];
        int pointer = getPointer();
        bits[0]=(char)((pointer>>24)&0xff);
        bits[1]=(char)((pointer>>16)&0xff);
        bits[2]=(char)((pointer>>8)&0xff);
        bits[3]=(char)((pointer)&0xff);

        return new ClarionString(new String(bits));
    }

    @Override
    public int getState() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void lock() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void next() {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
            return;
        }
        
        stream.reset();
        
        position = (int)buffer_position+buffer_offset;
        
        try {
            
            while ( true ) {
                if (buffer_offset==buffer_size) {
                    file.seek(buffer_position+buffer_size);
                    buffer_position=buffer_position+buffer_size;
                    buffer_size = file.read(buffer,0,buffer.length);
                    buffer_offset=0;
                    if (buffer_size<=0) {
                        buffer_size=0;
                        break;
                    }
                }
                
                int avail = buffer_size-buffer_offset;
                if (avail>recordSize-stream.getSize()) {
                    avail=recordSize-stream.getSize();
                }
                
                stream.write(buffer,buffer_offset,avail);
                buffer_offset+=avail;
                if (stream.getSize()==recordSize) break;
            }

            copyStreamToRecord();
            
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(33,ex.getMessage());
            return;
        }
    }

    
    @Override
    public void open(int mode) {
        
        String name = getProperty(Prop.NAME).toString().trim();
        
        try {
            file = ClarionFileFactory.getInstance().getRandomAccessFile(name);
        } catch (IOException e) {
            CErrorImpl.getInstance().setError(2,e.getMessage());
        }
        
        stream=new SharedOutputStream();
        try {
            this.serialize(stream);
        } catch (IOException e) { }
        recordSize=stream.getSize();
    }

    @Override
    public void previous() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void put() 
    {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        write(position,recordSize);
    }

    @Override
    public int records() {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        try {
            return (int)file.length()/recordSize;
        } catch (IOException ex) { 
            CErrorImpl.getInstance().setError(37,ex.getMessage());
            return 0;
        }
    }

    @Override
    public void reget(ClarionKey key,ClarionString string) {
        if (key!=null) {
            throw new RuntimeException("Not supported");
        }
        
        get(string,null);
    }

    @Override
    public void remove() {
        close();
        String fname=getProperty(Prop.NAME).toString().trim();
        ClarionFileFactory.getInstance().delete(fname);
    }

    @Override
    public void reset(ClarionKey key,ClarionString string) 
    {
        if (key!=null) {
            throw new RuntimeException("Not supported");
        }
        String s = string.toString();
        
        set( 
            ((s.charAt(0)&0xff)<<24)+
            ((s.charAt(1)&0xff)<<16)+
            ((s.charAt(2)&0xff)<<8)+
            ((s.charAt(3)&0xff)));
    }

    @Override
    public void restoreState(int state) {
        throw new RuntimeException("Not supported");
    }

    private Pattern sendPattern;
    

    @Override
    public void send(String operator) {
        operator=operator.toLowerCase();
        
        if (sendPattern==null) sendPattern=Pattern.compile("^\\s*/?\\s*(quickscan)\\s*=\\s*(.*?)\\s*$");
        Matcher m = sendPattern.matcher(operator);
        if (!m.matches()) throw new RuntimeException("Send command unknown:"+operator);
        
        //String key = m.group(1);
        //String value = m.group(2);
    }

    @Override
    public void set(ClarionKey key) {
        if (key!=null) {
            throw new RuntimeException("Not supported");
        }
        buffer_position=0;
        buffer_offset=0;
        buffer_size=0;
    }

    @Override
    public void set(int pos) 
    {
        CErrorImpl.getInstance().clearError();
        buffer_position=pos-1;
        buffer_offset=0;
        buffer_size=0;
    }

    @Override
    public void setNulls(ClarionString nulls) {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void stream() {
    }

    @Override
    public void unlock() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void watch() {
        throw new RuntimeException("Not supported");
    }

    @Override
    protected String getDriver() {
        return "DOS";
    }


    private void write(long pos,int len) 
    {
        try {
            file.seek(pos);
            
            stream.reset();
            this.serialize(stream);
            
            while (stream.getSize()<len) stream.write(' ');
            
            int size = stream.getSize();
            if (size>len) size=len;
            
            file.write(stream.getBytes(),0,size);
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(05,ex.getMessage());
        }
        
        buffer_position=buffer_position+buffer_offset;
        buffer_offset=0;
        buffer_size=0;
    }

    private void copyStreamToRecord()
    {
        if (stream.getSize()==0) {
            CErrorImpl.getInstance().setError(33,"File not found");
            return;
        }
        
        // pad with spaces
        while (stream.getSize()<recordSize) {
            stream.write(' ');
        }
        
        // serialize back
        try {
            this.deserialize(stream.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
}
