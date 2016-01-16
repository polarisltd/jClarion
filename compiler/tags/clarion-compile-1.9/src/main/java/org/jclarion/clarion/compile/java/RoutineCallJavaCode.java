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

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.var.Variable;

public class RoutineCallJavaCode extends JavaCode {
    
    private RoutineScope routine;
    private boolean      inProcedure;
    private String prefix;

    public RoutineCallJavaCode(RoutineScope routine,boolean inProcedure)
    {
        this(null,routine,inProcedure);
    }

    public RoutineCallJavaCode(String prefix,RoutineScope routine,boolean inProcedure)
    {
        this.routine=routine;
        this.inProcedure=inProcedure;
        this.prefix=prefix;
    }
    
    @Override
    public void write(StringBuilder out, int indent, boolean unreachable) {
        
        boolean mayThrow = routine.mayReturnToProcedure() && inProcedure;
        
        if (mayThrow) {
            writeIndent(out,indent,unreachable);
            out.append("try {\n");
        }
        
        writeIndent(out,mayThrow?indent+1:indent,unreachable);
        if (prefix!=null) out.append(prefix);
        out.append(routine.getName());
        out.append("(");
        routine.renderPassedEscalatedVars(out);
        out.append(");\n");
        
        if (mayThrow) {
            writeIndent(out,indent,unreachable);
            out.append("} catch (ClarionRoutineResult _crr) {\n");
            writeIndent(out,indent+1,unreachable);
            if (routine.getReturnValue()!=null) {
                out.append("return (");
                routine.getReturnValue().getType().generateDefinition(out);
                out.append(")_crr.getResult();\n");
            } else {
                out.append("return;\n");
            }
            writeIndent(out,indent,unreachable);
            out.append("}\n");
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        if (routine.mayReturnToProcedure() && inProcedure) {
            collector.add(ClarionCompiler.CLARION+".ClarionRoutineResult");
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
