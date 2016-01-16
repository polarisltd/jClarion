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
package org.jclarion.clarion.compile.var;

import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;

public class InterfaceJavaClass extends JavaClass
{
    private InterfaceConstruct group;
    private String base;
    
    public InterfaceJavaClass(String base,InterfaceConstruct group)
    {
        this.group=group;
        this.base=base;
    }

    @Override
    public Iterable<Variable> getFields() {
        return group.getVariables();
    }

    @Override
    public Iterable<Procedure> getMethods() {
        return group.getProcedures();
    }

    @Override
    public String getPackage() {
        return base;
    }

    @Override
    public JavaClass getSuper() {
        if (group.getSuper()!=null) {
            return group.getSuper().getJavaClass();
        }
        return null;
    }

    @Override
    public boolean isAbstract() {
        return true;
    }
    
    @Override
    public Scope getScope()
    {
        return group;
    }

    @Override
    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
        // TODO Auto-generated method stub
        
    }
    
}
