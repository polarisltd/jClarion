package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ModuleCmd extends CodeSection
{
	private String name;
	private String description;
	private String target="Clarion";
	private String extension=".CLW";
	private boolean external;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("EXTERNAL")) {
			external=true;
			return;
		}
		
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#MODULE") && params.size()>=2 && params.size()<=4) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			if (params.size()==3) {
				this.target=params.get(2).getString();
			}
			if (params.size()==4) {
				this.extension=params.get(3).getString();
			}
			return;
		}
		throw new ParseException("Unknown:"+name);
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

	public boolean isExternal() {
		return external;
	}

	@Override
	public String toString() {
		return "ModuleCmd [name=" + name + ", description=" + description
				+ ", target=" + target + ", extension=" + extension
				+ ", external=" + external + "]";
	}

	@Override
	public String getCodeID() {
		return name;
	}


}
