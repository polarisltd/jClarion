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


public class PotentialAssignmentExpr extends SpecialExpr
{
    private Expr right;
    private AssignableExpr assign;
    private boolean byReference;
    
    public PotentialAssignmentExpr(Expr def,AssignableExpr assign,Expr right,boolean byReference) 
    {
        super(def);
        this.right=right;
        this.assign=assign;
        this.byReference=byReference;
    }
    
    public AssignableExpr getLeftExpr()
    {
        return assign;
    }
    
    public Expr getRightExpr()
    {
        return right;
    }
    
    public Expr getAssignExpr()
    {
        return assign.assign(right,byReference);
    }
}
