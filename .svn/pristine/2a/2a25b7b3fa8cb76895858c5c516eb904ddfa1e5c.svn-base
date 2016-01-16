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

    private boolean singleFunctionModule;
    private boolean singleFunctionModuleCalc;
    
    public ModuleScopedJavaClass(ModuleScope c, String pkg) {
        super(c, pkg);
        clearCompiled();
    }
    
	@Override    
    protected boolean isStatic(Variable v)
    {
    	return true;
    }
    

    public boolean isSingleFunctionModuleDefined()
    {
        return singleFunctionModuleCalc;
    }
    
	public boolean isSafeSingleFunctionModule() {
		if (singleFunctionModuleCalc) return singleFunctionModule; 
        Iterator<Procedure> i = super.getMethods().iterator();
        int count=0;
        while (count<2 && i.hasNext()) {
            count++;
            i.next();
        }
        return count==1;
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
            i.next();
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
    protected void buildVariables(StringBuilder main,JavaDependencyCollector collector) {
    	
    	super.buildVariables(main,collector);
   
        if (singleFunctionModule) {

        	Set<String> existingVars=new HashSet<String>();
        	for (Variable v : getFields()) {
        		existingVars.add(v.getJavaName());
        	}
        	
            ProcedureScope ps = super.getMethods().iterator().next().getImplementationScope();

            for (Variable v : ps.getVariables() ) {
            	if (v.getScope()!=getScope() && v.getScope()!=ps) continue;
            	if (existingVars.contains(v.getJavaName())) continue;
                if (v instanceof EquateVariable) continue;
                
                
                main.append("\tpublic ");
                v.generateDefinition(main);
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
    
}
