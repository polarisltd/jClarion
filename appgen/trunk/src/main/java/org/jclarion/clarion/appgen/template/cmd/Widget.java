package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;

public abstract class Widget extends CommandItem
{
	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
		((WidgetContainer)parent).addWidget(this); 
	}
	
	private PrepareCmd prepare;
	
	public void setPrepare(PrepareCmd prepare)
	{
		if (this.prepare!=null) {
			throw new IllegalStateException("Already Set");
		}
		this.prepare=prepare;
	}
	
	public PrepareCmd getPrepare()
	{
		return prepare;
	}

	public abstract String getLabel(ExecutionEnvironment environment);
	
	
	public void prime(ExecutionEnvironment scope)
	{
		if (this instanceof WidgetContainer) {
			for (Widget scan : ((WidgetContainer)this).getWidgets()) {
				scan.prime(scope);
			}
		}
	}
	
	public void declare(UserSymbolScope scope,SymbolList dependents)
	{
		if (this instanceof WidgetContainer) {
			for (Widget scan : ((WidgetContainer)this).getWidgets()) {
				scan.declare(scope,dependents);
			}
		}
	}
}
