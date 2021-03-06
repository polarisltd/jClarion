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
package org.jclarion.clarion.compile.javac;


public class ClarionClassLoader extends ClassLoader {
    
    private ClarionFileManager cfm;
    
    public ClarionClassLoader(ClassLoader parent,ClarionFileManager cfm)
    {
        super(parent);
        this.cfm=cfm;
    }

    @Override
    protected Class<?> findClass(String name) throws ClassNotFoundException {
        
        ClarionJavaFileObject o = cfm.getTarget(name);
        if (o==null) return null;
        return defineClass(name,o.getData().getBytes(),0,o.getData().getSize());
    }
}
