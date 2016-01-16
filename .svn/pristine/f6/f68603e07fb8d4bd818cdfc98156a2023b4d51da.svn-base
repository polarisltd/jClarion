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

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;

public class SystemExprType extends FilledExprType 
{

    private String fromPrimitive;
    private String fromOther;
    private String javaString;
    
    private String  dependency;
    
    public SystemExprType(String name, ExprType base, int array,String fromPrimitive,String fromOther) {
        super(name, base, array);
        
        javaString="Clarion"+GrammarHelper.capitalise(name);
        if (name.equals("view")) {
            dependency=ClarionCompiler.CLARION+".view."+javaString;
        } else {
            dependency=ClarionCompiler.CLARION+"."+javaString;
        }
        this.fromPrimitive=fromPrimitive;
        this.fromOther=fromOther;
    }

    protected SystemExprType() 
    {
    }

    @Override
    public Expr cast(Expr in) {
    
        if (in.type().isa(this)) return in;

        Expr base = super.cast(in);
        if (base!=null) return base;
        
        if (fromPrimitive!=null && in.type().isRaw()) {
            Expr e = new DecoratedExpr(JavaPrec.LABEL,this,fromPrimitive,in,")");
            e=new DependentExpr(e,ClarionCompiler.CLARION+".Clarion");
            return e;
        }

        if (fromOther!=null && in.type().isSystem()) {
            if (in.type().same(this)) return in;
            return new DecoratedExpr(JavaPrec.LABEL,this,null,in.wrap(JavaPrec.POSTFIX),fromOther);
        }

        return null;
    }

    @Override
    public FilledExprType cloneType() {
        SystemExprType set = new SystemExprType();
        set.fromOther=this.fromOther;
        set.fromPrimitive=this.fromPrimitive;
        set.javaString=this.javaString;
        set.dependency=this.dependency;
        return set;
    }

    @Override
    public void generateDefinition(StringBuilder out) {
        for (int scan=getArrayDimSize();scan>0;scan--) {
            out.append("ClarionArray<");
        }
        out.append(javaString);
        for (int scan=getArrayDimSize();scan>0;scan--) {
            out.append(">");
        }
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        collector.add(dependency);
    	if (getArrayDimSize()>0) {
    		collector.add(ClarionCompiler.CLARION+".ClarionArray");
    	}
    }
}
