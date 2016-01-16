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

public class ClarionAsciiFile extends ClarionFile 
{
    private ClarionRandomAccessFile    file;
    private SharedOutputStream         stream;
    private int                        recordSize;

    private boolean clip=true;
    //private boolean ctrlZIsEOF=true;
    private byte    endOfRecord[] = new byte[] { (byte)'\r', (byte)'\n' };
    private int     tab=8;

    
    private byte[]  buffer=new byte[512];   // read buffer
    private int     buffer_size;            // # of bytes in buffer
    private int     buffer_offset;          // position inside buffer
    private long    buffer_position;        // position of buffer relative to file's seek
    
    private int     position;

    @Override
    public void add() {
        
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        try {
            write(file.length(),-1);
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(05,ex.getMessage());
        }
    }

    private void write(long pos,int len) 
    {
        try {
            file.seek(pos);
            
            stream.reset();
            this.serialize(stream);
            
            if (len>=0) {
                while (stream.getSize()<len) {
                    stream.write(' ');
                }
            }
            
            byte[] buffer = stream.getBytes();
            int size = stream.getSize();
            if (len>=0 && len<size) size=len;
            if (clip && len<0) {
                while (size>0 && buffer[size-1]==' ') {
                    size--;
                }
            }
            file.write(buffer,0,size);
            file.write(this.endOfRecord,0,this.endOfRecord.length);
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(05,ex.getMessage());
        }
        
        buffer_position=buffer_position+buffer_offset;
        buffer_offset=0;
        buffer_size=0;
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
            Integer timeout) 
    {
    }

    @Override
    public void build() 
    {
    }

    @Override
    public void close() {
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
    public void delete() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public boolean eof() 
    {
        if (file==null) return true;
        try {
            return buffer_position+buffer_offset==file.length();
        } catch (IOException e) {
            return true;
        }
    }

    @Override
    public void flush() 
    {
    }

    @Override
    public void freeState(int state) 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void get(ClarionKey akey) 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void get(ClarionString pointer, Integer len) 
    {
        if (len!=null) {
            throw new RuntimeException("Not supported");
        }
        reget(pointer);
    }

    @Override
    public void get(ClarionNumber position, Integer len) {
        if (len!=null) {
            throw new RuntimeException("Not supported");
        }
        CErrorImpl.getInstance().clearError();
        get(position.intValue()-1);
    }
    
    
    @Override
    public ClarionString getNulls() 
    {
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
    public int getState() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void lock() 
    {
        throw new RuntimeException("Not supported");
    }

    private boolean appendToStream(int next_byte)
    {
        if (next_byte== '\t') {
            
            if (tab>0) {
                stream.write(' ');
                while ( (stream.getSize()%tab) !=0 ) {
                    stream.write(' ');
                }
            } else if (tab==-100) {
                stream.write('\t');
            } else if (tab<0) {
                for (int scan=0;scan<-tab;scan++) {
                    stream.write(' ');
                }
            }
        } else {
            stream.write(next_byte);
        }
        return (next_byte==endOfRecord[endOfRecord.length-1]);
    }

    private void copyStreamToRecord()
    {
        if (stream.getSize()==0) {
            CErrorImpl.getInstance().setError(33,"File not found");
            return;
        }
        
        // remove record
        int eorTrim=endOfRecord.length;
        while (eorTrim>0) {
            if (endOfRecord[eorTrim-1]==stream.getLastByte()) {
                stream.shrink();
                eorTrim--;
            } else {
                break;
            }
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
    
    @Override
    public void next() 
    {
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
                if (appendToStream(buffer[buffer_offset++])) break;
            }

            copyStreamToRecord();
            
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(33,ex.getMessage());
            return;
        }
    }

    @Override
    public void open(int mode) 
    {
        String fname=getProperty(Prop.NAME).toString().trim();
        try {
            file=ClarionFileFactory.getInstance().getRandomAccessFile(fname);
            CErrorImpl.getInstance().clearError();
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
    public void previous() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void put() 
    {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        write(position,-1);
    }

    @Override
    public int records() 
    {
         throw new RuntimeException("Not supported");
    }

    @Override
    public void reget(ClarionKey key,ClarionString string) 
    {
        CErrorImpl.getInstance().clearError();
        if (key!=null) {
            throw new RuntimeException("Not yet implemented");
        }
        
        CErrorImpl.getInstance().clearError();
        String s = string.toString();
        
        position = 
            ((s.charAt(0)&0xff)<<24)+
            ((s.charAt(1)&0xff)<<16)+
            ((s.charAt(2)&0xff)<<8)+
            ((s.charAt(3)&0xff))-1;
     
        get(position);
    }
    
    private void get(int position)
    {
        stream.reset();
        
        try {
            file.seek(position);
            byte[] read=new byte[1];
            while ( true ) {
                int len = file.read(read,0,1);
                if (len<1) break;
                if (appendToStream(read[0])) break;
            }
        } catch (IOException e) {
            CErrorImpl.getInstance().setError(35,e.getMessage());
        }

        copyStreamToRecord();
    }

    @Override
    public void remove() {
        close();
        String fname=getProperty(Prop.NAME).toString().trim();
        CErrorImpl.getInstance().clearError();
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
    public void set(int pos) 
    {
        CErrorImpl.getInstance().clearError();
        buffer_position=pos-1;
        buffer_offset=0;
        buffer_size=0;
    }

    @Override
    public void restoreState(int state) 
    {
        throw new RuntimeException("Not supported");
    }

    private Pattern sendPattern;
    
    @Override
    public void send(String operator) {
        operator=operator.toLowerCase();
    
        if (sendPattern==null) sendPattern=Pattern.compile("^\\s*/?\\s*(clip|tab|ctrlziseof|endofrecord|quickscan)\\s*=\\s*(.*?)\\s*$");
        Matcher m = sendPattern.matcher(operator);
        if (!m.matches()) throw new RuntimeException("Send command unknown:"+operator);
        
        String key = m.group(1);
        String value = m.group(2);
        
        if (key.equals("clip")) {
            clip=value.equals("on");
        }
        if (key.equals("tab")) {
            tab=Integer.parseInt(value);
        }
    }

    @Override
    public void set(ClarionKey key) 
    {
        if (key!=null) {
            throw new RuntimeException("Not yet implemented");
        }
        
        buffer_position=0;
        buffer_offset=0;
        buffer_size=0;
    }


    @Override
    public void setNulls(ClarionString nulls) 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void stream() 
    {
    }

    @Override
    public void unlock() 
    {
    }

    @Override
    public void watch() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    protected String getDriver() {
        return "ASCII";
    }
    

}
