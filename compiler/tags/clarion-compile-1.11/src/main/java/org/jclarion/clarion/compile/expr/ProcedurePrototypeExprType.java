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
import org.jclarion.clarion.compile.prototype.Procedure;

public class ProcedurePrototypeExprType extends FilledExprType
{
    private Procedure p;
    
    public ProcedurePrototypeExprType(Procedure p)
    {
        super(p.getName(),ExprType.prototype,0);
        this.p=p;
    }

    public Procedure getProcedure()
    {
        return p;
    }
    
    @Override
    public FilledExprType cloneType() {
        return new ProcedurePrototypeExprType(p);
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
        if (p.getResult()==null) return null;
        return p.getResult().getType().array(in,subscript);
    }

    @Override
    public Expr field(Expr in, String field) {
        if (p.getResult()==null) return null;
        return p.getResult().getType().field(in,field);
    }

    @Override
    public Expr method(Expr in, String field, Expr[] params) {
        if (p.getResult()==null) return null;
        return p.getResult().getType().method(in,field,params);
    }

    @Override
    public Expr property(Expr in, Expr[] keys) {
        if (p.getResult()==null) return null;
        return p.getResult().getType().property(in,keys);
    }

    @Override
    public Expr splice(Expr in, Expr left, Expr right) {
        if (p.getResult()==null) return null;
        return p.getResult().getType().splice(in,left,right);
    }
}
