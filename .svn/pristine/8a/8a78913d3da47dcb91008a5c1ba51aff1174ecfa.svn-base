package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class MsgCmd extends Statement
{

	
	private CExpr message;
	private int line;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#MESSAGE") && params.size()==2) {
			message=params.get(0).getExpression();
			line = params.get(1).getInt();
			return;
		}
		throw new ParseException("Unknown:"+name);		
	}

	public CExpr getMessage() {
		return message;
	}

	public int getLine() {
		return line;
	}

	@Override
	public String toString() {
		return "MsgCmd [message=" + message
				+ ", line=" + line + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.message(scope.eval(message).toString(),line);
		return CodeResult.OK;
	}
	
}
