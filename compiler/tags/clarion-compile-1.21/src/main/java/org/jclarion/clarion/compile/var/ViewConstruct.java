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

import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.ExprJavaCode;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.LinearJavaBlock;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;

/**
 * model a group construct - used for groups, files, queues etc
 * 
 * @author barney
 */

public class ViewConstruct extends Scope
{
    private ViewJavaClass javaClass;

    private String label;

    private LinearJavaBlock  props=new LinearJavaBlock();
    
    public ViewConstruct(String name)
    {
        this.label=name;
        javaClass=new ViewJavaClass(this);
    }

    public void link()
    {
        link(ScopeStack.getScope());
    }
    
    public void link(Scope s)
    {
        ClassRepository.add(getJavaClass(),label);
        ClassedVariable cv = new ClassedVariable(label,getType(),getJavaClass(),false,false,false,null);
        s.addVariable(cv);
    }
    
    public ExprType getType()
    {
        return ExprType.view;
    }
    
    public ViewJavaClass getJavaClass()
    {
        return javaClass;
    }
    
    public void setProperty(String name, Expr prop)
    {
        prop=new DecoratedExpr(JavaPrec.POSTFIX,null,name+"(",prop,");");
        props.add(new ExprJavaCode(prop));
    }
    
    public void addCode(Expr prop)
    {
        props.add(new ExprJavaCode(prop));
    }

    public JavaCode getPropertyCode()
    {
        return props;
    }
    
    @Override
    public String getName()
    {
        return getType().getName();
    }
    
}
