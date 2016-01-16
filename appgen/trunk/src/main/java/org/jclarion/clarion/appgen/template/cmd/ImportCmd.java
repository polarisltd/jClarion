package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ImportCmd extends Statement
{
	private CExpr file;
	private boolean replace;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("REPLACE")) {
			replace=true;
			return;
		}
		if (flag.equals("RENAME")) {
			replace=false;
			return;
		}
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#IMPORT") && params.size()==1) {
			file=params.get(0).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getFile() {
		return file;
	}

	public boolean isReplace() {
		return replace;
	}

	@Override
	public String toString() {
		return "ImportCmd [file=" + file + ", replace=" + replace + "]";
	}
	
}
