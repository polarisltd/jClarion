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

import org.jclarion.clarion.compile.expr.CallExpr;
import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.FilledExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.PrototypeExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;

public class JavaClassExprType extends ClassedExprType {

    private JavaClassConstruct group;
    
    public JavaClassExprType(String name,ExprType base,JavaClassConstruct group)
    {
        super(GrammarHelper.capitalise(name),base,0);
        this.group=group;
    }
    
    private JavaClassExprType()
    {
    }
    
    @Override
    public FilledExprType cloneType() {
        JavaClassExprType clone = new JavaClassExprType();
        clone.group=this.group;
        return clone;
    }

    @Override
    public Expr field(Expr in, String field) {
        Variable v = group.getVariableThisScopeOnly(field);
        if (v!=null) {
            
            if (v.isStatic()) {
                return v.getExpr(ScopeStack.getScope());
            }
            
            return new VariableExpr(
                    new DecoratedExpr(JavaPrec.POSTFIX,v.getType(),null,in,"."+v.getJavaName()),v);
        }
        
        return null;
    }
    
    @Override
    public Expr method(Expr in, String field, Expr[] params) {
        Procedure p = group.matchProcedureThisScopeOnly(field,params);
        if (p==null) return null;
        
        return new CallExpr(new DecoratedExpr(JavaPrec.POSTFIX,in,"."),p,false,params);
    }
    
    @Override
    public Expr prototype(Expr in, String field) {
        
        JavaClassConstruct scan = group;
        while (scan!=null) {
            for ( Procedure p : scan.getProcedures(field)) {
                return new PrototypeExpr(p);
            }
        }
        return  null;
    }
    
    
    public JavaClassConstruct getClassConstruct() {
        return group;
    }

    @Override
    public JavaClass getJavaClass() {
        return group.getJavaClass();
    }

    @Override
    public Scope getDefinitionScope() {
        return group; 
    }

}
