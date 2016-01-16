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

public class WrapExpr extends Expr
{
    private Expr in;

    public WrapExpr(Expr in) {
        super(JavaPrec.POSTFIX,in.type());
        this.in=in;
    }
    
    @Override
    public void toJavaString(StringBuilder target) {
        target.append('(');
        in.toJavaString(target);
        target.append(')');
    }

    @Override
    public void collate(JavaDependencyCollector collector) 
    {
        in.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return in.utilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() {
        return in.utilisesReferenceVariables();
    }
    
    
}
