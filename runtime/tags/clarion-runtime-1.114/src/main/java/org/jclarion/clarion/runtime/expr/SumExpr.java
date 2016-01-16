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

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jclarion.clarion.ClarionObject;

public class SumExpr extends CExpr {

    public static CExpr construct(CExpr left,String op,CExpr right) {
        
        if (!(left instanceof SumExpr)) 
        {
            left=new SumExpr(left);
        }
        ((SumExpr)left).add(op,right);
        return left;
    }
    
    private enum Op { PLUS, MINUS, NONE };
    
    private static class BoolOp extends GenericOp
    {
        public Op op;
        
        public BoolOp(Op op,CExpr right)
        {
            this.op=op;
            this.right=right;
        }
    }
    
    private CExpr           base;
    private List<BoolOp>    ops;
    
    public SumExpr(CExpr base)
    {
        this.base=base;
        this.ops=new ArrayList<BoolOp>();
    }
    
    public void add(String op,CExpr right) {
        if (op.equalsIgnoreCase("+")) ops.add(new BoolOp(Op.PLUS,right));
        if (op.equalsIgnoreCase("-")) ops.add(new BoolOp(Op.MINUS,right));
    }

    @Override
    public ClarionObject eval(CExprScope scope) {
        
        ClarionObject result = base.eval(scope);
        
        for ( BoolOp op : ops ) {

            if (op.op==Op.PLUS) {
                result=result.add(op.right.eval(scope));
            }

            if (op.op==Op.MINUS) {
                result=result.subtract(op.right.eval(scope));
            }
        }
        
        return result;
    }

    @Override
    public int precendence() {
        return 5;
    }
    
    @Override
    public Iterator<CExpr> directChildren() {
        return JoinIterator.generic(base,ops);
    }

    @Override
    public boolean generateString(CExprScope scope,StringBuilder out, boolean strict) {
        
        int startPos=out.length();
        
        BoolOp curr=new BoolOp(Op.NONE,base);
        Iterator<BoolOp> scan = ops.iterator();
 
        while (curr!=null) {
            
            if (curr.op==Op.PLUS) out.append('+');
            if (curr.op==Op.MINUS) out.append('-');
            
            if (curr.right.precendence()<precendence()) out.append('(');
            if (!curr.right.generateString(scope,out,strict)) {
                out.setLength(startPos);
                return false;
            }
            if (curr.right.precendence()<precendence()) out.append(')');
            
            if (scan.hasNext()) {
                curr=scan.next();
            } else {
                break;
            }
        }
        
        return true;
    }
 
    @Override
    public void cast(CExprScope scope,CExprType type) {
        cast(scope,new OpIterable(ops),type);
    }

    @Override
    public CExprType getType(CExprScope scope) {
        return resolveCasts(scope,new OpIterable(ops));
    }

    @Override
    public boolean isRecastableType(CExprScope scope) {
        return isRecastableType(scope,new OpIterable(ops));
    }    
}