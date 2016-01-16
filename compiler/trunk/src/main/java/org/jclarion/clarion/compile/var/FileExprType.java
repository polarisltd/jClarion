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
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.scope.Scope;

public class FileExprType extends ClassedExprType {

    private FileConstruct group;
    
    public FileExprType(String name,FileConstruct group)
    {
        super(GrammarHelper.capitalise(name),ExprType.file,0);
        this.group=group;
    }
    
    public FileConstruct getFileConstruct()
    {
        return group;
    }
    
    private FileExprType()
    {
    }
    
    @Override
    public FilledExprType cloneType() {
        FileExprType clone = new FileExprType();
        clone.group=this.group;
        return clone;
    }

    @Override
    public Expr field(Expr in, String field,Scope callingScope) {
        
        Variable v = group.getVariableThisScopeOnly(field);
        if (v!=null) {
            return new VariableExpr(
                    new DecoratedExpr(JavaPrec.POSTFIX,v.getType(),null,in,"."+v.getJavaName()),v);
        }
        
        if (field.equalsIgnoreCase("record")) return in;
        
        return null;
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
