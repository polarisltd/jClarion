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

public class CErrorImpl 
{
    private static CErrorImpl instance ;
    
    public static CErrorImpl getInstance()
    {
        if (instance==null) {
            synchronized(CErrorImpl.class) {
                if (instance==null) instance=new CErrorImpl(); 
            }
        }
        return instance;
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
