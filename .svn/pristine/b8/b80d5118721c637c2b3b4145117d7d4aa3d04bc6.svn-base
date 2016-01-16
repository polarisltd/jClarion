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

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class JavaDependencyCollector 
{
    private String ignore;
    
    private boolean isPrototype;
    
    public JavaDependencyCollector()
    {
    }

    public JavaDependencyCollector(String ignore)
    {
        this.ignore=ignore;
    }
    
    private Set<String> dependencies=new TreeSet<String>();
    private List<JavaCode> code=new ArrayList<JavaCode>();
    
    public void add(String name)
    {
        if (ignore!=null && ignore.equals(name)) return;
        dependencies.add(name);
    }
    
    public void add(JavaCode code) {
    	this.code.add(code);
    }
    
    public List<JavaCode> getCode()
    {
    	return this.code;
    }
    
    public Set<String> get()
    {
        return dependencies;
    }
    
    public void setPrototype()
    {
        isPrototype=true;
    }
    
    public boolean isPrototype()
    {
        return isPrototype;
    }

}
