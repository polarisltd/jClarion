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
package org.jclarion.clarion.compile.rewrite;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.compile.expr.Expr;

public class RewriteFactory 
{
    private Map<String,List<Rewriter>> rewriters=new HashMap<String, List<Rewriter>>();
    
    public RewriteFactory(Rewriter... w)
    {
        add(w);
    }
    
    public RewriteFactory add(Rewriter... w)
    {
        for (int scan=0;scan<w.length;scan++) {
            Rewriter i = w[scan];
            List<Rewriter> list = rewriters.get(i.getName().toLowerCase());
            if (list==null) {
                list=new ArrayList<Rewriter>();
                rewriters.put(i.getName().toLowerCase(),list);
            }
            list.add(i);
        }
        
        return this;
    }

    public Iterable<Rewriter> get(String name)
    {
        return rewriters.get(name.toLowerCase());
    }
    
    public Expr rewrite(String name,Expr[] in) {
        
        List<Rewriter> list = rewriters.get(name.toLowerCase());
        if (list==null) return null;
        
        RewrittenExpr winner=null;
        for ( Rewriter test : list ) {
            RewrittenExpr contestant=test.rewrite(in);
            if (contestant==null) continue;
            if (contestant.getMatchScore()==RewrittenExpr.EXACT) return contestant.getExpr();
            if (winner==null) {
                winner=contestant;
            } else {
                if (contestant.getMatchScore()<winner.getMatchScore()) {
                    winner=contestant;
                }
            }
        }
        if (winner==null) return null;
        return winner.getExpr();
    }
}
