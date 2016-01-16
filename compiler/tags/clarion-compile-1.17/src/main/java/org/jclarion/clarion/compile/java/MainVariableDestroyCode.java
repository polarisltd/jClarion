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

public class MainVariableDestroyCode extends JavaCode
{
    private Iterable<Variable> variables;
    
    public MainVariableDestroyCode(Iterable<Variable> variables)
    {
        this.variables=variables;
    }

    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) 
    {
        for ( Variable v : variables ) {
            
            if (v.isReference()) continue;
            if (!v.getType().isDestroyable()) continue;
            
            writeIndent(out,indent,false);
            v.getType().destroy(v.getExpr(MainScope.main)).toJavaString(out);
            out.append(";\n");
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
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
