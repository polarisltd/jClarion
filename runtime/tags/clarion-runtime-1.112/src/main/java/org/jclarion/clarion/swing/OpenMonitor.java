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
package org.jclarion.clarion.swing;

import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.RemoteSemaphore;
import org.jclarion.clarion.swing.gui.RemoteTypes;

public class OpenMonitor implements RemoteSemaphore
{

    private boolean opened;
    
    public OpenMonitor() {
    }
    
    public void setOpened()
    {
        synchronized(this) {
            opened=true;
            notifyAll();
        }
        if (remote!=null) {
        	remote.send(this,null);
	        remote.dispose(this);					
        }
    }
    
    public boolean isOpen()
    {
        synchronized(this) {
            return opened;
        }
    }
    
    public void waitForOpen()
    {
        synchronized(this) {
            while (!opened) {
                try {
                    wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                    return;
                }
            }
        }
    }

    private int id;
    private GUIModel remote;
    
	@Override
	public int getID() {
		return id;
	}

	@Override
	public Object[] getMetaData() {
		return null;
	}

	@Override
	public int getType() {
		return RemoteTypes.SEM_OPEN_MONITOR;
	}

	@Override
	public void notify(Object result) {
		setOpened();
	}

	@Override
	public void setID(int id) {
		this.id=id;
	}

	@Override
	public void setID(int id, GUIModel remote) {
		this.id=id;
		this.remote=remote;
	}

	@Override
	public void setMetaData(Object[] o) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean isNetworkSemaphore() {
		return true;
	}
}
