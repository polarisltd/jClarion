package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ElseCmd extends CommandItem
{

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#ELSE") && params.size()==0) {
			return;
		}
		throw new ParseException("Unknown");
	}


	@Override
	public String toString() {
		return "ElseCmd[]";
	}

	
}
