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

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.PropertyObject;

public class SettingFile 
{
    public static class Value
    {
        private String type;
        private String value;
        
        public Value(String type,String value)
        {
            this.type=type;
            this.value=value;
        }
        
        public Value(String value)
        {
            this.value=value;
        }
     
        public String getType()
        {
            return type;
        }
        
        public String getValue()
        {
            return value;
        }
        
        private ClarionObject result;

        public ClarionObject getClarionObject() 
        {
            if (result==null) result=new ClarionString(value);
            return result.genericLike();
        }
    }
    
    private Map<String,Map<Integer,Value>> settings;
    
    public SettingFile()
    {
        //settings=new HashMap<String, Map<Integer,Value>>();
    }
    
    private void init()
    {
        if (settings==null) settings=new HashMap<String, Map<Integer,Value>>();
    }

    public void save(Writer w) throws IOException
    {
        if (settings==null) return;
        
        BufferedWriter bw;
        if (w instanceof BufferedWriter) {
            bw=(BufferedWriter)w;
        } else {
            bw=new BufferedWriter(w);
        }
        
        for (Map.Entry<String,Map<Integer,Value>> es : settings.entrySet() ) {
            
            for (Map.Entry<Integer,Value> ses : es.getValue().entrySet() ) {
                bw.write(es.getKey());
                bw.write('-');
                bw.write(String.valueOf(ses.getKey()));
                if (ses.getValue().type!=null) {
                    bw.write('(');
                    bw.write(ses.getValue().type);
                    bw.write(')');
                }
                bw.write('=');
                bw.write(ses.getValue().value);
                bw.write('\n');
            }
            bw.flush();
        }
        
    }
    
    public void load(Reader r) throws IOException
    {
        BufferedReader br;
        if (r instanceof BufferedReader) {
            br=(BufferedReader)r;
        } else {
            br=new BufferedReader(r);
        }
        
        while ( true ) {
            String line = br.readLine();
            if (line==null) break;
            
            int keypos = line.indexOf('-');
            if (keypos<0) continue;

            int keyendpos = line.indexOf('(',keypos+1);
            
            int endpos = line.indexOf('=',keypos+1);
            if (endpos<0) continue;
            
            String type=null;
            
            if (keyendpos>0 && keyendpos<endpos) {
                type=line.substring(keyendpos+1,endpos-1);
            } else {
                keyendpos=endpos;
            }
            
            
            String key = line.substring(0,keypos);
            String indx = line.substring(keypos+1,keyendpos);
            String value = line.substring(endpos+1);
            
            set(key,Integer.parseInt(indx),type,value);
        }
    }
    public void set(PropertyObject obj)
    {
        if (settings==null) return;
        
        Map<Integer,Value> entry = settings.get(obj.getId());
        if (entry==null) return;
        
        for (Map.Entry<Integer,Value> scan : entry.entrySet() )  {
            obj.setProperty(scan.getKey(),scan.getValue().getClarionObject());
        }
        
    }

    public Map<Integer,Value> getSettings(String key)
    {
        if (settings==null) return null;
        return settings.get(key);
    }

    public void set(String key, int indx, String type, String value) 
    {
        init();
        Map<Integer,Value> entry;
        entry = settings.get(key);
        if (entry==null) {
            entry=new HashMap<Integer,Value>();
            settings.put(key,entry);
        }
        
        Value val = entry.get(indx);
        if (val==null) {
            val=new Value(type,value);
            entry.put(indx,val);
        } else {
            val.value=value;
            if (type!=null) val.type=type;
        }
    }
}
