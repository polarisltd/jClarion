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

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.JoinExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.grammar.VariableParser;
import org.jclarion.clarion.compile.setting.SettingResult;

public class SimpleVariable extends Variable 
{
    private List<Expr>      dim=null;
    private VariableExpr    over;
    private Expr            construct;
    private Expr            extname;
    private String          encoding;
    private boolean         thread;

    public SimpleVariable(String name,ExprType type,Expr init,String encoding,boolean reference,boolean Static,Expr extname,VariableExpr over,List<Expr> dim) 
    {
        super(name,type,reference,Static);
        this.encoding=encoding;
        this.construct=init;
        this.extname=extname;
        this.over=over;
        this.dim=dim;
    }
    
    public SimpleVariable(String name,ExprType type,Expr init,String encoding,boolean reference,SettingResult<?> modifiers[]) 
    {
        this.encoding=encoding;
        this.construct=init;
        
        boolean Static=false;

        if (modifiers!=null) {
        for (int scan=0;scan<modifiers.length;scan++) {
            SettingResult<?> r = modifiers[scan];
            
            if (VariableParser.ignoreableAttribute(r.getName())) continue;
            
            if (r.getName().equals("static")) {
                Static=true;
                continue;
            }

            if (r.getName().equals("thread")) {
                thread=true;
                continue;
            }
            
            if (r.getName().equalsIgnoreCase("over")) {
                over = (VariableExpr)r.getValue();
                over.getVariable().escalateDeepReferences();
                continue;
            }
     
            if (r.getName().equalsIgnoreCase("external")) {
                setExternal(true);
                continue;
            }
            
            
            if (r.getValue() instanceof Expr[]) {
                Expr[] e = (Expr[])r.getValue();
                if (r.getName().equals("dim")) {
                    if (dim==null) dim=new ArrayList<Expr>();
                    for (Expr ie : e) {
                    	dim.add(ExprType.rawint.cast(ie));
                    }
                    continue;
                }
            }
            if (r.getValue() instanceof Expr) { 
                if (r.getName().equals("name")) {
                	this.extname=(Expr)r.getValue();
                    continue;
                }
            }

            throw new IllegalStateException("Unknown Result:"+r.getName());
            
        }
        }
        
        if (dim!=null) type=type.changeArrayIndexCount(dim.size());

        init(name,type,reference,Static);
    }

    public Expr[] makeConstructionExpr(boolean thread) {
        
        Expr out = construct;
        
        if (encoding!=null) {
            out=new DecoratedExpr(JavaPrec.POSTFIX,
                out.wrap(JavaPrec.POSTFIX),
                ".setEncoding(Clarion"+
                GrammarHelper.capitalise(getType().getName())+
                "."+(encoding.toUpperCase())+")");
            
            out=new DependentExpr(out,ClarionCompiler.CLARION+
                    ".Clarion"+GrammarHelper.capitalise(getType().getName()));
        }

        if (extname!=null) {
            out=new JoinExpr(JavaPrec.POSTFIX,out.type(),
                out.wrap(JavaPrec.POSTFIX),".setName(",extname,")");
        }

        if (dim!=null) {
            // TODO -  not strictly correct. type changes as result of
            // this. Result is correct but inputs as created above are inaccurate
        	ExprBuffer eb = new ExprBuffer(JavaPrec.POSTFIX,out.type());
        	eb.add(out.wrap(JavaPrec.POSTFIX));
        	for (int scan=dim.size()-1;scan>=0;scan--) {
        		Expr delement=dim.get(scan);
        		eb.add(".dim(");
        		eb.add(delement);
        		eb.add(")");
        	}
        	
        	out=eb;
        }
        
        if (over!=null) {
            out=new JoinExpr(JavaPrec.POSTFIX,out.type(),
                out.wrap(JavaPrec.POSTFIX),
                ".setOver(",over.getBase(),")");
        }
        
        if (thread) {
            ExprBuffer eb = new ExprBuffer(JavaPrec.POSTFIX,out.type());
            eb.add(out);
            eb.add(".setThread()");
            out=eb;
        }

        return new Expr[] { out };
    }
    
    @Override
    public final Expr[] makeConstructionExpr() {
        return makeConstructionExpr(thread);
    }

    @Override
    public Variable clone() {

        return new SimpleVariable(getName(),getType(),construct,encoding,
            isReference(),isStatic(),extname,over,dim);
    }

    protected boolean isThread()
    {
        return thread;
    }    
}
