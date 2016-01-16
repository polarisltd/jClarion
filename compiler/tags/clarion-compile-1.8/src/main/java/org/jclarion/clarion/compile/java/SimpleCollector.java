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


public class SimpleCollector implements JavaDependency 
{
    private String[] dependencies;
    
    public SimpleCollector(String... dependencies)
    {
        this.dependencies=dependencies;
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        for (int scan=0;scan<dependencies.length;scan++) {
            collector.add(dependencies[scan]);
        }
    }
}
