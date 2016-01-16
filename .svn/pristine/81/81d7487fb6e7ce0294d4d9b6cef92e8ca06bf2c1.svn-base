package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.runtime.expr.ParseException;

public class InsertWidget extends Widget implements WidgetContainer  
{
	private TemplateChain chain;
	private InsertCmd insertCmd;
	private CodeSection section;
	
	public InsertWidget(InsertCmd cmd,TemplateChain chain)
	{
		this.insertCmd=cmd;
		this.chain=chain;
	}
	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException 
	{
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) 
	{
		return null;
	}

	@Override
	public void addWidget(Widget w) {
		throw new IllegalStateException("Not allowed");
	}

	@Override
	public List<? extends Widget> getWidgets() 
	{
		return getCodeSection().getWidgets();
	}
	
	public CodeSection getCodeSection()
	{
		if (section==null) {
			section = chain.getSection("#GROUP",insertCmd.getGroup());
		}
		return section;
	}

	@Override
	public void declare(UserSymbolScope scope, SymbolList dependents) 
	{
		super.declare(scope,dependents);
	}
	
	
	
}