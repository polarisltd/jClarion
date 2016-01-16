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
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import org.jclarion.clarion.ClarionRandomAccessFile;

public class FileFactoryRepository extends ClarionFileFactory
{
    private LinkedList<ClarionFileFactory> factories=new LinkedList<ClarionFileFactory>();
    private Map<Class<? extends ClarionFileFactory>,ClarionFileFactory> uniqueFactories=new HashMap<Class<? extends ClarionFileFactory>,ClarionFileFactory>();
    
    public void addFactory(ClarionFileFactory factory)
    {
        if (uniqueFactories.containsKey(factory.getClass())) return;
        uniqueFactories.put(factory.getClass(),factory);
        factories.addFirst(factory);
    }

    public void removeFactory(Class<? extends ClarionFileFactory> factory)
    {
        ClarionFileFactory cff = uniqueFactories.remove(factory);
        if (cff!=null) {
            factories.remove(cff);
        }
    }
    /*
    @Override
    public File getFile(String name) {
        for ( ClarionFileFactory cff : factories ) {
            File result = cff.getFile(name);
            if (result!=null) return result;
        }
        return null;
    }

    @Override
    public File getFile(File base, String name) {
        for ( ClarionFileFactory cff : factories ) {
            File result = cff.getFile(base,name);
            if (result!=null) return result;
        }
        return null;
    }
    */
    
    @Override
    public ClarionRandomAccessFile getRandomAccessFile(String file) throws IOException 
    {
        for ( ClarionFileFactory cff : factories ) {
            ClarionRandomAccessFile result = cff.getRandomAccessFile(file);
            if (result!=null) {

                while ( true ) {
                    ClarionRandomAccessFile decorate = null;
                    for ( ClarionFileFactory dec : factories ) {
                        decorate = dec.decorate(result);
                        if (decorate!=null) break;
                    }
                    
                    if (decorate==null) {
                        return result;
                    } else {
                        result=decorate;
                    }
                }
            }
        }
        
        
        return null;
    }

    @Override
    public Boolean create(String name) {
        for ( ClarionFileFactory cff : factories ) {
            Boolean result = cff.create(name);
            if (result!=null) return result;
        }
        return null;
    }

    @Override
    public Boolean delete(String name) {
        for ( ClarionFileFactory cff : factories ) {
            Boolean result = cff.delete(name);
            if (result!=null) return result;
        }
        return null;
    }

    @Override
    public File getFile(String name) {
        for ( ClarionFileFactory cff : factories ) {
            File result = cff.getFile(name);
            if (result!=null) return result;
        }
        return null;
    }

}
