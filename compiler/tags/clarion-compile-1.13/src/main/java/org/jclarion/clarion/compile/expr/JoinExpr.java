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

import java.util.Set;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;

public class JoinExpr extends Expr
{

    private String lead;
    private String mid;
    private String trail;
    private Expr left;
    private Expr right;

    public JoinExpr(int precedence, ExprType output,Expr left,String mid,Expr right,String trail) {
        this(null,left,mid,right,trail,precedence,output);
    }

    public JoinExpr(int precedence, ExprType output,String lead,Expr left,Expr right,String trail) {
        this(lead,left,null,right,trail,precedence,output);
    }

    public JoinExpr(int precedence, ExprType output,String lead,Expr left,String mid,Expr right) {
        this(lead,left,mid,right,null,precedence,output);
    }

    public JoinExpr(int precedence, ExprType output,Expr left,String mid,Expr right) {
        this(null,left,mid,right,null,precedence,output);
    }
    
    
    public JoinExpr(int precedence, ExprType output,String lead,Expr left,String mid,Expr right,String trail) {
        this(lead,left,mid,right,trail,precedence,output);
    }
    
    public JoinExpr(String lead,Expr left,String mid,Expr right,String trail,int precedence, ExprType output) {
        super(precedence, output);
        this.lead=lead;
        this.mid=mid;
        this.trail=trail;

        this.right=right;
        this.left=left;
        // TODO Auto-generated constructor stub
    }

    @Override
    public void toJavaString(StringBuilder target) {
        if (lead!=null) target.append(lead);
        left.toJavaString(target);
        if (mid!=null) target.append(mid);
        right.toJavaString(target);
        if (trail!=null) target.append(trail);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        left.collate(collector);
        right.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (left.utilises(vars)) return true;
        if (right.utilises(vars)) return true;
        return false;
    }
    
    @Override
    public boolean utilisesReferenceVariables()
    {
        if (left.utilisesReferenceVariables()) return true;
        if (right.utilisesReferenceVariables()) return true;
        return false;
    }
}
