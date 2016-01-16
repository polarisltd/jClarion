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

import java.util.Set;

import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.scope.Scope;

public class UseVariable extends Variable {

    private UseVar var;
    private TargetConstruct source;
    
    public UseVariable(TargetConstruct source,UseVar var)
    {
        this.source=source;
        this.var=var;
        init(var.getName(),ExprType.rawint,false,false);
    }
    
    @Override
    public Expr[] makeConstructionExpr() {
        return new Expr[] { new SimpleExpr(JavaPrec.LABEL,ExprType.rawint,"0") };
    }

    public UseVar getUseVar()
    {
        return var;
    }

    @Override
    public VariableExpr getExpr(Scope callingScope) {
        
        Expr e = source.getVariable().getExpr(callingScope);
        e=new DecoratedExpr(JavaPrec.POSTFIX,ExprType.rawint,null,e,"."+getJavaName());
        return new VariableExpr(e,this);
    }

    @Override
    public Variable clone() {
        return new UseVariable(source,var);
    }

    @Override
    public String getJavaName() {
        return "_"+super.getJavaName();
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (this.var.getVariable().utilises(vars)) return true;
        if (this.var.getID().utilises(vars)) return true;
        return super.utilises(vars);
    }
    
    
    
}
