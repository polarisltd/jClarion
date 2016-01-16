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

public class AlternateCastFactory extends CastFactory
{
    private ExprType output;

    public AlternateCastFactory(ExprType type,ExprType output) {
        super(type);
        this.output=output;
        // TODO Auto-generated constructor stub
    }

    @Override
    public Expr cast(Expr in) {
        return output.cast(in);
    }
}
