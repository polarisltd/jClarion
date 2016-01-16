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

import java.util.Set;

import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.FilledExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.VariableUtiliser;
import org.jclarion.clarion.compile.scope.Scope;

public class TargetExprType extends ClassedExprType implements VariableUtiliser
{
    private TargetConstruct group;
    
    public TargetExprType(String name,ExprType type,TargetConstruct group)
    {
        super(name,type,0);
        this.group=group;
    }
    
    private TargetExprType() { }

    @Override
    public JavaClass getJavaClass() {
        return group.getJavaClass();
    }

    @Override
    public FilledExprType cloneType() {
        TargetExprType clone = new TargetExprType();
        clone.group=this.group;
        return clone;
    }

    @Override
    public Scope getDefinitionScope() {
        return group;
    }

    @Override
    public Expr field(Expr in, String field,Scope callingScope) {
        
        Variable v = group.getVariable(field);
        if (v!=null) {
            return new VariableExpr(
                    new DecoratedExpr(JavaPrec.POSTFIX,v.getType(),null,in,"."+v.getJavaName()),v);
        }
        
        return null;
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return group.getJavaClass().initUtilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() 
    {
        return group.getJavaClass().initUtilisesReferenceVariables();
    }

    @Override
    public boolean isDestroyable() {
        return true;
    }

    @Override
    public Expr destroy(Expr in) 
    {
        return new DecoratedExpr(JavaPrec.POSTFIX,in.wrap(JavaPrec.POSTFIX),".close()");
    }
}
