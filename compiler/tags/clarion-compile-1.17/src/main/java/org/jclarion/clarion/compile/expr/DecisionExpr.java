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
import org.jclarion.clarion.compile.var.Variable;

public abstract class DecisionExpr extends Expr
{
    public DecisionExpr(int precedence, ExprType output) {
        super(precedence, output);
    }

    @Override
    public void toJavaString(StringBuilder target) {
        get().toJavaString(target);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        get().collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return get().utilises(vars);
    }
    
    public abstract Expr get();
}
