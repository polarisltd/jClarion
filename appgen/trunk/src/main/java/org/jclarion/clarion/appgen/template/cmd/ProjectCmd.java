package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ProjectCmd extends Statement
{

	private CExpr module;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#PROJECT") && params.size()==1) {
			this.module=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public CExpr getModule() {
		return module;
	}

	@Override
	public String toString() {
		return "ProjectCmd [module=" + module + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return CodeResult.OK;
	}
	
}
