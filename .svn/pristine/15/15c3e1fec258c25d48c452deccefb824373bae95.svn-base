package org.jclarion.clarion.appgen.template.cmd;
import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class PriorityCmd extends CommandItem
{

	private int priority;
	private CExpr description;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#PRIORITY") && params.size()==1) {
			this.priority=params.get(0).getInt();
			return;
		}
		
		if (name.equals("DESCRIPTION") && params.size()==1) {
			this.description=params.get(0).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public int getPriority() {
		return priority;
	}

	public CExpr getDescription() {
		return description;
	}

	@Override
	public String toString() {
		return "PriorityCmd [priority=" + priority + ", description="
				+ description + "]";
	}

	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		if (parent instanceof AtCmd) return;
		super.execute(parser, parent);
	}
}
