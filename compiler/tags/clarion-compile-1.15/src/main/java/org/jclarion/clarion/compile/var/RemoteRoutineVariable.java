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
import org.jclarion.clarion.compile.expr.JavaClassExprType;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;

public class RemoteRoutineVariable extends Variable {

    private Procedure p;
    
    public RemoteRoutineVariable(Procedure p)
    {
        super("_"+p.getName()+"_scope",new JavaClassExprType(p.getScope().getJavaClass()),false,false);
        this.p=p;
    }
    
    @Override
    public Variable clone() {
        return new RemoteRoutineVariable(p);
    }

    @Override
    public Expr[] makeConstructionExpr() {
        return null;
    }

    @Override
    public String getEscalatedJavaName(Scope useScope) {
        if (useScope==p.getImplementationScope()) return "this";
        return super.getEscalatedJavaName(useScope);
    }
    
    public Procedure getProcedure()
    {
        return p;
    }
}
