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

import org.jclarion.clarion.ClarionRandomAccessFile;
import org.jclarion.clarion.swing.gui.FileServer;
import org.jclarion.clarion.swing.gui.GUIModel;

public class DefaultClientFactory extends ClarionFileFactory 
{
    @Override
    public ClarionRandomAccessFile getRandomAccessFile(String name) throws FileNotFoundException 
    {
       	return GUIModel.getClient().getFile(name);
    }

    @Override
    public Boolean create(String name) {
       	return FileServer.getInstance().create(name);
    }

    @Override
    public Boolean delete(String name) {
       	return FileServer.getInstance().delete(name);
    }

	@Override
	public Boolean isDirectory(String name) {
        return FileServer.getInstance().isDirectory(name);
	}

	@Override
	public Long lastModified(String name) {
       	return FileServer.getInstance().lastModified(name);
	}

	@Override
	public boolean isServerFactory() {
		return false;
	}
	
	
}
