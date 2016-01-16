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
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;

public class AliasVariable extends Variable
{
    private Variable base;
    
    public AliasVariable(String name,Variable base,boolean Static)
    {
        super(name,base.getType(),base.isReference(),Static);
        this.base=base;
    }

    public Variable getBase()
    {
        return base;
    }
    
    @Override
    public Expr[] makeConstructionExpr() {
        return new Expr[] { new SimpleExpr(JavaPrec.LABEL,getType(),base.getJavaName()) };
    }

    @Override
    public Variable clone() {
        return new AliasVariable(getName(),base,isStatic());
    }
}
