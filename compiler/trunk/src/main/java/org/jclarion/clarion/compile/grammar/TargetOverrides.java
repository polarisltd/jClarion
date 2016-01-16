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
import java.util.Map;

import org.jclarion.clarion.compile.java.SimpleJavaCode;
import org.jclarion.clarion.compile.var.TargetJavaClass;
import org.jclarion.clarion.lang.AbstractLexStream;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.setting.SettingFile;

public class TargetOverrides {
    private SettingFile windowOverrides;
    
    public void loadWindowOverrides(Lexer l) 
    {
    	if (l==null) return;
    	windowOverrides=new SettingFile();
    	AbstractLexStream stream = l.getStream();
    	
    	while ( true ) {
    		if (l.eof()) break;
    		String key=readUntil(stream,"-");
    		String prop=readUntil(stream,"(=");
    		String type=null;
    		if (stream.peek(0)=='(') {
    			stream.read();
    			type=readUntil(stream,")");
    			readUntil(stream,"=");
    		}
    		String value=readUntil(stream,"\n");
    		
    		if (key.length()==0 || prop.length()==0) continue;    		
    		windowOverrides.set(key,Integer.parseInt(prop),type,value);    		
    	}
    }
    
    private String readUntil(AbstractLexStream stream, String bits) 
    {
    	stream.getToken();
    	while ( !stream.eof() ) {
    		char next = stream.peek(0);
    		for (int scan=0;scan<bits.length();scan++) {
    			if (bits.charAt(scan)==next) {
    				String result=stream.getToken();
    				stream.read();
    				return result;
    			}
    		}
    		stream.read();
    	}
		return stream.getToken();
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
