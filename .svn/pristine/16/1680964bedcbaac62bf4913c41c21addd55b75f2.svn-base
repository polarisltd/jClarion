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
 * All statements are processed in linear order
 * 
 * @author barney
 *
 */
public class LinearJavaBlock extends JavaBlock
{
    /**
     * 
     * @param loop
     */
    public LinearJavaBlock()
    {
    }
    
    
    @Override
    protected Cache rebuildCache(List<JavaCode> code) {
        Cache c = new Cache(CacheResult.no);

        for ( JavaCode e : code) {
            
            boolean finish=false;

            // breaks
            if (e.isCertain(JavaControl.BREAK)) {
                c.breakResult=CacheResult.yes;
                finish=true;
            }
            if (e.isPossible(JavaControl.BREAK)) {
                if (c.breakResult==CacheResult.no) {
                    c.breakResult=CacheResult.maybe;
                }
            }

            // continue
            if (e.isCertain(JavaControl.CONTINUE)) {
                c.continueResult=CacheResult.yes;
                finish=true;
            }
            if (e.isPossible(JavaControl.CONTINUE)) {
                if (c.continueResult==CacheResult.no) {
                    c.continueResult=CacheResult.maybe;
                }
            }
            
            // return
            if (e.isCertain(JavaControl.RETURN)) {
                c.returnResult=CacheResult.yes;
                finish=true;
            }
            if (e.isPossible(JavaControl.RETURN)) {
                if (c.returnResult==CacheResult.no) {
                    c.returnResult=CacheResult.maybe;
                }
            }
            
            // end
            if (e.isCertain(JavaControl.END)) {
                finish=true;
                c.endResult=CacheResult.yes;
            }
            
            if (finish) break;
        }
        
        return c;
    }

    @Override
    public void write(List<JavaCode> code, StringBuilder out, int indent,
            boolean unreachable) {
        
        for (JavaCode e : code ) {
            e.write(out,indent,unreachable);
            
            if (unreachable==false && e.isCertain(JavaControl.END)) {
                unreachable=true;
            }
        }
    }
}
