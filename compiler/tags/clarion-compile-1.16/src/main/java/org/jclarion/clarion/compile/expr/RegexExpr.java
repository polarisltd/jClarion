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
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;

/** 
 * run expression through various regex ops.
 * 
 * Brutal ugly hammer - only use in emergencies
 */

public class RegexExpr extends Expr
{
    private Expr base;

    private static class PatternOp
    {
        Pattern search;
        String  replace;
        boolean all;
    }
    private List<PatternOp> ops=new ArrayList<PatternOp>();
    
    public RegexExpr(Expr base) {
        super(base.precendence(),base.type());
        this.base=base;
    }
    
    public RegexExpr add(String search,String replace,boolean all)
    {
        PatternOp po=new PatternOp();
        po.search=Pattern.compile(search);
        po.replace=replace;
        po.all=all;
        
        ops.add(po);
        
        return this;
    }

    @Override
    public void toJavaString(StringBuilder target) {
        String s = base.toJavaString();
        
        for ( PatternOp op : ops ) {
            Matcher m = op.search.matcher(s);
            if (op.all) {
                s=m.replaceAll(op.replace);
            } else {
                s=m.replaceFirst(op.replace);
            }
        }
        target.append(s);
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
    public boolean utilisesReferenceVariables() {
        return base.utilisesReferenceVariables();
    }
    
    
}
