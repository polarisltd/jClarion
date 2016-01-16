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

public class SingleLabelExpr extends SpecialExpr {

    private String label;
    
    public SingleLabelExpr(String label,Expr def) {
        super(def);
        this.label=label;
    }
   
    public String getLabel()
    {
        return label;
    }
}
