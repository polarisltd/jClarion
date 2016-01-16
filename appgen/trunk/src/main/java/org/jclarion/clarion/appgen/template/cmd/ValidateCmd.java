package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ValidateCmd extends Widget
{
	private CExpr test;
	private CExpr message;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#VALIDATE") && params.size()==2) {
			test=params.get(0).getExpression();
			message=params.get(1).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getTest() {
		return test;
	}

	public CExpr getMessage() {
		return message;
	}

	@Override
	public String toString() {
		return "ValidateCmd [test=" + test + ", message=" + message + "]";
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return "#ValidateCmd";
	}


	
}
