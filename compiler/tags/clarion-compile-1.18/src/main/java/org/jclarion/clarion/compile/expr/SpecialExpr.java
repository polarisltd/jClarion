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
 * Special expressions are special types of decorated expressions that codify additional
 * information because in terms of strict analysis of expression their meaning
 * is somewhat ambigious so require tracking of additional information to help 
 * later syntactic disambiguation.
 * 
 * example a)
 * 
 *    "t=1" can mean either assignment or conditional. 
 *    Depends on overall context of its use. e.g. :
 *       if t=1 then message('hello').
 *       t=1
 *    
 * example b)      
 *    t{property} can mean either property get or set.
 *    Depends on overall context of its use. e.g. :
 *       t{property}=1
 *       if t{property}=1 then message('hello').
 *       k=t{property}   
 * 
 * @author barney
 */

public class SpecialExpr extends Expr 
{
    private Expr def;
    
    public SpecialExpr(Expr def)
    {
        super(def.precendence(),def.type());
        this.def=def;
    }

    @Override
    public void toJavaString(StringBuilder target) {
        this.def.toJavaString(target);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        this.def.collate(collector);
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        return this.def.utilises(vars);
    }

    @Override
    public boolean utilisesReferenceVariables() {
        return this.def.utilisesReferenceVariables();
    }
    
    
}
