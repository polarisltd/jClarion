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

public class PowExpr extends CExpr {

    private CExpr left;
    private CExpr right;
    
    public PowExpr(CExpr left,CExpr right)
    {
        this.left=left;
        this.right=right;
    }

    @Override
    public ClarionObject eval(CExprScope scope) {
        return left.eval(scope).power(right.eval(scope));
    }

    @Override
    public int precendence() {
        return 7;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return new TwoIterator(left,right);
    }

    @Override
    public boolean generateString(CExprScope scope,StringBuilder out, boolean strict) {
        return false;
    }

    @Override
    public void cast(CExprScope scope,CExprType type) {
        // don't bother since POW is not SQLABLE
    }

    @Override
    public CExprType getType(CExprScope scope) {
        return null;
    }

    @Override
    public boolean isRecastableType(CExprScope scope) {
        return false;
    }
    
}
