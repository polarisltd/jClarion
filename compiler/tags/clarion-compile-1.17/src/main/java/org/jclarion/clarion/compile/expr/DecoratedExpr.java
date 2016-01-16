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

/**
 *  Restricted form of ListExpr
 *  
 * @author barney
 *
 */
public class DecoratedExpr extends Expr
{
    private String left;
    private String right;
    private Expr middle;

    public DecoratedExpr(int precedence,Expr middle,String right) 
    {
        this(precedence,middle.type(),null,middle,right);
    }

    public DecoratedExpr(int precedence,String left,Expr middle) 
    {
        this(precedence,middle.type(),left,middle,null);
    }
    
    public DecoratedExpr(int precedence,String left,Expr middle,String right) 
    {
        this(precedence,middle.type(),left,middle,right);
    }

    public DecoratedExpr(int precedence, ExprType output,String left,Expr middle,String right) 
    {
        super(precedence, output);
        
        this.left=left;
        this.right=right;
        this.middle=middle;
        
        if (middle==null) throw new IllegalStateException("Not accepting a null decorate");
    }

    @Override
    public void toJavaString(StringBuilder target) {
        
        if (left!=null) target.append(left);
        
        middle.toJavaString(target);
        
        if (right!=null) target.append(right);
        
        // TODO Auto-generated method stub
    }

    @Override
    public void collate(JavaDependencyCollector collector) 
    {
        middle.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return middle.utilises(vars);
    }
    
    public boolean utilisesReferenceVariables()
    {
        return middle.utilisesReferenceVariables();
    }
    
}
