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

import org.jclarion.clarion.compile.var.Variable;


public class SimpleJavaCode extends ManipulableJavaCode 
{
    private String expr;
    private JavaDependency dependency;

    public SimpleJavaCode(String expr,String... dep)
    {
        this(expr,new SimpleCollector(dep));
    }

    public SimpleJavaCode(String expr,JavaDependency dep)
    {
        this.expr=expr;
        this.dependency=dep;
    }

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) {
        preWrite(out);
        writeIndent(out,indent,unreachable);
        out.append(expr);
        postWrite(out);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        if (dependency!=null) {
            dependency.collate(collector);
        }
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
