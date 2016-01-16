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

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;


public class ListExpr extends Expr {

    private static class Node
    {
        private String op;
        private String rop;
        private Expr right;
        
        public Node(String op,Expr right,String rop)
        {
            this.op=op;
            this.right=right;
            this.rop=rop;
        }
    }
    
    private List<Node> list = new ArrayList<Node>();
    private boolean commute;

    public ListExpr(int precedence,ExprType type,boolean commute,String join,Expr... elements)
    {
        super(precedence,type);
        this.commute=commute;
        add(null,elements[0]);
        for (int scan=1;scan<elements.length;scan++) {
            add(join,elements[scan]);
        }
    }

    public ListExpr(int precedence,ExprType type,boolean commute,String join,Collection<Expr> elements)
    {
        super(precedence,type);
        this.commute=commute;
        Iterator<Expr> e = elements.iterator();
        add(null,e.next());
        while (e.hasNext()) {
            add(join,e.next());
        }
    }
    
    
    public ListExpr(int precedence,ExprType type,boolean commute,Expr left)
    {
        super(precedence,type);
        this.commute=commute;
        add(null,left);
    }
    
    public void add(String op,Expr right)
    {
        list.add(new Node(op,right,null));
    }

    public void add(String op,Expr right,String rop)
    {
        list.add(new Node(op,right,rop));
    }

    
    @Override
    public void toJavaString(StringBuilder output) {
        for (Node scan : list ) {
            if (scan.op!=null) {
                output.append(scan.op);
            }
            
            // consider we are * / (high precedence) and right
            // is low precedence (+ -) - we want to wrap
            // if list type is not commutitive than equal precedence
            // needs to be wrapped too
            
            boolean wrap = scan.right.isWrapRequired(precendence(),commute); 

            if (wrap) output.append('(');

            scan.right.toJavaString(output);
            
            if (wrap) output.append(')');
            
            if (scan.rop!=null) {
                output.append(scan.rop);
            }
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        for (Node n : list ) {
            n.right.collate(collector);
        }
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        for (Node n : list ) {
            if (n.right.utilises(vars)) return true;
        }
        return false;
    }

    @Override
    public boolean utilisesReferenceVariables()
    {
        for (Node n : list ) {
            if (n.right.utilisesReferenceVariables()) return true;
        }
        return false;
    }
    
}
