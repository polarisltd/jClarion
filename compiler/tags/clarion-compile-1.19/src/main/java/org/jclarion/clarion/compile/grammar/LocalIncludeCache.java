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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.compile.scope.ScopeSnapshot;

public class LocalIncludeCache {

    private static Map<String,ScopeSnapshot> includes=new HashMap<String, ScopeSnapshot>();
    private static List<List<String>>       alsoInclude=new ArrayList<List<String>>();
    
    public static ScopeSnapshot getIncludeSnapshot(String include)
    {
        include = LexerSource.getInstance().cleanName(include);
        return includes.get(include);
    }
    
    public static void clear()
    {
        includes.clear();
        alsoInclude.clear();
    }
    
    public static void setIncludeSnapshot(String include,ScopeSnapshot snap)
    {
        include = LexerSource.getInstance().cleanName(include);
        includes.put(include,snap);
    }
    
    public static void enterInclude()
    {
        alsoInclude.add(new ArrayList<String>());
    }

    public static void exitInclude()
    {
        alsoInclude.remove(alsoInclude.size()-1);
    }

    public static void alsoInclude(String name) 
    {
        name = LexerSource.getInstance().cleanName(name);
        for (int scan=0;scan<alsoInclude.size();scan++) {
            alsoInclude.get(scan).add(name);
        }
    }
    
    public static Iterable<String> getNestedIncludes()
    {
        return alsoInclude.get(alsoInclude.size()-1);
    }
}
