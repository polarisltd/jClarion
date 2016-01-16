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
package org.jclarion.clarion.compile.var;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ExprTypeExpr;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;

public class ReferenceVariable extends Variable 
{
    private Expr dim[];
    private ExprType baseRef;
    private boolean  thread;
    
    public ReferenceVariable(String name,ExprType baseRef,boolean Static,Expr dim[])
    {
        this.baseRef=baseRef;
        if (dim!=null && dim.length>0) {
            init(name,baseRef.changeArrayIndexCount(dim.length),true,Static);
        } else {
            init(name,baseRef,true,Static);
        }
        this.dim=dim;
    }
    
    public void setThread()
    {
        thread=true;
        escalateReference();
    }
    
    protected boolean isThread()
    {
        return thread;
    }
    
    
    @Override
    public Expr[] makeConstructionExpr() 
    {
        if (dim==null || dim.length==0) {
            return new Expr[] { new SimpleExpr(JavaPrec.LABEL,getType(),"null")};
        } else {
            ExprBuffer eb = new ExprBuffer(JavaPrec.CREATE,getType());
            if (dim.length>1) eb.add("(");
            eb.add("new ClarionArray<");
            eb.add(new ExprTypeExpr(baseRef));
            eb.add(">(");
            eb.add(ExprType.rawint.cast(dim[dim.length-1]));
            eb.add(")");
            if (dim.length>1) eb.add(")");
            for (int scan=dim.length-2;scan>=0;scan--) {
                eb.add(".dim(");
                eb.add(ExprType.rawint.cast(dim[scan]));
                eb.add(")");
            }
            return new Expr[] { eb };
        }
    }

    @Override
    public Variable clone() {
        return new ReferenceVariable(getName(),baseRef,isStatic(),dim);
    }

}
