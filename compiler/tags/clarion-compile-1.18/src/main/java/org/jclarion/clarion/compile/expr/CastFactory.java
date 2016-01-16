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

public abstract class CastFactory 
{
    private ExprType type;
    
    public CastFactory(ExprType type)
    {
        this.type=type;
    }
    
    public ExprType getType()
    {
        return type;
    }
    
    public abstract Expr cast(ExprType target,Expr in);
}
