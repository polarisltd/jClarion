package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class DefaultCmd extends CommandItem
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


	@Override
	public String toString() {
		return "DefaultCmd []";
	}

	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		StringBuilder builder = new StringBuilder();
		while ( true ) {
			String line = parser.getReader().readRaw();
			
			int pos = line.toUpperCase().indexOf("#ENDDEFAULT");
			while (pos>0) {
				char t=line.charAt(pos-1); 
				if (t==' ' || t=='\t') {
					pos--;
				} else {
					break;
				}
			}
			if (pos==0) {
				break;
			}
			builder.append(line).append('\n');
		}
		((ProcedureCmd)parent).setDefault(builder.toString());
	}

	
}
