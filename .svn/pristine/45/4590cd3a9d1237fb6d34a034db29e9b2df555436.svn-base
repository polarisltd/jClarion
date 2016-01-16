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

import org.jclarion.clarion.compile.scope.MainScope;
import org.jclarion.clarion.compile.var.Variable;

public class MainVariableInitCode extends JavaCode
{
    private Iterable<Variable> variables;
    
    public MainVariableInitCode(Iterable<Variable> variables)
    {
        this.variables=variables;
    }

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) 
    {
        for ( Variable v : variables ) {
            writeIndent(out,indent,false);
            if (v.getScope()!=MainScope.main) {
                out.append(v.getScope().getJavaClass().getName());
                out.append('.');
            }
            out.append(v.getJavaName());
            out.append("=");
            v.generateConstruction(out);
            out.append(";\n");
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        for ( Variable v : variables ) {
            if (v.getScope()!=MainScope.main) {
                v.getScope().getJavaClass().collate(collector);
            }
            v.getConstructionDependency().collate(collector);
        }
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        for ( Variable v : variables ) {
            if (vars.contains(v)) return true;
        }
        return false;
    }

    @Override
    public boolean utilisesReferenceVariables() {
        for ( Variable v : variables ) {
            if (v.utilisesReferenceVariables()) return true;
        }
        return false;
    }
}
