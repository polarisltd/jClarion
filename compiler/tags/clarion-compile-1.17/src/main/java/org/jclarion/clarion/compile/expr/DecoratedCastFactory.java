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

public class DecoratedCastFactory extends CastFactory
{
    private int javaprec;
    private String left;
    private String right;
    private int wrap;
    private String[] depend;

    public DecoratedCastFactory(ExprType type,int javaprec,String left,int wrap,String right,String... depend) {
        super(type);
        this.javaprec=javaprec;
        this.left=left;
        this.right=right;
        this.wrap=wrap;
        this.depend=depend;
    }

    @Override
    public Expr cast(ExprType target,Expr in) {
        Expr e = new DecoratedExpr(javaprec,getType(),left,in.wrap(wrap),right);
        if (depend!=null && depend.length>0) {
            e=new DependentExpr(e,depend);
        }
        return e;
    }
}
