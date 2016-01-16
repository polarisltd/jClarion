package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.ParseException;

public class UtilityCmd extends CodeSection
{

	private String description;
	private String name;
	private TemplateID procedure;
	private boolean wizard;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}
	
	

	@Override
	protected void initSetting(TemplateParser parser, String value, Lexer l) throws ParseException {
		if (value.equals("WIZARD")) {
			wizard=true;
			if (l.lookahead().type==LexType.lparam) { 
				procedure=getTemplateID(l);
			}
			return;
		}
		super.initSetting(parser, value, l);
	}



	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#UTILITY") && params.size()==2) {
			this.name=params.get(0).getString();
			this.description=params.get(1).getString();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getDescription() {
		return description;
	}

	public String getName() {
		return name;
	}

	public TemplateID getProcedure() {
		return procedure;
	}
	

	public boolean isWizard() {
		return wizard;
	}



	@Override
	public String toString() {
		return "UtilityCmd [description=" + description + ", name=" + name
				+ ", procedure=" + procedure + "]";
	}



	@Override
	public String getCodeID() {
		return name;
	}


	
	
	
}
