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
package org.jclarion.clarion.util;


public class ClarionHooks {

    private static ClarionHooks instance;
    
    public static ClarionHooks getInstance()
    {
        if (instance==null) {
            synchronized(ClarionHooks.class) {
                if (instance==null) {
                    instance=new ClarionHooks();
                }
            }
        }
        return instance;
    }
}
