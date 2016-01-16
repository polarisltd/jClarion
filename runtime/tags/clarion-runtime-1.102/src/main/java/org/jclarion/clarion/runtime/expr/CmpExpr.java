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
    public ClarionObject eval() {
        
        if (op==Op.SAME) {
            return new ClarionBool(left.eval()==right.eval());
        }

        int cmp = left.eval().compareTo(right.eval());
        
        boolean result=false;
        
        if (cmp<0) {
            if (op==Op.LT || op==Op.LE || op==Op.NE) result=true;
        }
        if (cmp>0) {
            if (op==Op.GT || op==Op.GE || op==Op.NE) result=true;
        }
        if (cmp==0) {
            if (op==Op.GE || op==Op.LE || op==Op.EQ) result=true;
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
    public boolean generateString(StringBuilder out, boolean strict) {
     
        if (strict) {
            if (left.getType()!=right.getType()) {
                if (left.isRecastableType()) {
                    left.cast(right.getType());
                } else {
                    right.cast(left.getType());
                }
            }
        }
        
        int startPos=out.length();
        
        if (left.precendence()<=precendence()) out.append('(');
        if (!left.generateString(out,strict)) {
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
        if (!right.generateString(out,strict)) {
            out.setLength(startPos);
            return false;
        }
        if (right.precendence()<=precendence()) out.append(')');
        
        return true;
    }

    @Override
    public void cast(CExprType type) {
        throw new RuntimeException("Cannot recast cmp!");
    }

    @Override
    public CExprType getType() {
        return CExprType.BOOL;
    }

    @Override
    public boolean isRecastableType() {
        if (left.isRecastableType()) return true;
        if (right.isRecastableType()) return true;
        return false;
    }
}
