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

import java.util.HashSet;
import java.util.Set;

public class GrammarHelper {
    
    public static Set<String> list(String... elements) {
        Set<String> hs = new HashSet<String>();
        
        for (int scan=0;scan<elements.length;scan++) {
            hs.add(elements[scan]);
        }
        return hs;
    }
    
    public static String capitalise(String in)
    {
        if (in.length()==0) return null;
        return in.substring(0,1).toUpperCase()+in.substring(1).toLowerCase();
    }
}
