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
package org.jclarion.clarion.compile.prototype;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;

/**
 * Model a prototype
 * 
 * Prototypes have following properties
 * 
 *  + name
 *  + Expression Type (which includes array settings)
 *  + Passed by Reference or passed by value
 *  + optional flag and default value if any
 *  + whether or not it is constant (has no effect in Java)
 * 
 * @author barney
 *
 */
public class Param 
{
    private String   name;
    private ExprType type;
    private boolean  passByReference;
    private boolean  optional;
    private Expr     defaultValue;
    private boolean  constant;
    
    public Param(String name,ExprType type,
            boolean passByReference,
            boolean optional,
            Expr    defaultValue,
            boolean constant)
    {
        this.name=name;
        this.type=type;
        this.passByReference=passByReference;
        this.optional=optional;
        this.defaultValue=defaultValue;
        this.constant=constant;
    }
    
    public String getName()
    {
        return name;
    }
    
    public ExprType getType() {
        return type;
    }
    public boolean isPassByReference() {
        return passByReference;
    }
    public boolean isOptional() {
        return optional;
    }
    public Expr getDefaultValue() {
        return defaultValue;
    }
    public boolean isConstant() {
        return constant;
    }

    public void setName(String name) {
        this.name=name;
    }
}
