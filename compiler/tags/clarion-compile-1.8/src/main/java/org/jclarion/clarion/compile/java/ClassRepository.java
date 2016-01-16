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
import java.util.HashMap;
import java.util.Map;

public class ClassRepository 
{
    private static Map<String,JavaClass> classes=new HashMap<String, JavaClass>();
    
    public static void add(JavaClass clazz,String name)
    {
        name=Labeller.get(name,true);
        
        StringBuilder jname=new StringBuilder();
        jname.append(name);
        int count=0;
        while (classes.containsKey(jname.toString())) {
            count++;
            jname.setLength(name.length());
            jname.append('_');
            jname.append(count);
        }
        
        String jname_string = jname.toString();
        classes.put(jname_string,clazz);
        clazz.setName(jname_string);
    }
    
    public static Collection<JavaClass> getAll()
    {
        return classes.values();
    }
    
    public static JavaClass get(String name)
    {
        return classes.get(name);
    }
    
    public static void clear()
    {
        classes.clear();
    }
}
