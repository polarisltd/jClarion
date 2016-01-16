package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class AssertCmd extends Statement
{
	private CExpr condition;
	private CExpr message;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#ASSERT") && params.size()>=1 && params.size()<=2) {
			condition=params.get(0).getExpression();
			if (params.size()==2) {
				message = params.get(1).getExpression();
			}
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getCondition() {
		return condition;
	}

	public CExpr getMessage() {
		return message;
	}

	@Override
	public String toString() {
		return "AssertCmd [condition=" + condition + ", message=" + message
				+ "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		if (!scope.eval(condition).boolValue()) {
			String msg =scope.eval(message).toString();
			System.err.println(msg);
			scope.error(msg);
		}
		return CodeResult.OK;
	}		
}


