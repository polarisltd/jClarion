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
package org.jclarion.clarion.setting;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class DefaultSetting {
    
    private static SettingFile instance;
    
    public static void reload()
    {
        instance=null;
    }
    
    public static SettingFile getInstance()
    {
        if (instance==null) {
            synchronized(DefaultSetting.class) {
                if (instance==null) {
                    instance=new SettingFile();
                    
                    InputStream is = DefaultSetting.class.getClassLoader().getResourceAsStream("resources/win.properties");
                    if (is!=null) {
                        try {
                            instance.load(new InputStreamReader(is));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    
                    File f = new File("win.properties");
                    if (f.exists()) {
                        try {
                            FileReader fr = new FileReader(f);
                            instance.load(fr);
                            fr.close();
                        } catch (IOException ex){  }
                    }
                }
            }
        }
        return instance;
        
    }

}
