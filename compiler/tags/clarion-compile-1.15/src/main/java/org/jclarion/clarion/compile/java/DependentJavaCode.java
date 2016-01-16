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

public class DependentJavaCode extends JavaCode
{
    private JavaCode base;
    private JavaDependency dep;
    
    public DependentJavaCode(JavaCode base,JavaDependency dep)
    {
        this.base=base;
        this.dep=dep;
    }

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) {
        base.write(out,indent,unreachable);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        base.collate(collector);
        this.dep.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return base.utilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() {
        return base.utilisesReferenceVariables();
    }

}
