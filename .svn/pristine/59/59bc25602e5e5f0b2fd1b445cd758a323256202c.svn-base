package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateExecutionError;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class OpenCmd extends Statement
{

	private CExpr target;
	private boolean readOnly;
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("READ")) {
			readOnly=true;
			return;
		}
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#OPEN") && params.size()==1) {
			this.target=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public CExpr getTarget() {
		return target;
	}

	public boolean isReadOnly() {
		return readOnly;
	}

	@Override
	public String toString() {
		return "OpenCmd [target=" + target + ", readOnly=" + readOnly + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		if (!scope.open(scope.eval(target).toString(),readOnly ? ExecutionEnvironment.READONLY : ExecutionEnvironment.APPEND)) {
			throw new TemplateExecutionError("Cannot open file");
		}
		return CodeResult.OK;
	}

	
}
