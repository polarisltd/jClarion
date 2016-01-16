package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class DebugCmd extends Statement
{
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}
	
	private CExpr expr;

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#DEBUG")) {
			if (params.size()>0) {
				expr = params.get(0).getExpression();
			}
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		/*
		SymbolScope ss = scope.getScope();
		while ( true ) {
			SymbolEntry e = ss.get("%AdditionObjectNumber");
			if (e==null) break;
			System.err.println("ON:"+e.getValue());
			ss=ss.getParentScope();					
		}
		ss = scope.getScope();
		while ( true ) {
			SymbolEntry e = ss.get("%classitem");
			if (e==null) break;
			System.err.println("ci:"+e.list().values()+" FROM :"+ss);
			ss=ss.getParentScope();					
		}
		*/
		//scope.debugScope();
		if (expr!=null) {
			System.err.println("EXPR:"+scope.eval(expr).toString());
		}
		return CodeResult.OK;
	}			
}
