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

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.PolymorphicFieldIterable;
import org.jclarion.clarion.compile.scope.PolymorphicScope;
import org.jclarion.clarion.compile.scope.Scope;

/**
 * model a group construct - used for groups, files, queues etc
 * 
 * @author barney
 */

public class ClassConstruct  extends Scope implements PolymorphicScope
{
    private ClassExprType       type;
    private ClassJavaClass      javaClass;
    private ClassedExprType     baseConstruct;
    private ExprType            base;
    
    public ClassConstruct(String name,ExprType base)
    {
        this.base=base;
        type=new ClassExprType(name,base,this);
        javaClass=new ClassJavaClass(this);
        
        if (base instanceof ClassedExprType) {
            baseConstruct = (ClassedExprType)base;
        }
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
    
    public ClassExprType getType()
    {
        return type;
    }
    
    public ExprType getBaseType()
    {
        return base;
    }
    
    public Scope getSuper()
    {
        if (baseConstruct==null) return null;
        return baseConstruct.getDefinitionScope();
    }

    public ExprType getSuperType()
    {
        if (baseConstruct==null) {
            return ExprType.group;
        } else {
            return baseConstruct;
        }
    }
    
    public ClassJavaClass getJavaClass()
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
    public Procedure matchProcedureThisScopeOnly(String label, Expr[] params) {
        
        Procedure match = super.matchProcedureThisScopeOnly(label, params);
        if (match==null && getSuper()!=null) {
            match=getSuper().matchProcedureThisScopeOnly(label,params);
        }
        return match;
    }
    
    
    
    @Override
    public void addType(ExprType type,Scope originatingScope) {
        // push new types up a single level, maybe
        getParent().addType(type,originatingScope);
    }

    private Map<String,InterfaceImplementationConstruct> interfaces=new HashMap<String, InterfaceImplementationConstruct>();
    
    public Iterable<InterfaceImplementationConstruct> getInterfaces()
    {
        return interfaces.values();
    }

    public InterfaceImplementationConstruct getInterface(String name)
    {
        return interfaces.get(name.toLowerCase());
    }
    
    public void addInterface(InterfaceExprType value) 
    {
        InterfaceImplementationConstruct iic = new InterfaceImplementationConstruct(value.getInterfaceConstruct(),this);

        InterfaceConstruct hierarchy_scan = value.getInterfaceConstruct();
        
        while (hierarchy_scan!=null) {
            for (Procedure p : hierarchy_scan.getProcedures() ) {
            
                Param params[] = p.getParams();
            
                Param c_params[] = new Param[params.length];
                for (int scan=0;scan<c_params.length;scan++) {
                    Param t = params[scan];
                    c_params[scan]=new Param(
                            t.getName(),
                            t.getType(),
                            t.isPassByReference(),
                            false,
                            null,
                            t.isConstant());
                }
            
                Procedure c_p = new Procedure(p.getName(),p.getResult(),c_params);
                c_p.setCalled();
                iic.addProcedure(c_p,true);
            }
            
            hierarchy_scan=hierarchy_scan.getSuper();
        }
        
        interfaces.put(value.getName().toLowerCase(),iic);
    }

    @Override
    public Iterable<Variable> getAllFields() {
        // TODO Auto-generated method stub
        return new PolymorphicFieldIterable(this);
    }

    @Override
    public PolymorphicScope getBase() 
    {
        if (baseConstruct!=null) {
            return (PolymorphicScope)baseConstruct.getDefinitionScope();
        }
        return null;
    }

    @Override
    public Scope getScope() {
        return this;
    }

    @Override
    public String getName()
    {
        link();
        return getJavaClass().getName();
    }

    @Override
    public ClassedExprType getClassType() 
    {
        return getType();
    }
    
}
