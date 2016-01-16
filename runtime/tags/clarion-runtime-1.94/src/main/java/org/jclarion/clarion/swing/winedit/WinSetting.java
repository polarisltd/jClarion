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
package org.jclarion.clarion.swing.winedit;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.jclarion.clarion.setting.SettingFile;

public class WinSetting 
{
    private static WinSetting instance;
    
    public static WinSetting getInstance()
    {
        if (instance==null) {
            synchronized(WinSetting.class) {
                if (instance==null) {
                    instance=new WinSetting();
                }
            }
        }
        return instance;
    }

    private SettingFile file;
    
    private WinSetting()
    {
    }
    
    private SettingFile getFile()
    {
        if (file==null) {
            file=new SettingFile();
            File f = new File("win.properties");
            if (f.exists()) {
                try {
                    FileReader fr = new FileReader(f); 
                    file.load(fr);
                    fr.close();
                } catch (IOException ex) { }
            }
        }
        return file;
    }

    public void set(String id,int key,String value)
    {
        getFile().set(id,key,null,value);
    }
    
    public void save()
    {
        if (file==null) return;
        try {
            FileWriter fr = new FileWriter("win.properties");
            file.save(fr);
            fr.close();
        } catch (IOException ex) { }
    }
}
