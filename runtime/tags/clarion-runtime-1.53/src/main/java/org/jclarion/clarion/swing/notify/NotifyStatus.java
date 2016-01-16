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
package org.jclarion.clarion.swing.notify;

public class NotifyStatus 
{
    private boolean processed;
    
    public synchronized boolean isProcessed()
    {
        return processed;
    }
    
    public synchronized void setProcessed()
    {
        processed=true;
    }

}
