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
package org.jclarion.clarion.compile.expr;

import java.util.Set;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;

public class PropertyExpr extends AssignableExpr
{
    private Expr left;
    private Expr[] params;
    
    public PropertyExpr(Expr left,Expr[] params)
    {
        super(JavaPrec.POSTFIX,ExprType.any);
        this.left=left.wrap(JavaPrec.POSTFIX);
        this.params=params;
    }

    @Override
    public Expr assign(Expr right, boolean byReference) {
        
        ExprBuffer eb = new ExprBuffer(JavaPrec.POSTFIX,null);
        
        boolean like=false;
        
        if ( (right instanceof VariableExpr) && right.type().isa(ExprType.any) ) {
            like=true;
            if (params[0] instanceof EquateExpr) {
                String name = ((EquateExpr)params[0]).getVariable().getName(); 
                if (name.equalsIgnoreCase("prop:use")) like=false;
                if (name.equalsIgnoreCase("prop:sql")) like=false;
            }
        }
        
        eb.add(left);
        if (like) {
            eb.add(".setClonedProperty(");
        } else {
            eb.add(".setProperty(");
        }
        for (int scan=0;scan<params.length;scan++) {
            if (scan>0) eb.add(",");
            eb.add(params[scan]);
        }
        eb.add(",");
        
        /*
        if (like) {
            eb.add(right.wrap(JavaPrec.POSTFIX));
            if (right.type().same(ExprType.any)) {
                eb.add(".genericLike()");
            } else {
                eb.add(".like()");
            }
        } else {
        }
        */
        eb.add(right);
        
        eb.add(");");
        return eb;
    }

    @Override
    public void toJavaString(StringBuilder target) {
        left.toJavaString(target);
        target.append(".getProperty(");
        for (int scan=0;scan<params.length;scan++) {
            if (scan>0) target.append(",");
            params[scan].toJavaString(target);
        }
        target.append(")");
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        left.collate(collector);
        
        for (int scan=0;scan<params.length;scan++) {
            params[scan].collate(collector);
        }
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (left.utilises(vars)) return true;
        for (int scan=0;scan<params.length;scan++) {
            if (params[scan].utilises(vars)) return true;
        }
        return false;
    }
    
    @Override
    public boolean utilisesReferenceVariables()
    {
        if (left.utilisesReferenceVariables()) return true;
        for (int scan=0;scan<params.length;scan++) {
            if (params[scan].utilisesReferenceVariables()) return true;
        }
        return false;
    }
    
}
