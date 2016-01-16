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

import org.jclarion.clarion.compile.expr.ControlExprType;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.NullExpr;

public class ControlVariable extends Variable {

    public ControlVariable(String name,String type)
    {
        super(name,new ControlExprType(type),false,false);
    }
    
    
    
    @Override
    public Expr[] makeConstructionExpr() {
        return new Expr[] { new NullExpr() };
    }

    @Override
    public Variable clone() {
        return new ControlVariable(getName(),getType().getName());
    }

}
