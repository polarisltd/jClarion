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

import java.util.List;


/**
 * Any of the statements may be processed - but only one will be
 * 
 * @author barney
 *
 */
public class ForkingJavaBlock extends JavaBlock
{
    @Override
    protected Cache rebuildCache(List<JavaCode> code) {
        Cache c = null; 
        
        for ( JavaCode e : code) {
            
            // first record - capture that setting
            if (c==null) {
                c=new Cache(null);                
                c.breakResult=workItOut(e,JavaControl.BREAK);
                c.continueResult=workItOut(e,JavaControl.CONTINUE);
                c.returnResult=workItOut(e,JavaControl.RETURN);
                c.endResult=workItOut(e,JavaControl.END);
                
                continue;
            }

            c.breakResult=merge(c.breakResult,workItOut(e,JavaControl.BREAK));
            c.continueResult=merge(c.continueResult,workItOut(e,JavaControl.CONTINUE));
            c.returnResult=merge(c.returnResult,workItOut(e,JavaControl.RETURN));
            c.endResult=merge(c.endResult,workItOut(e,JavaControl.END));
        }
        
        if (c==null) {
            c=new Cache(CacheResult.no);
        }
        return c;
    }

    private CacheResult merge(CacheResult l,CacheResult r)
    {
        if (l==CacheResult.yes && r==CacheResult.yes) return CacheResult.yes;
        if (l==CacheResult.no && r==CacheResult.no) return CacheResult.no;
        return CacheResult.maybe;
    }
    
    private CacheResult workItOut(JavaCode code,JavaControl control)
    {
        if (code.isCertain(control)) return CacheResult.yes;
        if (code.isPossible(control)) return CacheResult.maybe;
        return CacheResult.no;
    }

    @Override
    public void write(List<JavaCode> code, StringBuilder out, int indent,
            boolean unreachable) {
        
        for (JavaCode e : code ) {
            e.write(out,indent,unreachable);
        }
    }
}
