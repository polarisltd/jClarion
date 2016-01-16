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

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.var.Variable;

public class VariablePrototypeExprType extends FilledExprType
{
    private Variable v;
    
    public VariablePrototypeExprType(Variable v)
    {
        super(v.getName(),ExprType.prototype,0);
        this.v=v;
    }
    
    public Variable getVariable()
    {
        return v;
    }

    @Override
    public FilledExprType cloneType() {
        return new VariablePrototypeExprType(v);
    }

    @Override
    public void generateDefinition(StringBuilder out) {
        throw new IllegalStateException("Not allowed");
    }

    @Override
    public void collate(JavaDependencyCollector collector) 
    {
    }

    @Override
    public Expr array(Expr in, Expr subscript) {
        if (v.getType()==null) return null;
        return v.getType().array(in,subscript);
    }

    @Override
    public Expr field(Expr in, String field,Scope callingScope) {
        if (v.getType()==null) return null;
        return v.getType().field(in,field,callingScope);
    }

    @Override
    public Expr method(Expr in, String field, Expr[] params) {
        if (v.getType()==null) return null;
        return v.getType().method(in,field,params);
    }

    @Override
    public Expr property(Expr in, Expr[] keys) {
        if (v.getType()==null) return null;
        return v.getType().property(in,keys);
    }

    @Override
    public Expr splice(Expr in, Expr left, Expr right) {
        if (v.getType()==null) return null;
        return v.getType().splice(in,left,right);
    }
}
