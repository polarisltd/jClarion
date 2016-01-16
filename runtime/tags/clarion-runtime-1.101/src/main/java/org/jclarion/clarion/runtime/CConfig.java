package org.jclarion.clarion.runtime;

import org.jclarion.clarion.swing.gui.GUIModel;

public class CConfig 
{
	public static CConfigImpl getInstance(String name)
	{
		return GUIModel.getClient().getConfig(name);
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
    public static String getProperty(String section,String key,String def,String file) {
        if (file==null) file="win.ini";
        String result = getInstance(file).getProperty(section,key);
        if (result==null) result=def;
        if (result==null) result="";
        return result;
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
