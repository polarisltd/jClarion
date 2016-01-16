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

import org.jclarion.clarion.primative.ActiveThreadMap;

public class CErrorImpl 
{
    private static ActiveThreadMap<CErrorImpl> instance =new ActiveThreadMap<CErrorImpl>();
    
    public static CErrorImpl getInstance()
    {
    	CErrorImpl i = instance.get(Thread.currentThread());
    	if (i==null) {
    		i=new CErrorImpl();
    		instance.put(Thread.currentThread(),i);
    	}
        return i;
    }
    
    private int errorcode;
    private String error;
    
    public void setError(int errorcode,String error)
    {
        this.error=error;
        this.errorcode=errorcode;;
    }
    
    public void clearError()
    {
        setError(0,"OK");
    }
    
    public int getErrorCode()
    {
        return errorcode;
    }
    
    public String getError()
    {
        return error;
    }
    
}
