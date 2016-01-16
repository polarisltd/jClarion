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
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.Variable;

public class EquateExpr extends VariableExpr {

    private static boolean equateMode;
    
    public static void setEquateMode()
    {
        equateMode=true;
    }

    public static void clearEquateMode()
    {
        equateMode=false;
    }

    public static boolean isEquateMode() {
        return equateMode;
    }

    
    private EquateVariable var;
    
    public EquateExpr(EquateVariable var) {
        super(JavaPrec.POSTFIX, var.getType(),var);
        this.var=var;
    }

    @Override
    public void toJavaString(StringBuilder target) {

        if (!equateMode) {
            target.append(var.getEquateClass().getName());
            target.append(".");
            target.append(var.getJavaName());
        } else {
            var.getInit().toJavaString(target);
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) 
    {
        var.getEquateClass().collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return false;
    }

}
