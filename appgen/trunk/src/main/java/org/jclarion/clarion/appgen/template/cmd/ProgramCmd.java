package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ProgramCmd extends CodeSection
{

	private String name;
	private String description;
	private String target;
	private String extension;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#PROGRAM") && params.size()==2 || params.size()==4) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			if (params.size()==4) {
				this.target=params.get(2).getString();
				this.extension=params.get(3).getString();
			}
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getName() {
		return name;
	}

	public String getDescription() {
		return description;
	}

	public String getTarget() {
		return target;
	}

	public String getExtension() {
		return extension;
	}

	@Override
	public String toString() {
		return "ProgramCmd [name=" + name + ", description=" + description
				+ ", target=" + target + ", extension=" + extension + "]";
	}
	
	public String getCodeID()
	{
		return name;
	}

	
}

