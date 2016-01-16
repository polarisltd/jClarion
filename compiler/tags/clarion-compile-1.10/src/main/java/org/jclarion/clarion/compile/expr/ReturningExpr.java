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

public class ReturningExpr {

    private ExprType type;
    private boolean reference;

    public ReturningExpr(ExprType type,boolean reference)
    {
        this.type=type;
        this.reference=reference;
    }

    public ExprType getType() {
        return type;
    }

    public boolean isReference() {
        return reference;
    }
    
    
    
}
