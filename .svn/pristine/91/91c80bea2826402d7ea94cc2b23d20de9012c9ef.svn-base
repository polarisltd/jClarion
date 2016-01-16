package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;


public abstract class AbstractWidgetContainer extends Widget implements WidgetContainer, InsertAwareParent
{
	private ConcreteWidgetContainer container=new ConcreteWidgetContainer();
	
	@Override
	public void addInsert(TemplateChain chain, InsertCmd insertCmd) 
	{
		container.addInsert(chain,insertCmd);
	}
	@Override
	public void addWidget(Widget w) {
		container.addWidget(w);
	}

	@Override
	public List<? extends Widget> getWidgets() {
		return container.getWidgets();
	}
	
	protected abstract String endType();

	@Override
	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
		if (parser!=null) {
			while (true ) {
				TemplateItem child = parser.read();
				child.consume(parser, this);
				if (child instanceof EndCmd && ((EndCmd)child).isEnd(endType())) {
					break;
				}
			}
		}
		((WidgetContainer)parent).addWidget(this); 
	}	
}
