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

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.scope.ProcedureScope;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.Variable;

public class ModuleScopedJavaClass extends ScopedJavaClass {

//    private ModuleScope module;
    private boolean singleFunctionModule;
    private boolean singleFunctionModuleCalc;
    
    public ModuleScopedJavaClass(ModuleScope c, String pkg) {
        super(c, pkg);
//        this.module=c;
    }

    public boolean isSingleFunctionModuleDefined()
    {
        return singleFunctionModuleCalc;
    }
    
    public boolean isSingleFunctionModule()
    {
        if (!singleFunctionModuleCalc) throw new IllegalStateException("do not know yet for"+getName());
        return singleFunctionModule;
    }
    
    public void calculateSingleFunctionModule()
    {
        singleFunctionModuleCalc=true;
        
        Iterator<Procedure> i = super.getMethods().iterator();
        int count=0;
        while (count<2 && i.hasNext()) {
            count++;
        }
        
        if (count==1) {
            singleFunctionModule=true;
            super.getMethods().iterator().next().suppressConstructFields();
        }
        
        if (count>1) {
            i = super.getMethods().iterator();
            while (i.hasNext()) {
                i.next().setStatic();
            }
        }
    }

    @Override
    protected void buildVariables(StringBuilder main,
            JavaDependencyCollector collector) {

        for (Variable v : getFields() ) {
            main.append("\tpublic ");
            main.append("static ");
            v.generateDefinition(main);
            v.getDefinitionDependency().collate(collector);
            main.append(";\n");
        }

        if (singleFunctionModule) {

            ProcedureScope ps = super.getMethods().iterator().next().getImplementationScope();

            for (Variable v : ps.getVariables() ) {
                if (v instanceof EquateVariable) continue;
                main.append("\tpublic ");
                v.generateInitCapable(main);
                v.collate(collector);
                main.append(";\n");
            }

            
            for (int scan=1;scan<=ps.getParameterCount();scan++) {
                Variable v=ps.getParameter(scan);
                main.append("\tpublic ");
                v.generateDefinition(main);
                v.collate(collector);
                main.append(";\n");
            }
            
        }
    }
    
    
    @Override
    public void appendFieldModifier(StringBuilder out) {
        if (!singleFunctionModule) {
            out.append("static ");
        }
    }
    
    public void fixSingleDisorder()
    {
        if (!singleFunctionModule) return;

        ProcedureScope ps = super.getMethods().iterator().next().getImplementationScope();
        
        // look for variables which are dependent on passed variables
        if (ps.getParameterCount()>0) {
            Set<Variable> vars = new HashSet<Variable>();
            for (int scan=1;scan<=ps.getParameterCount();scan++) {
                vars.add(ps.getParameter(scan));
            }
            for (Variable v : ps.getVariables() ) {
                if (v.isInitConstructionMode()) continue;
                if (v.utilises(vars)) {
                    v.setInitConstructionMode(true);
                }
            }
        }
    }
}
