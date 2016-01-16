package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class DebugItem extends CommandItem
{
	private String result="";
	

	@Override
	public void init(TemplateParser parser, CommandLine line) throws ParseException {
		result=line.getCommand();
		super.init(parser, line);
	}

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		result=result+" "+flag;
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		result=result+" "+name+":"+params;
	}
	
	public String toString()
	{
		return result;
	}

}
