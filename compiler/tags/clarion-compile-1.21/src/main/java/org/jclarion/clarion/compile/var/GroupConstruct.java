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

import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.PolymorphicFieldIterable;
import org.jclarion.clarion.compile.scope.PolymorphicScope;
import org.jclarion.clarion.compile.scope.Scope;

/**
 * model a group construct - used for groups, files, queues etc
 * 
 * @author barney
 */

public class GroupConstruct  extends Scope implements PolymorphicScope
{
    private GroupExprType  type;
    private GroupJavaClass javaClass;
    private GroupConstruct baseConstruct;
    private ExprType       base;
    private String        pre;
    
    public GroupConstruct(String name,ExprType base)
    {
        if (!base.isa(ExprType.group)) throw new IllegalStateException("Base needs to be group type");
        this.base=base;
        type=new GroupExprType(name,base,this);
        javaClass=new GroupJavaClass(this);
        
        if (base instanceof GroupExprType) {
            baseConstruct = ((GroupExprType)base).getGroupConstruct();
        }
    }
    
    public String getPre() {
        return pre;
    }

    public void setPre(String pre) {
        this.pre = pre;
    }    

    public void link()
    {
        link(getParent());
    }
    
    boolean linked=false;
    public void link(Scope s)
    {
        if (linked) return;
        linked=true;
        s.addType(getType());
        ClassRepository.add(getJavaClass(),getType().getName());
    }
    
    public GroupExprType getType()
    {
        return type;
    }
    
    public ExprType getBaseType()
    {
        return base;
    }
    
    public GroupConstruct getSuper()
    {
        return baseConstruct;
    }

    public ExprType getSuperType()
    {
        if (getSuper()==null) {
            return ExprType.group;
        } else {
            return getSuper().getType();
        }
    }
    
    public GroupJavaClass getJavaClass()
    {
        return javaClass;
    }

    @Override
    public Variable getVariableThisScopeOnly(String name) {
        Variable v = super.getVariableThisScopeOnly(name);
        if (v==null && getSuper()!=null) {
            v=getSuper().getVariableThisScopeOnly(name);
        }
        return v;
    }

    @Override
    public Procedure addProcedure(Procedure p,boolean reportDuplicates) {
        throw new IllegalStateException("Not allowed");
    }

    @Override
    public void addType(ExprType type,Scope originatingScope) {
        // push new types up a single level, maybe
        getParent().addType(type,originatingScope);
    }

    @Override
    public Iterable<Variable> getAllFields() {
        return new PolymorphicFieldIterable(this);
    }

    @Override
    public PolymorphicScope getBase() {
        return baseConstruct;
    }
    
    @Override
    public String getName()
    {
        link();
        return getJavaClass().getName();
    }

    @Override
    public Scope getScope() {
        return this;
    }
    
    @Override
    public ClassedExprType getClassType() 
    {
        return getType();
    }

	@Override
	public void addVariable(Variable aVariable) {
		if (aVariable.isReference()) aVariable.escalateReference();
		super.addVariable(aVariable);
	}
    
    
}
