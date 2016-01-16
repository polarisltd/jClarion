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
package org.jclarion.clarion.compile.expr;

import java.util.Set;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;

public class PrototypeExpr extends Expr
{
    public PrototypeExpr(Procedure p) {
        this(new ProcedurePrototypeExprType(p));
    }

    public PrototypeExpr(Variable v) {
        this(new VariablePrototypeExprType(v));
    }
    
    public PrototypeExpr(ExprType output) {
        super(0,output);
    }

    @Override
    public void toJavaString(StringBuilder target) {
        throw new IllegalStateException("cannot be done");
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        collector.setPrototype();
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return false;
    }

    @Override
    public boolean utilisesReferenceVariables() {
        return false;
    }
    
    
}
