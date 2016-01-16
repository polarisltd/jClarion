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
import org.jclarion.clarion.compile.prototype.Param;
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

public class ClassConstruct  extends Scope implements PolymorphicScope
{
    private ClassExprType       type;
    private ClassJavaClass      javaClass;
    private ClassedExprType     baseConstruct;
    private ExprType            base;
    
    public ClassConstruct(ScopeStack stack,String pkg,String name,ExprType base)
    {
    	super(stack);
        this.base=base;
        type=new ClassExprType(name,base,this);
        javaClass=new ClassJavaClass(pkg,this);
        
        if (base instanceof ClassedExprType) {
            baseConstruct = (ClassedExprType)base;
        }
    }
    
    public void link()
    {
    	link(getParent(),getParent());
    }

    boolean linked=false;
    public void link(Scope typeScope,Scope implemScope)
    {
        if (linked) return;
        linked=true;
        typeScope.addType(getType());
        getJavaClass().setImplementationScope(implemScope);
        getStack().compiler().repository().add(getJavaClass(),implemScope.getPackage(),getType().getName());
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
    	InterfaceImplementationConstruct result = interfaces.get(name.toLowerCase());
    	if (result==null) {
    		Scope s = getSuper();
    		if (s!=null && s instanceof ClassConstruct) {
    			result=((ClassConstruct)s).getInterface(name);
    		}
    	}
    	return result;
    }
    
    public void addInterface(InterfaceExprType value) 
    {
        InterfaceImplementationConstruct iic = new InterfaceImplementationConstruct(getStack(),value.getInterfaceConstruct(),this);

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
    
    public boolean isStaticScope()
    {
    	return true;
    }	
}
