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

import java.util.HashSet;
import java.util.Set;

public abstract class ManipulableJavaCode extends JavaCode {

    private Set<Integer> settings;
    
    public JavaCode setCertain(JavaControl... control)
    {
        if (settings==null) {
            settings=new HashSet<Integer>();
        }
        for (int scan=0;scan<control.length;scan++) {
            settings.add(control[scan].ordinal());
        }
        
        return this;
    }

    @Override
    public boolean isCertain(JavaControl control) {
        if (settings!=null && settings.contains(control.ordinal())) return true; 
        return super.isCertain(control);
    }
}
