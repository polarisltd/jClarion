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

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.print.PDFFile;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.swing.gui.FileServer;
import org.jclarion.clarion.swing.gui.GUIModel;

public class DefaultFileFactory extends ClarionFileFactory 
{
    @Override
    public ClarionRandomAccessFile getRandomAccessFile(String name) throws FileNotFoundException 
    {
    	return getRandomAccessFile(name,true);
    }
    	
    @Override
    public ClarionRandomAccessFile getRandomAccessFile(String name,boolean useGuiModel) throws FileNotFoundException 
    {
        
        if (name.startsWith("print:/")) {
            return new PDFFile(name);
        }

        if (name.startsWith("memory:/")) {
            return new MemoryFile(name,false);
        }

        if (name.startsWith("resource:/")) {
            return new ResourceClarionFile(name.substring(10));
        }
        
        if (name.indexOf(":")>-1) {
            String lname = name.toLowerCase();
            if (lname.startsWith("http://") || lname.startsWith("https://")) 
            {
                try {
                    return new URLFile(new URL(name));
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        File f = ClarionFileFactory.getInstance().getFile(name);
        if (useGuiModel) {
        	return GUIModel.getClient().getFile(f);
        } else {
        	return new ClarionRandomAccessFileSystemFile(f);
        }
    }

    @Override
    public Boolean create(String name) {
        if (name.startsWith("print:/")) return null;
        if (name.startsWith("memory:/")) {
            (new MemoryFile()).getPayload().store(name);
            return true;
        }
        File f = ClarionFileFactory.getInstance().getFile(name);
        if (f.getClass()==File.class) {
        	return FileServer.getInstance().create(name);
        } else {
	        try {
	            f.delete();
	            return f.createNewFile();
	        } catch (IOException e) {
	            return false;
	        }        	
        }
    }

    @Override
    public Boolean delete(String name) {
        if (name.startsWith("print:/")) {
            int page = Integer.parseInt(name.trim().substring(7));
            Page p = (Page)CMemory.resolveAddress(page);
            p.delete();
            return true;
        }
        if (name.startsWith("memory:/")) {
            try {
				(new MemoryFile(name,false)).getPayload().free();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
            return true;
        }
        File f = ClarionFileFactory.getInstance().getFile(name);
        if (f.getClass()==File.class) {
        	return FileServer.getInstance().delete(name);
        } else {
        	return f.delete();
        }
    }

    @Override
    public File getFile(String name) {
        name=name.replace('\\',File.separatorChar);
        File f = new File(name);
        if (!f.isAbsolute()) {
            f=(new File(CFile.pwd,name));
        }
        f=f.getAbsoluteFile();
        try {
            return f.getCanonicalFile();
        } catch (IOException e) {
            return f;
        }    
    }
}
