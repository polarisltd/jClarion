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
import org.jclarion.clarion.compile.expr.VariableExpr;

/**
 * Variable is a clone of another variable.
 * 
 * Couple of ways we can do like - and this class will do either.
 * Specifically:
 *  * regenerate expression precisely as in base
 *  * reference the base variable and call its like() method
 *  
 *  Option 2 above is selected if base isa array
 * 
 * @author barney
 *
 */
public class LikeVariable extends Variable 
{
    private VariableExpr base;
    private boolean forceConstruction;
    private boolean thread;
    
    public LikeVariable(String name,VariableExpr base,boolean forceConstruction,boolean Static, boolean thread)
    {
        this.base=base;
        this.forceConstruction=forceConstruction || Static;
        this.thread=thread;
        
        init(name,base.type(),base.getVariable().isReference(),Static);
    }

    @Override
    public Expr[] makeConstructionExpr() {
        if (!forceConstruction && base.type().isa(ExprType.any)) {
            return new Expr[] { new DecoratedExpr(JavaPrec.POSTFIX,base,thread?".like().setThread()":".like()") };
        } else {
            Variable v = base.getVariable();
            
            while (v instanceof AliasVariable) {
                v=((AliasVariable)v).getBase();
            }
            
            return v.makeConstructionExpr(thread);
        }
    }

    @Override
    public Variable clone() {
        return new LikeVariable(getName(),base,forceConstruction,isStatic(),false);
    }
}
