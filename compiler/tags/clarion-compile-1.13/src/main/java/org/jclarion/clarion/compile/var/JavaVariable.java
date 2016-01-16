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
import org.jclarion.clarion.compile.expr.SimpleExpr;

public class JavaVariable extends Variable
{
    public JavaVariable(String name,ExprType type)
    {
        super(name,type,true,false);
    }

    
    @Override
    public Variable clone() {
        return new JavaVariable(getName(),getType());
    }

    @Override
    public Expr[] makeConstructionExpr() {
        return new Expr[] { new SimpleExpr(0,null,"") };
    }

    @Override
    public String getJavaName() {
        return getName();
    }

    
}
