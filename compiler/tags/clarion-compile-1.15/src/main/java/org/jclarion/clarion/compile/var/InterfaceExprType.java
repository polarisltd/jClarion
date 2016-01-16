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
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;

public class InterfaceExprType extends ClassedExprType {

    private InterfaceConstruct group;
    
    public InterfaceExprType(String name,ExprType base,InterfaceConstruct group)
    {
        super(GrammarHelper.capitalise(name),base,0);
        this.group=group;
    }
    
    private InterfaceExprType()
    {
    }
    
    @Override
    public FilledExprType cloneType() {
        InterfaceExprType clone = new InterfaceExprType();
        clone.group=this.group;
        return clone;
    }

    @Override
    public Expr method(Expr in, String field, Expr[] params) {
        Procedure p = group.matchProcedureThisScopeOnly(field,params);
        if (p==null) return null;
        
        return new CallExpr(new DecoratedExpr(JavaPrec.POSTFIX,in,"."),p,false,params);
    }
    
    public InterfaceConstruct getInterfaceConstruct() {
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
