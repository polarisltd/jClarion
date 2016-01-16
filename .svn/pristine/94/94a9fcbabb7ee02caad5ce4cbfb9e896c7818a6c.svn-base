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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.scope.ScopeSnapshot;

public class LocalIncludeCache {

    private Map<String,ScopeSnapshot> includes=new HashMap<String, ScopeSnapshot>();
    private List<Map<String,LocalIncludeCache>>       alsoInclude=new ArrayList<Map<String,LocalIncludeCache>>();
    
    
    
	public ScopeSnapshot getIncludeSnapshot(LexerSource source,String include)
    {
        include = source.cleanName(include);
        return includes.get(include);
    }
    
    public void setIncludeSnapshot(LexerSource source,String include,ScopeSnapshot snap)
    {
        include = source.cleanName(include);
        includes.put(include,snap);
    }
    
    public void enterInclude()
    {
        alsoInclude.add(new LinkedHashMap<String,LocalIncludeCache>());
    }

    public void exitInclude()
    {
        alsoInclude.remove(alsoInclude.size()-1);
    }

    public void alsoInclude(ClarionCompiler compiler,String name) 
    {
        name = compiler.source().cleanName(name);
        compiler.collator().associate(name,compiler.getScope());
        LocalIncludeCache r = compiler.getLocalIncludeCache(name);
        for (int scan=0;scan<alsoInclude.size();scan++) {
            alsoInclude.get(scan).put(name,r);
        }
    }
    
    public Map<String,LocalIncludeCache> getNestedIncludes()
    {
        return alsoInclude.get(alsoInclude.size()-1);
    }
}
