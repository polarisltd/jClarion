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


public class CError {

    /**
     *  Get last error code
     *  
     *  All error codes are in equates
     *  
     * @return
     */
    public static int errorCode()
    {
        return CErrorImpl.getInstance().getErrorCode();
    }

    /**
     *  Get descriptive error string
     * @return
     */
    public static String error()
    {
        return CErrorImpl.getInstance().getError();
    }

    /**
     *  Get native error message from file driver for file related errors
     *  Applies when errorcode is 90
     *  
     * @return
     */
    public static String fileError()
    {
        return "";
    }
    
    /**
     * Get file error applies to
     */
    public static String errorFile()
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     *  Get native error code from file driver for file related errors
     *  Applies when errorcode is 90
     *  
     * @return
     */
    public static String fileErrorCode()
    {
        return "";
    }
    
    
}
