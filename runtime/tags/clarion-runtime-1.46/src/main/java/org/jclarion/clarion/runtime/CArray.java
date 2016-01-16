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

import org.jclarion.clarion.ClarionObject;

public class CArray {

    
    /**
     *  Empty 1d array
     * @param object
     */
    public static void clear(ClarionObject object[]) {
        for (int scan=1;scan<object.length;scan++) {
            if (object[scan]!=null) object[scan].clear();
        }
    }

    /**
     *  Empty 2d array
     * @param object
     */
    public static void clear(ClarionObject object[][]) {
        for (int scan=1;scan<object.length;scan++) {
            if (object[scan]!=null) clear(object[scan]);
        }
    }

    /**
     *  Empty 3d array
     * @param object
     */
    public static void clear(ClarionObject object[][][]) {
        throw new RuntimeException("Not yet implemented");
    }
    
    /**
     *  Set an array from another source 
     *  
     * @param target
     * @param source
     */
    public static void setValue(ClarionObject[] target,ClarionObject source)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    /**
     *  Set an array from another array
     *  
     *   Precisely what does this even do?
     *  
     * @param target
     * @param source
     */
    public static void setValue(ClarionObject[] target,ClarionObject source[])
    {
        throw new RuntimeException("Not yet implemented");
    }
    
}
