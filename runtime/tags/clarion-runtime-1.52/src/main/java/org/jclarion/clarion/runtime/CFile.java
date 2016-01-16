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

import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.file.ClarionFileFactory;
import org.jclarion.clarion.file.FileFactoryRepository;

public class CFile {

    public static File pwd;
    
    static {
        pwd=  new File("");
        pwd=pwd.getAbsoluteFile();
    };

    /**
     * Get current path
     * 
     * @return
     */
    public static ClarionString getPath()
    {
        return new ClarionString(pwd.toString());
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
        
        File new_pwd=ClarionFileFactory.getInstance().getFile(path);
        if (new_pwd.isDirectory()) {
            CErrorImpl.getInstance().clearError();
            pwd=new_pwd;
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
        File f = new File(filename);
        if (f.isAbsolute()) return f.isFile();
        return (new File(pwd,filename)).isFile();
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
        File f = resolveFile(dir);
        
        if (!f.isDirectory()) return;
        
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
        
        File kids[] = f.listFiles();
        for (File kid : kids ) 
        {
            if (((mode & FA_READONLY)==0) && !kid.canWrite()) continue;
            if (((mode & FA_HIDDEN)==0) && kid.isHidden()) continue;
            if (((mode & FA_DIRECTORY)==0) && kid.isDirectory()) continue;
            
            queue.flatWhat(1).setValue(kid.getName());
            if (longFormat) {
                queue.flatWhat(2).setValue(kid.getName());
            }

            long lastModified=kid.lastModified();
            
            int clarionDate= CDate.epochToClarionDate(offset);
            
            int clarionTime = (int)((lastModified-CDate.clarionDateToEpoch(clarionDate))/10+1);
            
            queue.flatWhat(2+offset).setValue(clarionDate);
            queue.flatWhat(3+offset).setValue(clarionTime);
            
            queue.flatWhat(4+offset).setValue((int)kid.length());
            
            queue.flatWhat(5+offset).setValue(
                    (!kid.canWrite() ? FA_READONLY : 0 ) +
                    (kid.isHidden() ? FA_HIDDEN : 0 ) +
                    (kid.isDirectory() ? FA_DIRECTORY : 0 ) );
            
            queue.add();
        }
    }
    
    public static File resolveFile(String dir)
    {
        File result = new File(dir);
        if (result.isAbsolute()) return result;
        return new File(pwd,dir);
    }

}
