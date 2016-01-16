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
package org.jclarion.clarion.compile.rewrite;

import org.jclarion.clarion.compile.expr.Expr;

public class RewrittenExpr {
    
    public static final int EXACT=0;
    public static final int ISA=1;
    public static final int CASTABLE=2;
    
    private Expr        expr;
    private int         matchScore;

    public RewrittenExpr()
    {
    }
    
    public RewrittenExpr(Expr expr,int matchScore)
    {
        this.expr=expr;
        this.matchScore=matchScore;
    }

    public void setExpr(Expr e)
    {
        this.expr=e;
    }
    
    public Expr getExpr()
    {
        return expr;
    }
    
    public int getMatchScore()
    {
        return matchScore;
    }
    
    public void adjustMatchScore(int newScore)
    {
        if (newScore>matchScore) matchScore=newScore;
    }
    
    public void isa()
    {
        adjustMatchScore(ISA);
    }
    
    public void castable()
    {
        adjustMatchScore(CASTABLE);
    }
    
    public String toJavaString()
    {
        return getExpr().toJavaString();
    }
}
