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

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;

public class CastExprMutator implements ExprMutator 
{
    private ExprType[] type;
    
    public CastExprMutator(ExprType... type) 
    {
        this.type=type;
    }
    
    @Override
    public Expr mutate(Expr in) {
        for (int scan=0;scan<type.length;scan++) {
            if (in.type().isa(type[scan])) {
                return in;
            }
        }
        
        Expr out = type[0].cast(in);
        return out;
    }

    @Override
    public int getMatchScore(Expr in) {
        
        if (in.type()==null) return RewrittenExpr.EXACT;
        
        for (int scan=0;scan<type.length;scan++) {
            if (in.type().same(type[scan])) return RewrittenExpr.EXACT;
        }
        for (int scan=0;scan<type.length;scan++) {
            if (in.type().isa(type[scan])) return RewrittenExpr.ISA;
        }

        // possibly castable
        return RewrittenExpr.CASTABLE;
    }
}
