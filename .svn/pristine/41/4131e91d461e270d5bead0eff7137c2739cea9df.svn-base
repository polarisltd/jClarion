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
import org.jclarion.clarion.compile.java.ModuleScopedJavaClass;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.ModuleScope;
import org.jclarion.clarion.compile.var.Variable;

public class ProcCallExpr extends Expr
{
    private Procedure p;
    
    public ProcCallExpr(Procedure p)
    {
        super(JavaPrec.LABEL,null);
        this.p=p;
    }
    
    @Override
    public void toJavaString(StringBuilder target) 
    {
        if (p.getScope() instanceof ModuleScope) {
            ModuleScopedJavaClass c=((ModuleScope)p.getScope()).getModuleClass(); 
            if (!c.isSafeSingleFunctionModule()) {
                target.append(p.getScope().getJavaClass().getName());
                target.append(".");
                return;
            }
        }
        
        target.append("(new ");
        target.append(p.getScope().getJavaClass().getName());
        target.append("()).");
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        p.getScope().getJavaClass().collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return false;
    }

    @Override
    public boolean utilisesReferenceVariables() {
        return false;
    }
}
