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
package org.jclarion.clarion.compile.java;

import java.util.Set;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.var.Variable;

public class ExprJavaCode extends ManipulableJavaCode 
{
    private Expr expr;

    public ExprJavaCode(Expr expr,JavaControl... control)
    {
        this.expr=expr;
    }
    
    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) {
        preWrite(out);
        writeIndent(out,indent,unreachable);
        expr.toJavaString(out);
        postWrite(out);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        expr.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return expr.utilises(vars);
    }

    public boolean utilisesReferenceVariables()
    {
        return expr.utilisesReferenceVariables();
    }
}
