package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class PrintCmd extends Statement
{
	private CExpr file;
	private CExpr description;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#PRINT") && params.size()==2) {
			file=params.get(0).getExpression();
			description=params.get(1).getExpression();
			return;
		}
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getFile() {
		return file;
	}

	public CExpr getDescription() {
		return description;
	}

	@Override
	public String toString() {
		return "PrintCmd [file=" + file + ", description=" + description + "]";
	}

	
}
