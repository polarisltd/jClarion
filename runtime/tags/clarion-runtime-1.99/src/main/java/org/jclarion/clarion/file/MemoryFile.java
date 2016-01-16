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
package org.jclarion.clarion.file;

import java.io.FileNotFoundException;
import java.io.IOException;

import org.jclarion.clarion.ClarionRandomAccessFile;

public class MemoryFile extends ClarionRandomAccessFile
{
    public static String copyFileIntoMemory(String name)
    {
        try {
            ClarionRandomAccessFile cff;
            cff = FileFactoryRepository.getInstance().getRandomAccessFile(name);
            if (cff==null) return "";
            MemoryFile mf = new MemoryFile(cff);
            return mf.getPayload().store();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }
    
    private MemoryFileSystem payload;
    private int     pos=0;

    public MemoryFile()
    {
        payload=new MemoryFileSystem();
    }
    
    public MemoryFile(String name,boolean create) throws FileNotFoundException
    {
        MemoryFileSystem p = MemoryFileSystem.get(name);
        if (p!=null) {
            payload=p;
        } else {
        	if (!create) throw new FileNotFoundException(name);
            payload=new MemoryFileSystem();
        }
    }

    public MemoryFile(byte payload[])
    {
        this(payload,payload.length);
    }

    public MemoryFile(byte content[],int size)
    {
        payload=new MemoryFileSystem();
        byte b[] = new byte[size];
        System.arraycopy(content,0,b,0,size);
        payload.setContent(b,size);
    }
    

    public MemoryFile(ClarionRandomAccessFile from)
    {
        try {
            this.payload=new MemoryFileSystem();
            byte[] buffer = new byte[(int)from.length()];
            
            from.seek(0);
            while ( true ) {
                int read = from.read(buffer,pos,buffer.length-pos);
                if (read<=0) break;
                pos+=read;
            }
            this.payload.setContent(buffer,pos);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public MemoryFileSystem getPayload()
    {
        return payload;
    }
    
    @Override
    public void close() throws IOException 
    {
    }

    @Override
    public long length() throws IOException 
    {
        return payload.getSize();
    }

    @Override
    public int read(byte[] get_buffer, int i, int read) throws IOException {
        
        if (read+pos>payload.getSize()) read=payload.getSize()-pos;
        if (read<=0) return 0;
        payload.read(pos,get_buffer,i,read);
        pos+=read;
        return read;
    }

    @Override
    public void seek(long l) throws IOException {
    	payload.write(null,0,(int)l,0);
        pos=(int)l;
    }

    @Override
    public void write(byte[] bytes, int i, int size) throws IOException {
        payload.write(bytes,i,pos,size);
        pos+=size;
    }

    @Override
    public String getName() {
        return payload.getStoreName(); 
    }

    @Override
    public long position() throws IOException {
        return pos;
    }
    
}
