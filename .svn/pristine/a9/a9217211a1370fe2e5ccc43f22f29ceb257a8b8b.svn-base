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
import java.io.IOException;

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.runtime.CRun;

public abstract class ClarionFileFactory 
{
    private static FileFactoryRepository instance; 
    
    public static FileFactoryRepository getInstance()
    {
        if (instance==null) {
            synchronized(ClarionFileFactory.class) {
                if (instance==null) {
                    instance=new FileFactoryRepository();
                    instance.addFactory(new DefaultFileFactory());
                    CRun.addShutdownHook(new Runnable() { 
                        public void run()
                        {
                            instance=null;
                        }
                    } );
                }
            }
        }
        return instance;
    }

    public abstract Boolean create(String name);

    public abstract Boolean delete(String name);

    public abstract File getFile(String name);

    public ClarionRandomAccessFile getRandomAccessFile(String name,boolean useGuiModel) throws IOException
    {
    	return getRandomAccessFile(name);
    }
    
    public abstract ClarionRandomAccessFile getRandomAccessFile(String name) throws IOException;
    
    public ClarionRandomAccessFile decorate(ClarionRandomAccessFile base) throws IOException
    {
        return null;
    }
    
}
