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
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.PolymorphicFieldIterable;
import org.jclarion.clarion.compile.scope.PolymorphicScope;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;

/**
 * model a group construct - used for groups, files, queues etc
 * 
 * @author barney
 */

public class JavaClassConstruct  extends Scope implements PolymorphicScope
{
    private ExprType base;
    private String   name;
    private String   pkg;
    
    private JavaClassExprType type;
    private JavaClassConstruct baseConstruct;
    private JavaClass jc;
    
    public JavaClassConstruct(ScopeStack stack,String fullName,ExprType base)
    {
    	super(stack);
        this.base=base;
        
        int lastDot = fullName.lastIndexOf('.');
        name=fullName.substring(lastDot+1);
        if (lastDot>-1) {
            pkg=fullName.substring(0,lastDot);
        } else {
            pkg="";
        }
       
        type=new JavaClassExprType(name,base,this);
        
        if (base instanceof JavaClassExprType) {
            baseConstruct = ((JavaClassExprType)base).getClassConstruct();
        }
        
        jc=new JavaClass() {

            @Override
            public Iterable<? extends Variable> getFields() {
                // TODO Auto-generated method stub
                return null;
            }

            @Override
            public Iterable<? extends Procedure> getMethods() {
                // TODO Auto-generated method stub
                return null;
            }

            @Override
            public String getPackage() {
                return pkg; 
            }

            @Override
            protected void buildConstructor(StringBuilder main,
                    JavaDependencyCollector collector) {
                // TODO Auto-generated method stub
                
            }
        };
        jc.setName(name);
    }

    public JavaClassExprType getType()
    {
        return type;
    }
    
    public ExprType getBaseType()
    {
        return base;
    }
    
    public JavaClassConstruct getSuper()
    {
        return baseConstruct;
    }

    public ExprType getSuperType()
    {
        if (getSuper()==null) {
            return ExprType.object;
        } else {
            return getSuper().getType();
        }
    }
    
    public JavaClass getJavaClass()
    {
        return jc;
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
    public Procedure matchProcedureThisScopeOnly(String label, Expr[] params) {
        
        Procedure match = super.matchProcedureThisScopeOnly(label, params);
        if (match==null && getSuper()!=null) {
            match=getSuper().matchProcedureThisScopeOnly(label,params);
        }
        return match;
    }
    
    
    
    @Override
    public void addType(ExprType type,Scope originatingScope) 
    {
        // push new types up a single level, maybe
        getParent().addType(type,originatingScope);
    }

    @Override
    public Iterable<Variable> getAllFields() 
    {
        // TODO Auto-generated method stub
        return new PolymorphicFieldIterable(this);
    }

    @Override
    public PolymorphicScope getBase() 
    {
        return baseConstruct;
    }

    @Override
    public Scope getScope() 
    {
        return this;
    }

    @Override
    public String getName()
    {
        return getJavaClass().getName();
    }
    
    @Override
    public ClassedExprType getClassType() 
    {
        return getType();
    }
}
