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

public class JavaDependencies implements JavaDependency
{
    private JavaDependency bits[];
    
    public JavaDependencies(JavaDependency... bits)
    {
        this.bits=bits;
    }
    

    @Override
    public void collate(JavaDependencyCollector collector) {
        for (int scan=0;scan<bits.length;scan++) {
            bits[scan].collate(collector);
        }
    }
}
