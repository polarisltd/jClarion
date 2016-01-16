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

import org.jclarion.clarion.compile.expr.DecoratedExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.java.ExprJavaCode;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.LinearJavaBlock;
import org.jclarion.clarion.compile.java.SimpleJavaCode;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.ScopeStack;

/**
 * model a group construct - used for groups, files, queues etc
 * 
 * @author barney
 */

public class FileConstruct  extends Scope
{
    private FileExprType  type;
    private FileJavaClass javaClass;

    private Expr          driver;
    private String        pre;
    private boolean       thread;
    
    private LinearJavaBlock  props=new LinearJavaBlock();

    private String label;
    
    public FileConstruct(ScopeStack root,String base,String name)
    {
    	super(root);
        this.label=name;
        type=new FileExprType(name,this);
        javaClass=new FileJavaClass(base,this);
    }

    public void link(Scope s)
    {
        s.addType(getType());
        s.getStack().compiler().repository().add(getJavaClass(),s.getPackage(),getType().getName());
        ClassedVariable cv = new ClassedVariable(label,getType(),getJavaClass(),false,false,thread,null);
        s.addVariable(cv);
        
        if (pre!=null) {
            s.addVariable(new AliasVariable(pre,cv,false));
        }
    }
    
    public FileExprType getType()
    {
        return type;
    }
    
    public FileJavaClass getJavaClass()
    {
        return javaClass;
    }

    @Override
    public Procedure addProcedure(Procedure p,boolean reportDuplicates) {
        throw new IllegalStateException("Not allowed");
    }

    public Expr getDriver() {
        return driver;
    }

    public void setDriver(Expr driver) {
        this.driver = driver;
    }
    
    public void setThread(boolean thread)
    {
        this.thread=thread;
    }

    public void setProperty(String name, Expr prop)
    {
        prop=new DecoratedExpr(JavaPrec.POSTFIX,null,name+"(",prop,");");
        props.add(new ExprJavaCode(prop));
    }

    public JavaCode getPropertyCode()
    {
        return props;
    }
    
    public String getPre() {
        return pre;
    }

    public void setPre(String pre) {
        this.pre = pre;
        setProperty("setPrefix",new SimpleExpr(JavaPrec.LABEL,ExprType.rawstring,'"'+pre+'"'));
    }

    public String getDriverType() {
        
        String s = getDriver().toJavaString();
        if (s.equalsIgnoreCase("\"odbc\"")) return "SQL";
        if (s.equalsIgnoreCase("\"ascii\"")) return "Ascii";
        if (s.equalsIgnoreCase("\"basic\"")) return "Basic";
        if (s.equalsIgnoreCase("\"dos\"")) return "Binary";
        
        throw new IllegalStateException("Do not know how to map file driver type:"+s);
    }

    @Override
    public String getName() {
        return getType().getName();
    }

    public void setCreate() 
    {
        props.add(new SimpleJavaCode("setCreate();"));
    }
    
	@Override
	public void addVariable(Variable aVariable) {
		if (aVariable.isReference()) aVariable.escalateReference();
		super.addVariable(aVariable);
	}
    
}
