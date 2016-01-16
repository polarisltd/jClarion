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

public class UsesExpr extends Expr {

    private Expr r;
    private Variable[] v;
    
    public UsesExpr(Expr r,Variable... v)
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
        for (int scan=0;scan<v.length;scan++) {
            if (vars.contains(v[scan])) return true;
        }
        return r.utilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() 
    {
        for (int scan=0;scan<v.length;scan++) {
            if (v[scan].isReference()) return true;
        }
        return r.utilisesReferenceVariables();
    }
    
}
