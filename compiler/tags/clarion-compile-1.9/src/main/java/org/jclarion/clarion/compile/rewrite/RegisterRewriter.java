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
package org.jclarion.clarion.compile.rewrite;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.RegexExpr;
import org.jclarion.clarion.compile.expr.SystemCallExpr;

public class RegisterRewriter implements Rewriter
{
    private String name;
    private String function;
    
    public RegisterRewriter(String name,String function)
    {
        this.name=name;
        this.function=function;
    }

    @Override
    public int getMax() {
        return 3;
    }

    @Override
    public int getMin() {
        return 3;
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
    public RewrittenExpr rewrite(Expr[] in) {

        if (in.length!=3) return null;
        
        ExprBuffer eb = new ExprBuffer(JavaPrec.LABEL,null);
        eb.add("CWin.");
        eb.add(function);
        eb.add("(");
        eb.add(ExprType.rawint.cast(in[0]));
        eb.add(",new Runnable() { public void run() {");
        
        eb.add( (new RegexExpr(in[1]))
            .add("CMemory\\.address\\((.*?)\\)","$1",false)
            .add("^this.","",false)
        );
        
        eb.add("; } },");
        eb.add(ExprType.rawint.cast(in[2]));
        eb.add(")");

        Expr e = new DependentExpr(eb,ClarionCompiler.CLARION+".runtime.CWin");
        e=new SystemCallExpr(e);
        return new RewrittenExpr(e,RewrittenExpr.EXACT);
    }

}
