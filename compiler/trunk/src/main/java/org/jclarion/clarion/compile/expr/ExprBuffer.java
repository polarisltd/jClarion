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
import org.jclarion.clarion.compile.var.Variable;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;

public class ExprBuffer extends Expr {

    private List<Expr> list;
    
    public ExprBuffer(int precedence, ExprType output) {
        super(precedence, output);
        list=new ArrayList<Expr>();
    }
    
    public int getEntryCount()
    {
        return list.size();
    }
    
    public boolean isEmpty()
    {
        return list.isEmpty();
    }
    
    public ExprBuffer add(String aVal)
    {
        return add(new SimpleExpr(0,null,aVal));
    }
    
    public ExprBuffer add(Expr aVal)
    {
        list.add(aVal);
        return this;
    }

    @Override
    public void toJavaString(StringBuilder target) {
        for (Expr node : list ){
        	if (node==null) {
        		target.append("NULL");
        	} else {
        		node.toJavaString(target);
        	}
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        for (Expr node : list ) {
        	if (node!=null) {
        		node.collate(collector);
        	}
        }
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        for (Expr node : list ) {
            if (node.utilises(vars)) return true;
        }
        return false;
    }

    public boolean utilisesReferenceVariables()
    {
        for (Expr node : list ) {
            if (node.utilisesReferenceVariables()) return true;
        }
        return false;
    }
}
