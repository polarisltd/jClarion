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

public class UseVar {

    private String      name;
    private Expr        variable;
    private Expr        id;
    
    public UseVar(String name)
    {
        this(name,null,null);
    }

    public UseVar(String name,Expr variable,Expr id)
    {
        this.name=name;
        this.variable=variable;
        this.id=id;
    }
    
    public String getName()
    {
        return name;
    }
    
    public Expr getVariable()
    {
        return variable;
    }
    
    public Expr getID()
    {
        return id;
    }
    
}
