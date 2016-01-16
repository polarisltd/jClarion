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

public class OpenMonitor {

    private boolean opened;
    
    public OpenMonitor() {
    }
    
    public void setOpened()
    {
        synchronized(this) {
            opened=true;
            notifyAll();
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
}
