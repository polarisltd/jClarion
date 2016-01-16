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
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.scope.ProcedureScope;

public class PassedVariable extends Variable {

    private ProcedureScope scope;
    private Param param;
    
    public PassedVariable(ProcedureScope pscope,Param p)
    {
        this.scope=pscope;
        this.param=p;
        init(this.param.getName(),p.getType(),false,false);
    }
    
    public ProcedureScope getScope()
    {
        return scope;
    }
    
    @Override
    public Expr[] makeConstructionExpr() {
        return null;
    }

    @Override
    public Variable clone() {
        return new PassedVariable(scope,param);
    }

}
