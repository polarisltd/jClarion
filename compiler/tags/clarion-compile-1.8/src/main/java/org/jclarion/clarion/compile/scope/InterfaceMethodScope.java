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
package org.jclarion.clarion.compile.scope;

import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.ClassConstruct;
import org.jclarion.clarion.compile.var.ClassSelfReferenceVariable;
import org.jclarion.clarion.compile.var.InterfaceImplementationConstruct;
import org.jclarion.clarion.compile.var.Variable;

public class InterfaceMethodScope extends ProcedureScope implements ClassCodeScope
{
    private InterfaceImplementationConstruct clazz;
    
    public InterfaceMethodScope(Procedure p,InterfaceImplementationConstruct clazz) {
        super(p);
        this.clazz=clazz;
    }
    
    private Variable self;
    private Variable parent;

    @Override
    public Variable getVariableThisScopeOnly(String name) {
        
        if (name.equalsIgnoreCase("self")) {
            if (self==null) self=new ClassSelfReferenceVariable(clazz.getOwnerClass(),"_owner","self");
            return self;
        }

        if (name.equalsIgnoreCase("parent")) {
            if (parent==null) parent=new ClassSelfReferenceVariable(clazz.getOwnerClass().getBase(),"_owner.super","parent");
            return parent;
        }
        
        return super.getVariableThisScopeOnly(name);
    }

    @Override
    public boolean escalateVariable(Variable v) {
        // escalate to class itself
        return clazz.getOwnerClass().escalateVariable(v);
    }
    
    @Override
    public boolean escalateModule(ModuleScope ms) {
        // escalate to class itself
        return clazz.getOwnerClass().escalateModule(ms);
    }

    @Override
    public ClassConstruct getClassScope() {
        return clazz.getOwnerClass();
    }

    @Override
    public Variable getParameter(int offset) {
        if (offset==1) return getVariableThisScopeOnly("self");
        return super.getParameter(offset-1);
    }
    
    @Override
    public int getParameterCount() {
        return super.getParameterCount()+1;
    }
    
}
