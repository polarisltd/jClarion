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

import org.jclarion.clarion.compile.var.Variable;

public abstract class JavaBlock extends JavaCode 
{
    private List<JavaCode>  code=new ArrayList<JavaCode>();

    public static enum CacheResult { yes, no ,maybe };
    
    public static class Cache
    {
        public CacheResult breakResult;
        public CacheResult continueResult;
        public CacheResult returnResult;
        public CacheResult endResult;
        
        public Cache(CacheResult init)
        {
            breakResult=init;
            continueResult=init;
            returnResult=init;
            endResult=init;
        }
    }

    private Cache cache;
    
    public void add(JavaCode... code)
    {
        cache=null;
        for (int scan=0;scan<code.length;scan++) {
            this.code.add(code[scan]);
        }
    }
    
    @Override
    public void collate(JavaDependencyCollector collector) {
        for ( JavaCode element : code ) {
            element.collate(collector);
        }
    }


    @Override
    public boolean utilises(Set<Variable> vars) {
        for ( JavaCode element : code ) {
            if (element.utilises(vars)) return true;
        }
        return false;
    }

    public boolean utilisesReferenceVariables()
    {
        for ( JavaCode element : code ) {
            if (element.utilisesReferenceVariables()) return true;
        }
        return false;
    }
    
    private CacheResult getResult(JavaControl control)
    {
        if (cache==null) {
            cache=rebuildCache(code);
        }
        
        if (control==JavaControl.BREAK) return cache.breakResult;
        if (control==JavaControl.CONTINUE) return cache.continueResult;
        if (control==JavaControl.RETURN) return cache.returnResult;
        if (control==JavaControl.END) return cache.endResult;
        
        return null;
    }
    
    @Override
    public boolean isCertain(JavaControl control) {
        CacheResult cr = getResult(control);
        if (cr==CacheResult.yes) return true;
        return false;
    }

    @Override
    public boolean isPossible(JavaControl control) {
        CacheResult cr = getResult(control);
        if (cr==CacheResult.yes) return true;
        if (cr==CacheResult.maybe) return true;
        return false;
    }

    protected abstract Cache rebuildCache(List<JavaCode> code);

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) {
        write(code,out,indent,unreachable);
    }
    
    public abstract void write(List<JavaCode> code,StringBuilder out, int indent, boolean unreachable);
    
    
}
