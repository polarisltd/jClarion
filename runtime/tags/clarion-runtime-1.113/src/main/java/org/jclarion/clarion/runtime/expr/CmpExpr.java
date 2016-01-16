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

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionObject;

public class CmpExpr extends CExpr {

    private enum Op { NE, LE, GE, LT, GT, EQ, SAME }; 

    private CExpr left;
    private CExpr right;
    private Op op;
    
    public CmpExpr(CExpr left,String op,CExpr right)
    {
        this.left=left;
        this.right=right;
        if (op.equals("<>")) this.op=Op.NE;
        if (op.equals("<")) this.op=Op.LT;
        if (op.equals(">")) this.op=Op.GT;
        if (op.equals("<=")) this.op=Op.LE;
        if (op.equals(">=")) this.op=Op.GE;
        if (op.equals("=")) this.op=Op.EQ;
        if (op.equals("&=")) this.op=Op.SAME;
    }

    @Override
    public ClarionObject eval(CExprScope scope) {
        
        if (op==Op.SAME) {
            return new ClarionBool(left.eval(scope)==right.eval(scope));
        }

        boolean result=false;
        if (op==Op.EQ) {
        	result=left.eval(scope).equals(right.eval(scope));
        } if (op==Op.NE) {
        	result=!left.eval(scope).equals(right.eval(scope));
        } else {
        	int cmp = left.eval(scope).compareTo(right.eval(scope));	
            if (cmp<0 && (op==Op.LT || op==Op.LE)) result=true;
            if (cmp>0 && (op==Op.GT || op==Op.GE)) result=true;
            if (cmp==0 && (op==Op.GE || op==Op.LE)) result=true;
        }
                		        
        return new ClarionBool(result);
    }

    @Override
    public int precendence() {
        return 3;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return new TwoIterator(left,right);
    }

    @Override
    public boolean generateString(CExprScope scope,StringBuilder out, boolean strict) {
     
        if (strict) {
            if (left.getType(scope)!=right.getType(scope)) {
                if (left.isRecastableType(scope)) {
                    left.cast(scope,right.getType(scope));
                } else {
                    right.cast(scope,left.getType(scope));
                }
            }
        }
        
        int startPos=out.length();
        
        if (left.precendence()<=precendence()) out.append('(');
        if (!left.generateString(scope,out,strict)) {
            out.setLength(startPos);
            return false;
        }
        if (left.precendence()<=precendence()) out.append(')');

        if (op==Op.EQ) out.append('=');
        if (op==Op.LT) out.append('<');
        if (op==Op.GT) out.append('>');
        if (op==Op.LE) out.append("<=");
        if (op==Op.GE) out.append(">=");
        if (op==Op.NE) out.append("<>");
        if (op==Op.SAME) {
            if (strict) {
                out.setLength(startPos);
                return false;
            }
            out.append("&=");
        }

        if (right.precendence()<=precendence()) out.append('(');
        if (!right.generateString(scope,out,strict)) {
            out.setLength(startPos);
            return false;
        }
        if (right.precendence()<=precendence()) out.append(')');
        
        return true;
    }

    @Override
    public void cast(CExprScope scope,CExprType type) {
        throw new RuntimeException("Cannot recast cmp!");
    }

    @Override
    public CExprType getType(CExprScope scope) {
        return CExprType.BOOL;
    }

    @Override
    public boolean isRecastableType(CExprScope scope) {
        if (left.isRecastableType(scope)) return true;
        if (right.isRecastableType(scope)) return true;
        return false;
    }
}
