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

public class StringSpliceExpr extends AssignableExpr 
{
    private Expr base;
    private Expr var;
    private Expr p1;
    private Expr p2;
    
    public StringSpliceExpr(Expr base,Expr var,Expr p1,Expr p2) 
    {
        super(base.precendence(), base.type());
        
        this.base=base;
        this.var=var;
        this.p1=p1;
        this.p2=p2;
    }

    @Override
    public Expr assign(Expr right,boolean byReference) {
        if (byReference) throw new IllegalStateException("Cannot assign string splice via reference");
        
        ListExpr e = new ListExpr(JavaPrec.LABEL,null,false,p1);
        if (p2!=null) e.add(",",p2);
        e.add(",",right);
        
        return new JoinExpr(JavaPrec.POSTFIX,null,var,".setStringAt(",e,");");
    }

    @Override
    public void toJavaString(StringBuilder target) {
        base.toJavaString(target);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        base.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return base.utilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() 
    {
        return base.utilisesReferenceVariables();
    }
    
    
}
