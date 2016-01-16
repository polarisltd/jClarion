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

import java.util.Iterator;

import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.ClassConstruct;
import org.jclarion.clarion.compile.var.ClassSelfReferenceVariable;
import org.jclarion.clarion.compile.var.Variable;

import org.jclarion.clarion.util.JoinedIterator;
import org.jclarion.clarion.util.SingleIterator;

public class MethodScope extends ProcedureScope implements ClassCodeScope
{
    private ClassConstruct clazz;
    
    public MethodScope(ScopeStack stack,Procedure p,ClassConstruct clazz) {
        super(stack,p);
        this.clazz=clazz;
    }
    
    private Variable self;
    private Variable parent;

    @Override
    public Variable getVariableThisScopeOnly(String name) {
        
        if (name.equalsIgnoreCase("self")) {
            if (self==null) self=new ClassSelfReferenceVariable(clazz,"this","self");
            return self;
        }

        if (name.equalsIgnoreCase("parent") && clazz.getSuper()!=null) {
            if (parent==null) parent=new ClassSelfReferenceVariable(clazz.getBase(),"super","parent");
            return parent;
        }
        
        return super.getVariableThisScopeOnly(name);
    }

    @Override
    public boolean escalateVariable(Variable v) {
        // escalate to class itself
        return clazz.escalateVariable(v);
    }

    @Override
    public boolean escalateModule(ModuleScope ms) {
        // escalate to class itself
        return clazz.escalateModule(ms);
    }

    @Override
    public ClassConstruct getClassScope() {
        return clazz;
    }


    public static class PaddedParameterNames implements Iterable<String>
    {
        private Iterable<String> base;
        
        public PaddedParameterNames(Iterable<String> base)
        {
            this.base=base;
        }
        
        @SuppressWarnings("unchecked")
        @Override
        public Iterator<String> iterator() {
            return new JoinedIterator<String>(new SingleIterator<String>(null),base.iterator());
        }
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
