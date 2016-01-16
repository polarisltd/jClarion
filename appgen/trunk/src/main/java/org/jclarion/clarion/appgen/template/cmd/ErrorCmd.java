package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ErrorCmd extends Statement
{

	
	private CExpr message;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#ERROR") && params.size()==1) {
			message=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown:"+name);		
	}

	public CExpr getMessage() {
		return message;
	}

	@Override
	public String toString() {
		return "ErrorCmd [message=" + message + "]";
	}

	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.error(scope.eval(message).toString());
		return CodeResult.OK;
		
	}
	

	
}