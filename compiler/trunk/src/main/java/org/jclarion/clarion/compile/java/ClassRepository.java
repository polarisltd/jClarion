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
package org.jclarion.clarion.compile.java;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;

public class ClassRepository 
{
    private Map<String,JavaClass> classes=new HashMap<String, JavaClass>();
    private Map<String,Map<String,JavaClass>> structuredClasses = new HashMap<String, Map<String,JavaClass>>();
    
    public ClassRepository()
    {
    }
    
    public void add(JavaClass clazz,String namespace,String name)
    {
        name=Labeller.get(name,true);
        
        StringBuilder jname=new StringBuilder();
        jname.append(name);
        int count=0;
        while (true) {
        	
        	boolean match=false;        	
        	String testPkg = clazz.getPackage();
        	while ( true ) {
        		if (classes.containsKey(testPkg+"."+jname.toString())) {
        			match=true;
        			break;
        		}
        		int end = testPkg.lastIndexOf('.');
        		if (end==-1) break;
        		testPkg=testPkg.substring(0,end);
        	}
        	if (!match) break;
        	
            count++;
            jname.setLength(name.length());
            jname.append('_');
            jname.append(count);
        }
        
        String jname_string = jname.toString();
        String lname = clazz.getPackage()+"."+jname_string;        
        classes.put(lname,clazz);
        clazz.setName(jname_string);
        
        Map<String,JavaClass> key = structuredClasses.get(namespace);
        if (key==null) {
        	key=new HashMap<String,JavaClass>();
        	structuredClasses.put(namespace,key);
        }
        key.put(lname, clazz);
        
        
    }
    
    public Collection<JavaClass> getAll()
    {
        return classes.values();
    }

    public Collection<JavaClass> getAll(String namespace)
    {
    	if (namespace==null || namespace.length()==0) {
    		namespace=ClarionCompiler.RAW_BASE;
    	} else {
    		namespace=ClarionCompiler.RAW_BASE+"."+namespace;
    	}
    	Map<String,JavaClass> result = structuredClasses.get(namespace);
    	if (structuredClasses==null) {
    		return Collections.emptyList();
    	}    	
        return result.values();
    }
    
    public JavaClass get(String name)
    {
        return classes.get(ClarionCompiler.RAW_BASE+"."+name);
    }
    
    
    public void clear()
    {
        classes.clear();
        structuredClasses.clear();
    }
    
    public void clear(String namespace)
    {
    	Map<String,JavaClass> result = structuredClasses.remove(namespace);
    	if (structuredClasses==null) return;
    	for (String key : result.keySet()) {
    		classes.remove(key);
    	}    	
    }
}
