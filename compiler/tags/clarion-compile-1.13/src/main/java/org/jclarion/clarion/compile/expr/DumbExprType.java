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

public class DumbExprType extends FilledExprType
{

    public DumbExprType(String name, ExprType base) 
    {
        super(name, base,0);
    }

    protected DumbExprType() {
        // TODO Auto-generated constructor stub
    }

    @Override
    public Expr array(Expr in, Expr subscript) {
        return null;
    }

    @Override
    public Expr cast(Expr in) {
        return null;
    }

    @Override
    public Expr field(Expr in, String field) {
        return null;
    }

    @Override
    public Expr method(Expr in, String field, Expr[] params) {
        return null;
    }

    /*
    @Override
    public Expr property(Expr in, Expr[] keys) {
        return null;
    }
    */

    @Override
    public Expr splice(Expr in, Expr left, Expr right) {
        return null;
    }

    @Override
    public FilledExprType cloneType() {
        return new DumbExprType();
    }

    @Override
    public void generateDefinition(StringBuilder out) {
        out.append(getName());
        for (int scan=getArrayDimSize();scan>0;scan--) {
            out.append("[]");
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        // we are dumb - we don't know how to collate
    }
}
