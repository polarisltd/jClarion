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

public class SimpleExpr extends Expr
{
    private String value;
    
    public SimpleExpr(int precedence, ExprType output,String value) 
    {
        super(precedence, output);
        this.value=value;
    }

    @Override
    public void toJavaString(StringBuilder target) {
        target.append(value);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        // simple expressions do not have dependencies
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
