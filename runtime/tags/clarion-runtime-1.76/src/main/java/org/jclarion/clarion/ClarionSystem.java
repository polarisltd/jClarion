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
package org.jclarion.clarion;

import org.jclarion.clarion.runtime.CWin;

/**
 * Model 'system'. Mainly used to serve target property
 * 
 * @author barney
 *
 */
public class ClarionSystem extends PropertyObject
{
    private static ClarionSystem sInstance;
    
    /**
     * get system object
     * @return
     */
    public static ClarionSystem getInstance()
    {
        if (sInstance==null) sInstance=new ClarionSystem();
        return sInstance;
    }
    
    /**
     * Get current abstract target (as window)
     * 
     * @return
     */
    public ClarionWindow getTarget()
    {
        return (ClarionWindow)CWin.getTarget();
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        return null;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        // TODO Auto-generated method stub
        
    }
    
    
}
