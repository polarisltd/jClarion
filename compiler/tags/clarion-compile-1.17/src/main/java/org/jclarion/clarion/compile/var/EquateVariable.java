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

import org.jclarion.clarion.compile.expr.EquateExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.EquateClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.scope.Scope;

public class EquateVariable extends Variable
{
    private Expr init;
    private EquateClass clazz;
    private String javaname;
    
    public EquateVariable(String fullName,EquateClass clazz,String name,Expr init)
    {
        super(fullName,init.type(),false,false);
        this.init=init;
        this.clazz=clazz;
        this.clazz.addVariable(this);
        this.javaname=name.toUpperCase();
        
        char c =this.javaname.charAt(0);
        if (c>='0' && c<='9') this.javaname="_"+this.javaname; 
    }
    
    public Expr getInit()
    {
        return init;
    }
    
    public EquateClass getEquateClass()
    {
        return clazz;
    }
    
    
    @Override
    public Expr[] makeConstructionExpr() {
        return new Expr[] { init }; 
    }

    @Override
    public VariableExpr getExpr(Scope callingScope) {
        return new EquateExpr(this);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        super.collate(collector);
        clazz.collate(collector);
        init.collate(collector);
    }

    @Override
    public String getJavaName() {
        return javaname;
    }

    @Override
    public Variable clone() {
        return new EquateVariable(getName(),clazz,javaname,init);
    }
}
