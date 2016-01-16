package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateExecutionError;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class CloseCmd extends Statement
{

	private CExpr file;
	private boolean readonly;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("READ")) {
			readonly=true;
			return;
		}
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#CLOSE")) {
			return;
		}
		if (name.equals("#CLOSE") && params.size()==1) {
			file=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}
	
	
	public CExpr getFile() {
		return file;
	}

	public boolean isReadonly() {
		return readonly;
	}

	@Override
	public String toString() {
		return "CloseCmd [file=" + file + ", readonly=" + readonly + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		if (!scope.close(file!=null ? scope.eval(file).toString() : null,readonly)) {
			throw new TemplateExecutionError("Cannot close file");
		}
		return CodeResult.OK;
	}
	
	
}
