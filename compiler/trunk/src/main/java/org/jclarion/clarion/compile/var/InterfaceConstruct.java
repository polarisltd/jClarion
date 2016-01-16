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

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;

/**
 * model a group construct - used for groups, files, queues etc
 * 
 * @author barney
 */

public class InterfaceConstruct  extends Scope
{
    private InterfaceExprType   type;
    private InterfaceJavaClass  javaClass;
    private InterfaceConstruct  baseConstruct;
    private ExprType            base;
    
    public InterfaceConstruct(ScopeStack stack,String pkg,String name,ExprType base)
    {
    	super(stack);
        this.base=base;
        type=new InterfaceExprType(name,base,this);
        javaClass=new InterfaceJavaClass(pkg,this);
        
        if (base instanceof InterfaceExprType) {
            baseConstruct = ((InterfaceExprType)base).getInterfaceConstruct();
        }
    }

    public void link(Scope s)
    {
        s.addType(getType());
        s.getStack().compiler().repository().add(getJavaClass(),s.getPackage(),getType().getName());
    }
    
    public InterfaceExprType getType()
    {
        return type;
    }
    
    public ExprType getBaseType()
    {
        return base;
    }
    
    public InterfaceConstruct getSuper()
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
    
    public InterfaceJavaClass getJavaClass()
    {
        return javaClass;
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
    public void addVariable(Variable v) {
        throw new IllegalStateException("Not allowed");
    }

    @Override
    public Procedure addProcedure(Procedure p,boolean reportDuplicates) {
        // TODO Auto-generated method stub
        Procedure r = super.addProcedure(p,reportDuplicates);
        p.setAbstract();
        
        return r;
    }
    
    @Override
    public String getName()
    {
        return getType().getName();
    }
    
}
