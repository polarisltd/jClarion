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

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionString;

public class CConfig {

    private static Map<String,CConfigImpl> config = new HashMap<String, CConfigImpl>();
    
    public static CConfigImpl getInstance(String name)
    {
        name=name.toLowerCase();
        synchronized(config) {
            CConfigImpl result = config.get(name);
            if (result==null) {
                result=new CConfigImpl(name);
                config.put(name,result);
            }
            return result;
        }
        
    }
    
    /**
     *  Get config file setting
     *  
     * @param section
     * @param key
     * @param def
     * @param file
     * @return
     */
    public static ClarionString getProperty(String section,String key,String def,String file) {
        if (file==null) file="win.ini";
        String result = getInstance(file).getProperty(section,key);
        if (result==null) result=def;
        if (result==null) result="";
        return new ClarionString(result);
    }

    /**
     *  Set config file setting
     *  
     * @param section
     * @param key
     * @param val
     * @param file
     */
    public static void setProperty(String section,String key,String val,String file) {
        if (file==null) file="win.ini";
        getInstance(file).setProperty(section,key,val);
    }

}
