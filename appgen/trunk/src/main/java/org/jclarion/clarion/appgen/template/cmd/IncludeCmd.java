package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class IncludeCmd extends CommandItem
{

	private String file;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#INCLUDE") && params.size()==1) {
			file=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown");
	}
	
	
	public String getFile() {
		return file;
	}

	@Override
	public String toString() {
		return "IncludeCmd [file:"+file+"]";
	}

	@Override
	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException 
	{
		parser.getReader().addSource(file);
	}
}
