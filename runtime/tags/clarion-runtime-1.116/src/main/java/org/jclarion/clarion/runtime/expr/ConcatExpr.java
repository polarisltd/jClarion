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

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionObject;

public class ConcatExpr extends CExpr {
    
    public static CExpr construct(CExpr left,CExpr right) {
        if (!(left instanceof ConcatExpr)) {
            left=new ConcatExpr(left);
        }
        ((ConcatExpr)left).add(right);
        return left;
    }
    
    private CExpr left;
    private List<CExpr> right;
    
    public ConcatExpr(CExpr left)
    {
        this.left=left;
        right=new ArrayList<CExpr>();
    }
    
    public void add(CExpr right)
    {
        this.right.add(right);
    }

    @Override
    public ClarionObject eval(CExprScope scope) {
        
        ClarionObject result = left.eval(scope);
        
        for ( CExpr rhs : right ) {
            result=Clarion.newString(result.concat(rhs.eval(scope)));
        }
        
        return result;
    }

    @Override
    public int precendence() {
        return 4;
    }

    @Override
    public Iterator<CExpr> directChildren() {
        return new JoinIterator(left,right);
    }

    /**
     *  Strictly speaking - SQL yielded will not be equivalent to runtime
     *  evaluation = because of ClarionString insistance on being padded
     *  to its memory defined length. Oh - well - soldier on...
     */
    @Override
    public boolean generateString(CExprScope scope,StringBuilder out, boolean strict) {
        
        int startPos=out.length();
        
        CExpr curr=left;
        Iterator<CExpr> scan = right.iterator();
        
        while (curr!=null) {
            if (out.length()!=startPos) {
                out.append("||");
            }
            if (curr.precendence()<precendence()) out.append('(');
            
            if (!curr.generateString(scope,out,strict)) {
                out.setLength(startPos);
                return false;
            }

            if (curr.precendence()<precendence()) out.append(')');
            
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
        throw new RuntimeException("Cannot recast string!");
    }

    @Override
    public CExprType getType(CExprScope scope) {
        return CExprType.STRING;
    }

    @Override
    public boolean isRecastableType(CExprScope scope) {
        return false;
    }
    
}