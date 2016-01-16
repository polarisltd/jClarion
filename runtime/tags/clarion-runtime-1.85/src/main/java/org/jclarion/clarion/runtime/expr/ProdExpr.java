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

public class ProdExpr extends CExpr {

    public static CExpr construct(CExpr left,String op,CExpr right) {
        
        if (!(left instanceof ProdExpr)) 
        {
            left=new ProdExpr(left);
        }
        ((ProdExpr)left).add(op,right);
        return left;
    }
    
    private enum Op { MUL, DIV, MOD, NONE };
    
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
    
    public ProdExpr(CExpr base)
    {
        this.base=base;
        this.ops=new ArrayList<BoolOp>();
    }
    
    public void add(String op,CExpr right) {
        if (op.equalsIgnoreCase("*")) ops.add(new BoolOp(Op.MUL,right));
        if (op.equalsIgnoreCase("/")) ops.add(new BoolOp(Op.DIV,right));
        if (op.equalsIgnoreCase("%")) ops.add(new BoolOp(Op.MOD,right));
    }

    @Override
    public ClarionObject eval() {
        
        ClarionObject result = base.eval();
        
        for ( BoolOp op : ops ) {

            if (op.op==Op.MUL) {
                result=result.multiply(op.right.eval());
            }
            if (op.op==Op.DIV) {
                result=result.divide(op.right.eval());
            }
            if (op.op==Op.MOD) {
                result=result.modulus(op.right.eval());
            }
        }
        
        return result;
    }

    @Override
    public int precendence() {
        return 6;
    }
    
    @Override
    public Iterator<CExpr> directChildren() {
        return JoinIterator.generic(base,ops);
    }
 
    @Override
    public boolean generateString(StringBuilder out, boolean strict) {
        
        int startPos=out.length();
        
        BoolOp curr=new BoolOp(Op.NONE,base);
        Iterator<BoolOp> scan = ops.iterator();
 
        while (curr!=null) {
            
            if (curr.op==Op.DIV) out.append('/');
            if (curr.op==Op.MUL) out.append('*');
            if (curr.op==Op.MOD) {
                if (strict) {
                    out.setLength(startPos);
                    return false;
                }
                out.append('%');
            }
            
            if (curr.right.precendence()<=precendence()) out.append('(');
            if (!curr.right.generateString(out,strict)) {
                out.setLength(startPos);
                return false;
            }
            if (curr.right.precendence()<=precendence()) out.append(')');
            
            if (scan.hasNext()) {
                curr=scan.next();
            } else {
                break;
            }
        }
        
        return true;
    }

    @Override
    public void cast(CExprType type) {
        cast(new OpIterable(ops),type);
    }

    @Override
    public CExprType getType() {
        return resolveCasts(new OpIterable(ops));
    }

    @Override
    public boolean isRecastableType() {
        return isRecastableType(new OpIterable(ops));
    }
     
}