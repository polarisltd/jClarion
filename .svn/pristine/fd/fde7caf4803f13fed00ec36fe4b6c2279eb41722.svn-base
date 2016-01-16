package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class EndCmd extends CommandItem
{
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown:"+name);
	}
	
	public boolean isEnd(String type) {
		if (type.equals(getItemType()) || getItemType().equals("#END")) {
			return true;
		}
		throw new IllegalStateException("Expected "+type+" got "+getItemType());
	}
	
	@Override
	public String toString() {
		return getItemType();
	}
	
	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
	}
}
