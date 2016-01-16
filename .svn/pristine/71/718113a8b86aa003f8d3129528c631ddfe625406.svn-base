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
package org.jclarion.clarion.compile.var;

import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.FilledExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.MemoryModelCastFactory;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.scope.Scope;

public class GroupExprType extends ClassedExprType {

    private GroupConstruct group;
    
    public GroupExprType(String name,ExprType base,GroupConstruct group)
    {
        super(GrammarHelper.capitalise(name),base,0);
        this.group=group;
        add(new MemoryModelCastFactory(ExprType.group));
    }
    
    private GroupExprType()
    {
    }
    
    @Override
    public FilledExprType cloneType() {
        GroupExprType clone = new GroupExprType();
        clone.group=this.group;
        return clone;
    }

    @Override
    public Expr field(Expr in, String field,Scope callingScope) {
        Variable v = group.getVariableThisScopeOnly(field);
        if (v==null) {
            // scan and try and find something
            GroupConstruct gc = group;
            
            String scan = ":"+field.toLowerCase();
            
            while (gc!=null && v==null) {
                for ( Variable test : gc.getVariables() ) {
                    if (test.getName().toLowerCase().endsWith(scan)) {
                        v=test;
                        break;
                    }
                }
                gc=gc.getSuper();
            }
        }
        
        if (v==null) return null;
        
        return new VariableExpr(
            new DecoratedExpr(JavaPrec.POSTFIX,v.getType(),null,in,"."+v.getJavaName()),v);
    }

    public GroupConstruct getGroupConstruct() {
        return group;
    }

    @Override
    public JavaClass getJavaClass() {
        return group.getJavaClass();
    }
    
    @Override
    public Scope getDefinitionScope() {
        return group;
    }

}
