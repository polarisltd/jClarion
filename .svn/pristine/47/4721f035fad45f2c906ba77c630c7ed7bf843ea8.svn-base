package org.jclarion.clarion.appgen.template.cmd;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateChain;


public class ConcreteWidgetContainer  implements WidgetContainer, InsertAwareParent
{
	public ConcreteWidgetContainer()
	{
	}
	
	@Override
	public void addInsert(TemplateChain chain, InsertCmd insertCmd) 
	{
		InsertWidget iw = new InsertWidget(insertCmd,chain);
		widgets.add(iw);
	}

	private List<Widget> widgets=new ArrayList<Widget>();

	@Override
	public void addWidget(Widget w) {		
		widgets.add(w);
	}

	@Override
	public List<? extends Widget> getWidgets() {
		return widgets;
	}
	

	public void addAll(ConcreteWidgetContainer container) 
	{
		widgets.addAll(container.widgets);
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) 
	{
		return null;
	}
}
