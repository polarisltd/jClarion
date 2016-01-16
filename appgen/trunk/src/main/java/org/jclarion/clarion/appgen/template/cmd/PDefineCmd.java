package org.jclarion.clarion.appgen.template.cmd;
import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class PDefineCmd extends CommandItem
{
	private CExpr key;
	private CExpr value;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#PDEFINE") && params.size()==2) {
			key=params.get(0).getExpression();
			value=params.get(1).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getKey() {
		return key;
	}

	public CExpr getValue() {
		return value;
	}

	@Override
	public String toString() {
		return "PDefineCmd [key=" + key + ", value=" + value + "]";
	}

	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		// do nothing
	}
	
	

	
}
