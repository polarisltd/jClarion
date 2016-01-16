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

import org.jclarion.clarion.compile.java.JavaDependency;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.SimpleCollector;
import org.jclarion.clarion.compile.var.Variable;

public class DependentExpr extends Expr
{
    private Expr r;
    private JavaDependency d;
    
    public DependentExpr(Expr r,JavaDependency d)
    {
        super(r.precendence(),r.type());
        this.r=r;
        this.d=d;
    }

    public DependentExpr(Expr r,String... d)
    {
        super(r.precendence(),r.type());
        this.r=r;
        this.d=new SimpleCollector(d);
    }
    
    @Override
    public void toJavaString(StringBuilder target) {
        r.toJavaString(target);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        r.collate(collector);
        d.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return r.utilises(vars);
    }
    
    public boolean utilisesReferenceVariables()
    {
        return r.utilisesReferenceVariables();
    }
    
}
