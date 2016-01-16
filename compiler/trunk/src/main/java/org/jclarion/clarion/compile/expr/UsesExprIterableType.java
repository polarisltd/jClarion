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

public class UsesExprIterableType extends Expr {

    private Expr r;
    private Iterable<Variable> v;
    
    public UsesExprIterableType(Expr r,Iterable<Variable> v)
    {
        super(r.precendence(),r.type());
        this.r=r;
        this.v=v;
    }

    @Override
    public void toJavaString(StringBuilder target) {
        r.toJavaString(target);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        r.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        for (Variable t : v) {
            if (vars.contains(t)) return true;
        }
        return r.utilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() {
        for (Variable t : v) {
            if (t.isReference()) return true;
        }
        return false;
    }

    
}
