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

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionObject;

public class BoolExpr extends CExpr {

    public static CExpr construct(CExpr left,String op,CExpr right) {
        
    	BoolExpr be = null;    	
        if (left instanceof BoolExpr)  {   
        	be=(BoolExpr)left;
        }
        Op xop=getOp(op);
                
        if (be!=null && be.op!=xop) be=null;

        if (be==null) {
            be=new BoolExpr(left,xop);
        }
        be.add(right);
        return be;
    }
    
    private enum Op { AND, OR };
    
    private Op 				op;
    private List<CExpr>    	ops;
    
    private static Op getOp(String op)
    {
        if (op.equalsIgnoreCase("and")) {
        	return Op.AND;
        }
        if (op.equalsIgnoreCase("or")) {
        	return Op.OR;
        }    	
        return null;
    }
    
    public BoolExpr(CExpr base,Op op)
    {
        this.op=op;
        this.ops=new ArrayList<CExpr>();
        ops.add(base);
    }
    
    public void add(CExpr right) {
        ops.add(right);
    }

    @Override
    public ClarionObject eval(CExprScope scope) 
    {
        boolean result=op==Op.AND ? true : false;        		
        for ( CExpr right : ops ) {
            if (this.op==Op.AND) {
                if (!right.eval(scope).boolValue()) {
                	result=false;
                	break;
                }
            }

            if (this.op==Op.OR) {
                if (right.eval(scope).boolValue()) {
                	result=true;
                	break;
                }
            }
        }        
        return new ClarionBool(result);
    }

    @Override
    public int precendence() {
        return this.op==Op.OR ? 0 : 1;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return ops.iterator();
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
    public boolean generateString(CExprScope scope,StringBuilder out, boolean strict) {

        int startPos=out.length();        
        int lastPos=out.length();
        
        for (CExpr curr : ops) {
        	lastPos=out.length();
            if (out.length()!=startPos) {
                if (op==Op.AND) {
                    out.append(" AND ");
                }
                if (op==Op.OR) {
                    out.append(" OR ");
                }
            }
            
            
            if (curr.precendence()<=precendence()) {
                out.append('(');
            }
            
            if (!curr.generateString(scope,out,strict)) {
            	if (op==Op.AND) {
            		out.setLength(startPos);
            		break;
            	}
                out.setLength(lastPos);
            } else {
                if (curr.precendence()<=precendence()) {
                    out.append(')');
                }
            }
        }

        return (startPos!=out.length());
   }

    @Override
    public void cast(CExprScope scope,CExprType type) 
    {
        throw new RuntimeException("Cannot recast boolean!");
    }

    @Override
    public CExprType getType(CExprScope scope) {
        return CExprType.BOOL;
    }

    @Override
    public boolean isRecastableType(CExprScope scope) {
        return false;
    }
}