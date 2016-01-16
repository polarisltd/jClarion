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

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.scope.ScopeSnapshot;

public class LocalIncludeCache {

    private static Map<String,ScopeSnapshot> includes=new HashMap<String, ScopeSnapshot>();
    
    public static ScopeSnapshot getIncludeSnapshot(String include)
    {
        include = LexerSource.getInstance().cleanName(include);
        return includes.get(include);
    }
    
    public static void clear()
    {
        includes.clear();
    }
    
    public static void setIncludeSnapshot(String include,ScopeSnapshot snap)
    {
        include = LexerSource.getInstance().cleanName(include);
        includes.put(include,snap);
    }
}
