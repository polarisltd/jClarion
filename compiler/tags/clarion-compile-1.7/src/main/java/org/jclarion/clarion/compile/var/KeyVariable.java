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

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.JoinExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.setting.SettingResult;

public class KeyVariable extends Variable
{
    private Expr init;
    
    public KeyVariable(String name,SettingResult<?> setting[])
    {
        super(name,ExprType.key,false,false);
        
        init=new SimpleExpr(JavaPrec.LABEL,ExprType.key,getJavaName());
        
        for (int scan=0;scan<setting.length;scan++) {
            String key = setting[scan].getName();
            Object value = setting[scan].getValue();
            
            if (key.equals("dup")) {
                init=new DecoratedExpr(JavaPrec.POSTFIX,init,".setDuplicate()");
                continue;
            }

            if (key.equals("primary")) {
                init=new DecoratedExpr(JavaPrec.POSTFIX,init,".setPrimary()");
                continue;
            }

            if (key.equals("nocase")) {
               init=new DecoratedExpr(JavaPrec.POSTFIX,init,".setNocase()");
                continue;
            }

            if (key.equals("opt")) {
                init=new DecoratedExpr(JavaPrec.POSTFIX,init,".setOptional()");
                continue;
            }

            if (key.equals("name")) {
                init=new JoinExpr(JavaPrec.POSTFIX,ExprType.key,init,".setName(",(Expr)value,")");
                continue;
            }
            
            throw new IllegalStateException("Unknown setting:"+key);
        }
    }
    
    public void addAscendingColumn(Variable v)
    {
        init=new DecoratedExpr(JavaPrec.POSTFIX,init,
            ".addAscendingField("+v.getJavaName()+")");
    }

    public void addDescendingColumn(Variable v)
    {
        init=new DecoratedExpr(JavaPrec.POSTFIX,init,
            ".addAscendingField("+v.getJavaName()+")");
    }

    public Expr getInitExpr()
    {
        return init;
    }
    
    @Override
    public Expr[] makeConstructionExpr() {
        Expr e = new SimpleExpr(JavaPrec.CREATE,ExprType.key,"new ClarionKey(\""+getName()+"\")");
        e=new DependentExpr(e,ClarionCompiler.CLARION+".ClarionKey");
        return new Expr[] { e };
    }

    @Override
    public Variable clone() {
        throw new RuntimeException("Clone not supported");
    }
}
