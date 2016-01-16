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
package org.jclarion.clarion.runtime;

import java.io.File;
import java.io.IOException;
import java.util.regex.Pattern;

import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.file.ClarionFileFactory;
import org.jclarion.clarion.file.FileFactoryRepository;
import org.jclarion.clarion.swing.gui.FileServer;

public class CFile {

	private static String path;
	
    /**
     * Get current path
     * 
     * @return
     */
    public static ClarionString getPath()
    {
    	if (path==null) {
    		path=FileServer.getInstance().getPath();
    	}
        return new ClarionString(path);
    }
    
    public static void clearPath()
    {
    	path=null;
    }

    /**
     * Get DOS path from long path
     * 
     * @param path
     * @return
     */
    public static ClarionString getShortPath(String path)
    {
        return new ClarionString(path);
    }
    
    /**
     * Set current path
     * 
     * @param path
     */
    public static void setPath(String path)
    {
    	path=path.trim();
    	if (!isAbsolute(path)) {
    		path=getPath()+"\\"+path;
    	}
    	if (ClarionFileFactory.getInstance().isDirectory(path)) {
    		CFile.path=path;
            CErrorImpl.getInstance().clearError();
        } else {
            CErrorImpl.getInstance().setError(03,"Path not found");
        }
    }

    /**
     *  Delete specified file
     *  
     * @param filename
     */
    public static void deleteFile(String filename)
    {
        FileFactoryRepository.getInstance().delete(filename);
    }

    public static void copyFile(String src,String target)
    {
        try {
            ClarionRandomAccessFile i = FileFactoryRepository.getInstance().getRandomAccessFile(src); 
            FileFactoryRepository.getInstance().create(target);
            ClarionRandomAccessFile o = FileFactoryRepository.getInstance().getRandomAccessFile(target);
            byte buffer[] = new byte[512];
            while ( true ) {
                int size=i.read(buffer,0,512);
                if (size<=0) break;
                o.write(buffer,0,size);
            }
            i.close();
            o.close();
            CErrorImpl.getInstance().clearError();
        } catch (IOException ex) {
            ex.printStackTrace();
            CErrorImpl.getInstance().setError(2,"Could not copy");
        }
    }
    
    
    /**
     *  Check if file exists
     *  
     * @param filename
     */
    public static boolean isFile(String filename)
    {
        try {
			ClarionFileFactory.getInstance().getRandomAccessFile(filename).close();
			return true;
		} catch (IOException e) {
			e.printStackTrace();
		}
        
        return false;
    }

    private static final int FA_READONLY = 1;
    private static final int FA_HIDDEN = 2;
    //private static final int FA_SYSTEM = 4;
    private static final int FA_DIRECTORY = 16;
    //private static final int FA_ARCHIVE = 32;
    
    /**
     *  Dump directory contents into specified queue
     *  
     *  queue format is:
     *     (opt) long name
     *     name
     *     date
     *     time
     *     size
     *     attributes
     *     
     *  attribute bitmask is
     *     readonly :  1
     *     hidden   :  2
     *     system   :  4
     *     directory : 16
     *     archive   : 32
     *     
     *     
     *  
     * @param queue
     * @param dir
     * @param mode
     * @return
     */
    public static void getDirectoryListing(ClarionQueue queue,String dir,int mode)
    {
        boolean longFormat = queue.flatWhat(2) instanceof ClarionString;
        int offset=longFormat?1:0;
        

        if ((mode & FA_DIRECTORY)!=0) {
            queue.clear();
            queue.flatWhat(1).setValue(".");
            if (longFormat) {
                queue.flatWhat(2).setValue(".");
            }
            queue.flatWhat(5+offset).setValue(FA_DIRECTORY);
            queue.add();
            queue.clear();
            queue.flatWhat(1).setValue("..");
            if (longFormat) {
                queue.flatWhat(2).setValue("..");
            }
            queue.flatWhat(5+offset).setValue(FA_DIRECTORY);
            queue.add();
        }
        
        Object[] kids = null;
        
       	kids=FileServer.getInstance().list(dir);
       	if (kids==null) return;
        
        for (Object kr : kids ) 
        {
        	String name;
        	long length;
        	long lastModified;
        	boolean canWrite,isHidden,isDirectory;
        	if (kr instanceof File) {
        		File kid = (File)kr;
        		name=kid.getName();
        		canWrite=kid.canWrite();
        		isHidden=kid.isHidden();
        		isDirectory=kid.isDirectory();
        		length=kid.length();
        		lastModified=kid.lastModified();
        	} else {
        		Object[] kid = (Object[])kr;
        		name=(String)kid[0];
        		canWrite = (Boolean)kid[1];
        		isHidden = (Boolean)kid[2];
        		isDirectory = (Boolean)kid[3];
        		lastModified = (Long)kid[4];
        		length = (Long)kid[5];
        	}
    	
            if (((mode & FA_READONLY)==0) && !canWrite) continue;
            if (((mode & FA_HIDDEN)==0) && isHidden) continue;
            if (((mode & FA_DIRECTORY)==0) && isDirectory) continue;
            
            queue.flatWhat(1).setValue(name);
            if (longFormat) {
                queue.flatWhat(2).setValue(name);
            }

            int clarionDate= CDate.epochToClarionDate(offset);
            
            int clarionTime = (int)((lastModified-CDate.clarionDateToEpoch(clarionDate))/10+1);
            
            queue.flatWhat(2+offset).setValue(clarionDate);
            queue.flatWhat(3+offset).setValue(clarionTime);
            
            queue.flatWhat(4+offset).setValue((int)length);
            
            queue.flatWhat(5+offset).setValue(
                    (!canWrite ? FA_READONLY : 0 ) +
                    (isHidden ? FA_HIDDEN : 0 ) +
                    (isDirectory ? FA_DIRECTORY : 0 ) );
            
            queue.add();
        }
    }

    private static Pattern absolute = Pattern.compile("^(([a-zA-Z0-9]+:)|/|\\\\).*");    	

    public static boolean isAbsolute(String dir)
    {
    	boolean result=absolute.matcher(dir).matches();
    	return result;
    }
}
