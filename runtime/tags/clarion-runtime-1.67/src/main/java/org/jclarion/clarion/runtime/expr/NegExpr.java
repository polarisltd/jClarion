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
package org.jclarion.clarion.runtime.expr;

import java.util.Iterator;

import org.jclarion.clarion.ClarionObject;

public class NegExpr extends CExpr 
{
    private CExpr expr;
    
    public NegExpr(CExpr expr)
    {
        this.expr=expr;
    }

    @Override
    public ClarionObject eval() {
        return expr.eval().negate();
    }

    @Override
    public int precendence() {
        return 8;
    }
    
    @Override
    public Iterator<CExpr> directChildren() {
        return new OneIterator(expr);
    }

    @Override
    public boolean generateString(StringBuilder out, boolean strict) {
        
        int startPos = out.length();
        
        out.append('-');
        if (expr.precendence()<precendence()) out.append('(');
        if (!expr.generateString(out,strict)) {
            out.setLength(startPos);
            return false;
        }
        if (expr.precendence()<precendence()) out.append(')');
        return true;
    }

    @Override
    public void cast(CExprType type) {
        expr.cast(type);
    }

    @Override
    public CExprType getType() {
        return expr.getType();
    }

    @Override
    public boolean isRecastableType() {
        return expr.isRecastableType();
    }

}
