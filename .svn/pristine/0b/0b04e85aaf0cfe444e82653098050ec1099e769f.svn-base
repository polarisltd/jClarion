package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateExecutionError;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class CreateCmd extends Statement
{

	private CExpr target;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#CREATE") && params.size()==1) {
			this.target=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public CExpr getTarget() {
		return target;
	}

	@Override
	public String toString() {
		return "CreateCmd [target=" + target + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		if (!scope.open(scope.eval(target).toString(),ExecutionEnvironment.CREATE)) {
			throw new TemplateExecutionError("Cannot open file");
		}
		return CodeResult.OK;
	}	
}
