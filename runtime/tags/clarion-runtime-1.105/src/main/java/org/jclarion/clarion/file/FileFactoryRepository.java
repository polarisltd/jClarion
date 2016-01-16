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

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import org.jclarion.clarion.ClarionRandomAccessFile;

public class FileFactoryRepository extends ClarionFileFactory
{
    private LinkedList<ClarionFileFactory> _factories;
    private LinkedList<ClarionFileFactory> _serverFactories;
    private LinkedList<ClarionFileFactory> _clientFactories;
    
    private LinkedList<ClarionFileFactory> scan=null;
    
    private Map<Class<? extends ClarionFileFactory>,ClarionFileFactory> uniqueFactories=new HashMap<Class<? extends ClarionFileFactory>,ClarionFileFactory>();
    
    public FileFactoryRepository()
    {
        _factories=new LinkedList<ClarionFileFactory>();
        _serverFactories=new LinkedList<ClarionFileFactory>();
        _clientFactories=new LinkedList<ClarionFileFactory>();
    	scan=_factories;
    }
    
    private FileFactoryRepository(LinkedList<ClarionFileFactory> scan)
    {
    	this.scan=scan;
    }
    
    public FileFactoryRepository getServerOnly()
    {
    	return new FileFactoryRepository(_serverFactories);
    }

    public FileFactoryRepository getClientOnly()
    {
    	return new FileFactoryRepository(_clientFactories);
    }
    
    public void addFactory(ClarionFileFactory factory)
    {
        if (uniqueFactories.containsKey(factory.getClass())) return;
        uniqueFactories.put(factory.getClass(),factory);
        _factories.addFirst(factory);
        if (factory.isServerFactory()) {
        	_serverFactories.addFirst(factory);
        } else {
        	_clientFactories.addFirst(factory);        	
        }
    }

    public void removeFactory(Class<? extends ClarionFileFactory> factory)
    {
        ClarionFileFactory cff = uniqueFactories.remove(factory);
        if (cff!=null) {
           _factories.remove(cff);
            if (cff.isServerFactory()) {
            	_serverFactories.remove(cff);
            } else {
            	_clientFactories.remove(cff);        	
            }
        }
    }
    
    @Override
    public ClarionRandomAccessFile getRandomAccessFile(String file) throws IOException 
    {
        for ( ClarionFileFactory cff : scan ) {
            ClarionRandomAccessFile result = cff.getRandomAccessFile(file);
            if (result!=null) {

                while ( true ) {
                    ClarionRandomAccessFile decorate = null;
                    for ( ClarionFileFactory dec : scan ) {
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
        for ( ClarionFileFactory cff : scan ) {
            Boolean result = cff.create(name);
            if (result!=null) return result;
        }
        return null;
    }

    @Override
    public Boolean delete(String name) {
        for ( ClarionFileFactory cff : scan ) {
            Boolean result = cff.delete(name);
            if (result!=null) return result;
        }
        return null;
    }

	@Override
	public Boolean isDirectory(String name) {
        for ( ClarionFileFactory cff : scan ) {
            Boolean result = cff.isDirectory(name);
            if (result!=null) return result;
        }
        return null;
	}

	@Override
	public Long lastModified(String name) {
        for ( ClarionFileFactory cff : scan ) {
            Long result = cff.lastModified(name);
            if (result!=null) return result;
        }
        return null;
	}
}
