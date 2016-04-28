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

import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import org.jclarion.clarion.ClarionReport;

public class MemoryFileSystem 
{
    private static Logger log = Logger.getLogger(MemoryFileSystem.class.getName());	

	private static byte[] EMPTY = new byte[0];
    private static Map<String, MemoryFileSystem> storedFiles = new HashMap<String, MemoryFileSystem>();
    private static int storedFileCount = 1;

    private byte[] content = EMPTY;
    private int size;
    private String storeName;
    private long lastModified=System.currentTimeMillis();

    public static void deleteAll()
    {
    	storedFiles.clear();
    }
    
    public static int totalSize()
    {
        int totalsize=0;
        for (MemoryFileSystem mfs : storedFiles.values() ) {
            totalsize+=mfs.size;
        }
        return totalsize;
    }
    
    public static MemoryFileSystem get(String name)
    {
        return storedFiles.get(name.toLowerCase().trim());
    }
    

    public String store() {
        if (storeName == null) {
            storeName = "memory:/temp/" + (++storedFileCount);
            storedFiles.put(storeName,this);
        }
        return storeName;
    }

    public void store(String name) {
        free();
        storeName = name;
        storedFiles.put(storeName.toLowerCase().trim(),this);        
    }

    public void free() {
        if (storeName != null) {
            storedFiles.remove(storeName);
            storeName = null;
        }
    }

    public void setContent(byte[] content,int size)
    {
    	this.content=content;
    	this.size=size;
    	this.lastModified=System.currentTimeMillis();
    }
    
    public int getSize()
    {
    	return size;
    }
    
    public void read(int pos,byte[] target,int ofs,int len)
    {
    	System.arraycopy(content,pos,target,ofs,len);
    }
    
    public void write(byte src[],int pos,int ofs,int len)
    {
    	int newSize=size;    	
    	if (ofs+len>newSize) {
    		newSize=ofs+len;
    		if (newSize>content.length) {
    			int propSize = content.length;
    			if (propSize == 0) propSize = 256;
    			while (propSize < newSize) propSize = propSize << 1;
                byte newPayload[] = new byte[propSize];
                System.arraycopy(content, 0, newPayload, 0, size);
                content = newPayload;
    		}
    		size=newSize;
    	}
    	if (src!=null) {
    		System.arraycopy(src,pos,content,ofs,len);
    	}
    	lastModified=System.currentTimeMillis();
    }

    
    public void writeToFile(String strFilePath){   // %%%%%% save memory file into file system file.

    	try{
          FileOutputStream fos = new FileOutputStream(strFilePath);
          fos.write(content);
          log.fine("content written");
    	}catch(Exception e){
    	   log.fine("error writing file");	
    	}
    	
    }
    
    
    public String getStoreName()
    {
    	return storeName;
    }
    
    public long getLastModified()
    {
    	return lastModified;
    }
}
