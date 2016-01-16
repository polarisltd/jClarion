package org.jclarion.clarion.compile.rewrite;

import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SystemCallExpr;

public class DisposeRewriter implements Rewriter
{
    private String name;
    
    public DisposeRewriter(String name)
    {
        this.name=name;
    }
    
    @Override
    public int getMax() {
        return 1;
    }

    @Override
    public int getMin() {
        return 1;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public ExprType getType() {
        return null;
    }

    @Override
    public RewrittenExpr rewrite(Expr[] in) 
    {
        if (in.length!=1) return null;
        Expr e=null;
        if (!in[0].type().isDestroyable()) {
            e=new SystemCallExpr(new DecoratedExpr(JavaPrec.POSTFIX,"//",in[0]));
            return new RewrittenExpr(e,RewrittenExpr.WEAK);
        } else {
            e = in[0].type().destroy(in[0]);
            return new RewrittenExpr(e,RewrittenExpr.ISA);
        }
    }

}
