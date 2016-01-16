package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class IndentCmd extends Statement
{
	private CExpr indent;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#INDENT") && params.size()==1) {
			indent=params.get(0).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getIndent() {
		return indent;
	}

	@Override
	public String toString() {
		return "IndentCmd [indent=" + indent + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		
		int inc=scope.eval(indent).intValue();
		scope.setIndent(scope.getIndent()+inc);
		return CodeResult.OK;
	}	
	
}
