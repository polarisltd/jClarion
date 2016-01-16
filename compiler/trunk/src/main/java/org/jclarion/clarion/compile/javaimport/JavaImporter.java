package org.jclarion.clarion.compile.javaimport;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.var.JavaClassExprType;
import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.JavaClassConstruct;
import org.jclarion.clarion.compile.var.JavaVariable;
import org.jclarion.clarion.compile.var.Variable;


public abstract class JavaImporter<X> {
	
	
	private Map<String,ExprType> types = new HashMap<String,ExprType>();
	
	private Map<String,ExprType> oldTypes = new HashMap<String,ExprType>();
	
	protected ClarionCompiler compiler;
	
	public JavaImporter()
	{
	}
	
	public void setCompiler(ClarionCompiler compiler)
	{
		this.compiler=compiler;
	}
		
	public abstract X				resolve(String name);	
	public abstract String   		getSuperClass(X item);	
	public abstract MethodImport[] 	getMethods(X item);
	public abstract FieldImport[] 	getFields(X item);
	
	public void resetCache()
	{
		oldTypes.putAll(types);
		types.clear();
	}
	
	public ExprType process(String name)
	{
		ExprType e=ExprType.getBasicJavaMapping(name);
		if (e==null) {
			e=types.get(name);
		}
		if (e!=null) {
    		if (e!=null && e instanceof JavaClassExprType) {
            	if (compiler!=null) {
            		compiler.main().addType(e);
            	}
            }        	
        	return e;
        }
        
        X resolve = resolve(name);
        if (resolve==null) return null;
        
        String scname = getSuperClass(resolve);
        ExprType sc=null;
        if (scname!=null) {
        	sc=process(scname);
        }
        if (sc==null) sc = ExprType.object;
    
        JavaClassConstruct jcc=null;
        ExprType old = oldTypes.get(name);
        if (old!=null && old instanceof JavaClassExprType) {
        	jcc=((JavaClassExprType)old).getClassConstruct();
        } else {
            jcc = new JavaClassConstruct(compiler==null  ? null : compiler.stack(),name, sc);
            old=null;
        }

        types.put(name,jcc.getType());
        if (compiler!=null) {
        	ExprType et = compiler.getScope().getType(jcc.getName());
        	if (et != null) {
        		if (old==null) return et;
        	} else {
        		compiler.getScope().addType(jcc.getType());
        	}
        } else {
        	ExprType.addBasicJavaMapping(name,jcc.getType());
        }
        
        // raid methods
        main : for (MethodImport m : getMethods(resolve)) {
        	
        	Param clarion_params[] = new Param[m.getArgs().length];
        	for (int scan=0;scan<clarion_params.length;scan++) {
        		ExprType et = process(m.getArgs()[scan]);
        		if (et==null) continue main;
        		clarion_params[scan]=new Param("v"+scan,et,true,false,null,false);
        	}
            Procedure p;
            if (m.getRet()!=null) {
            	ExprType ret = process(m.getRet());
            	if (ret==null)  continue;
                ReturningExpr re = new ReturningExpr(ret,true);
                p = new Procedure(m.getName(), re, clarion_params);
            } else {
                p = new Procedure(m.getName(), clarion_params);
            }
            p.setNoRelabel(true);
            jcc.addProcedure(p, old==null);
        }
        
        for (FieldImport f : getFields(resolve)) {
        	ExprType typ = process(f.getType());
        	if (typ==null) continue;
            Variable v = new JavaVariable(f.getName(),typ);
            jcc.addVariable(v);
        }

        return jcc.getType();
	}
}
