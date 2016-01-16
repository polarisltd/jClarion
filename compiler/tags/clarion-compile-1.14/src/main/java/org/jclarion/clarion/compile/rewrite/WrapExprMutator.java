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

public class WrapExprMutator implements ExprMutator {

    private int prec;
    
    public WrapExprMutator(int prec)
    {
        this.prec=prec;
    }
    
    @Override
    public Expr mutate(Expr in) {
        return in.wrap(prec);
    }

    @Override
    public int getMatchScore(Expr in) {
        return 0;
    }

}
