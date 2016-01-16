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

import org.jclarion.clarion.compile.java.JavaDependency;
import org.jclarion.clarion.compile.java.VariableUtiliser;

public abstract class Expr implements JavaDependency,VariableUtiliser 
{
    public static boolean DEEP_UTILISATION_TEST=false;
    
    private int         precedence;
    private ExprType    type;

    public Expr(int precedence,ExprType output)
    {
        this.precedence=precedence;
        this.type=output;
    }
    
    /**
     * Return java precendence to iterate. The bigger the
     * number the higher precedence
     * 
     * 100 = high precedence. Java will evaluate first (i.e. * /)
     * 1 = low precedence. Java will evaluate last (i.e. + -)
     * 
     * 
     * @return
     */
    public int precendence()
    {
        return precedence;
    }
    
    public ExprType type()
    {
        return type;
    }
    
    /**
     * Returns true if expression requires wrapping
     * because operator we intend to apply to it
     * operates on a higher precedence than effective precedence
     * at work inside the expression
     * 
     * @return
     */
    public boolean isWrapRequired(int op,boolean commute)
    {
        if (precedence==JavaPrec.LABEL) return false;
        if (op==JavaPrec.LABEL) return false;
        
        return op>(precedence-(commute?0:1));
    }

    public Expr cast(ExprType arithmeticType) {
        return arithmeticType.cast(this);
    }

    public Expr wrap(int prec)
    {
        return wrap(prec,true);
    }
    
    public Expr wrap(int prec,boolean commute)
    {
        if (this.isWrapRequired(prec,commute)) return new WrapExpr(this);
        return this;
    }
    
    public final String toJavaString()
    {
        StringBuilder result = new StringBuilder();
        toJavaString(result);
        return result.toString();
    }
    
    public abstract void toJavaString(StringBuilder target);
}
