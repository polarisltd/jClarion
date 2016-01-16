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

public class NotExpr extends CExpr 
{
    private CExpr expr;
    
    public NotExpr(CExpr expr)
    {
        this.expr=expr;
    }

    @Override
    public ClarionObject eval() {
        return expr.eval().getBool().negate();
    }

    @Override
    public int precendence() {
        return 2;
    }
    
    @Override
    public Iterator<CExpr> directChildren() {
        return new OneIterator(expr);
    }

    @Override
    public boolean generateString(StringBuilder out, boolean strict) {
        
        int startPos = out.length();
        
        out.append(" NOT ");
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
        throw new RuntimeException("Cannot recast boolean!");
    }

    @Override
    public CExprType getType() {
        return CExprType.BOOL;
    }

    @Override
    public boolean isRecastableType() {
        return false;
    }
    
}
