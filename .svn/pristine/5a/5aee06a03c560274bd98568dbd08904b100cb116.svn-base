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
package org.jclarion.clarion.compile.grammar;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Map;

import org.jclarion.clarion.compile.java.SimpleJavaCode;
import org.jclarion.clarion.compile.var.TargetJavaClass;
import org.jclarion.clarion.setting.SettingFile;

public class TargetOverrides {
    
    private static TargetOverrides instance;
    
    public static TargetOverrides getInstance()
    {
        if (instance==null) {
            synchronized(TargetOverrides.class) {
                if (instance==null) {
                    instance=new TargetOverrides();
                }
            }
        }
        return instance;
    }
    
    public static void clear()
    {
        instance=null;
    }

    private SettingFile windowOverrides ;
    
    public void loadWindowOverrides(String source) 
    {
        File dir = new File(source);
        File file = new File(dir,"win.properties");
        if (file.exists()) {
            windowOverrides=new SettingFile();
            try {
                windowOverrides.load(new FileReader(file));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    public void addOverrides(TargetJavaClass javaClass,String prefix,String sid) 
    {
        if (windowOverrides==null) return;
        Map<Integer,SettingFile.Value> entry = windowOverrides.getSettings(sid);
        if (entry==null) return;
        
        for ( Map.Entry<Integer,SettingFile.Value> scan : entry.entrySet() ) {
            
            StringBuilder str=new StringBuilder();
            str.append(prefix);
            
            str.append(".setProperty(");
            str.append(scan.getKey());
            str.append(",");
            String val = scan.getValue().getValue();
            if (val.matches("^[0-9]+$")) {
                str.append(val);
            } else {
                str.append('"');
                
                for (int sscan=0;sscan<val.length();sscan++) {
                    char c = val.charAt(sscan);
                    if (c=='\'' || c=='\\') {
                        str.append('\\');
                    }
                    str.append(c);
                }
                str.append('"');
            }
            str.append(");");
            
            javaClass.addInit(new SimpleJavaCode(str.toString()));
        }
    }

    
}
