package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class AppCmd extends CodeSection
{

	private String description;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#APPLICATION") && params.size()==1) {
			this.description=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getDescription() {
		return description;
	}

	@Override
	public String toString() {
		return "AppCmd [description=" + description + "]";
	}

	@Override
	public String getCodeID() {
		return "#APPLICATION";
	}

}
