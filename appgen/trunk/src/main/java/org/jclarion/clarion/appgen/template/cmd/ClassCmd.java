package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ClassCmd extends CommandItem
{

	private String name;
	private CExpr description;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#CLASS") && params.size()==2) {
			this.name = params.get(0).getString();
			this.description = params.get(1).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getName() {
		return name;
	}

	public CExpr getDescription() {
		return description;
	}

	@Override
	public String toString() {
		return "ClassCmd [name=" + name + ", description=" + description + "]";
	}
	
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		((CodeSection)parent).addClass(this);
	}
	
	
}
