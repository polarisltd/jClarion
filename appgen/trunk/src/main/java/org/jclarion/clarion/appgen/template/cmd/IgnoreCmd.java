package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class IgnoreCmd extends CommandItem
{

	
	private String command;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		
	}
	
	@Override
	public void init(TemplateParser parser, CommandLine line) throws ParseException 
	{
		super.init(parser, line);
		this.command=line.getCommand();
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
	}

	@Override
	public String toString() {
		return "Ignored:"+command;
	}

	protected void execute(TemplateParser parser,TemplateItem parent)
	{
	}

}
