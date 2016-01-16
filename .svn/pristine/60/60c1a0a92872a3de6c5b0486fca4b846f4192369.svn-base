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

public class RawExprType extends FilledExprType {

    private String toPrimitive;
    private String javaName;
    
    public RawExprType(String name,String toPrimitive,String javaName) 
    {
        super(name, ExprType.object,0);
        this.toPrimitive=toPrimitive;
        this.javaName=javaName;
    }

    protected RawExprType() {
        // TODO Auto-generated constructor stub
    }

    @Override
    public Expr cast(Expr in) 
    {
        if (in instanceof NullExpr) return in;
        
        if (in.type().isa(this)) return in;
        
        if (!in.type().isRaw() && in.type().isSystem()) {
            return new DecoratedExpr(JavaPrec.POSTFIX,this,null,in.wrap(JavaPrec.POSTFIX),toPrimitive);
        }
        
        return super.cast(in);
    }

    @Override
    public FilledExprType cloneType() {
        RawExprType c = new RawExprType();
        c.toPrimitive=toPrimitive;
        c.javaName=javaName;
        return c;
    }

    @Override
    public void generateDefinition(StringBuilder out) {
        out.append(javaName);
        for (int scan=getArrayDimSize();scan>0;scan--) {
            out.append("[]");
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        // nothing to collate as java primitives are always already in scope
    }

    
}
