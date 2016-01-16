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

public class BoolExpr extends CExpr {

    public static CExpr construct(CExpr left,String op,CExpr right) {
        
        if (!(left instanceof BoolExpr)) 
        {
            left=new BoolExpr(left);
        }
        ((BoolExpr)left).add(op,right);
        return left;
    }
    
    private enum Op { AND, OR };
    
    private static class BoolOp extends CExpr.GenericOp
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
    
    public BoolExpr(CExpr base)
    {
        this.base=base;
        this.ops=new ArrayList<BoolOp>();
    }
    
    public void add(String op,CExpr right) {
        if (op.equalsIgnoreCase("and")) ops.add(new BoolOp(Op.AND,right));
        if (op.equalsIgnoreCase("or")) ops.add(new BoolOp(Op.OR,right));
    }

    @Override
    public ClarionObject eval() {
        
        ClarionObject result = base.eval();
        
        for ( BoolOp op : ops ) {

            if (op.op==Op.AND) {
                if (!result.boolValue()) break;
                result=op.right.eval();
            }

            if (op.op==Op.OR) {
                if (result.boolValue()) continue;
                result=op.right.eval();
            }
        }
        
        return result.getBool();
    }

    @Override
    public int precendence() {
        return 1;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return JoinIterator.generic(base,ops);
    }

    /**
     * In strict mode - we are not allowed to generate SQL
     * if either side of an OR expression is not strict too.
     * but everything else is ok.
     * 
     * ie following scenarios are ok
     * 
     * S1 AND C2 AND S3
     *   * S1 AND S3
     *   
     * S1 OR C2 AND S3
     *   * S3

     * C1 OR S2 AND S3
     *   * S3

     * C1 OR S2 AND S3 OR C4
     *   * <none>
     * 
     */
    public boolean generateString(StringBuilder out, boolean strict) {

        int startPos=out.length();
        boolean ignoreIfOr=false;
        
        // last good position we need to rollback to if we encounter
        // a non SQL eith side of an OR statement
        int lastPos=out.length();
        
        Iterator<BoolOp> scan = ops.iterator();
        BoolOp curr = new BoolOp(Op.AND,base);
        
        while (curr!=null) {
            
            if (curr.op==Op.AND) {
                // advance last good position (commit it)
                lastPos=out.length();
                ignoreIfOr=false;
            } 
            
            if (curr.op==Op.OR) {
                if (ignoreIfOr) {
                    if (scan.hasNext()) {
                        curr=scan.next();
                    } else {
                        curr=null;
                    }
                    continue;
                }
            }
            
            if (out.length()!=startPos) {
                if (curr.op==Op.AND) {
                    out.append(" AND ");
                }
                if (curr.op==Op.OR) {
                    out.append(" OR ");
                }
            }
            
            if (curr.right.precendence()<=precendence()) {
                out.append('(');
            }
            
            if (!curr.right.generateString(out,strict)) {
                // roll back to last known good position
                out.setLength(lastPos);
                ignoreIfOr=true;
            } else {
                if (curr.right.precendence()<=precendence()) {
                    out.append(')');
                }
            }
            
            if (scan.hasNext()) {
                curr=scan.next();
            } else {
                curr=null;
            }
        }

        return (startPos!=out.length());
   }

    @Override
    public void cast(CExprType type) 
    {
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