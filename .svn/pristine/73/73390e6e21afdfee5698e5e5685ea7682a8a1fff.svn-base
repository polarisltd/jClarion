package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class TabCmd extends AbstractWidgetContainer
{

	private String description;
	private CExpr where;
	private CExpr finish;
	private AtParam at;
	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("#TAB") && params.size()==1) {
			this.description=params.get(0).getString();
			return;
		}
		if (name.equals("WHERE") && params.size()==1) {
			this.where=params.get(0).getExpression();
			return;
		}
		if (name.equals("FINISH") && params.size()==1) {
			this.finish=params.get(0).getExpression();
			return;
		}
		if (name.equals("AT")) {
			at=new AtParam(params);
			return;
		}
		throw new ParseException("Unknown");
	}
	
	public CExpr getWhere()
	{
		return where;
	}

	public AtParam getAt()
	{
		return at;
	}
	
	public CExpr getFinish()
	{
		return finish;
	}

	public String getDescription() {
		return description;
	}

	@Override
	public String toString() {
		return "TabCmd [description=" + description + "]";
	}

	
	@Override
	protected String endType() {
		return "#ENDTAB";
	}

	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		if (parent instanceof SheetCmd) {
			super.execute(parser, parent);
			return;
		}
		if (parent instanceof SystemCmd) {
			super.execute(parser, parent);
			return;
			
		}
		if (parent instanceof CodeSection) {
			super.execute(parser, parent);
			return;
			
		}
		parser.getReader().error("Tab can only appear in sheet or system");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TabCmd> getWidgets() {
		return (List<TabCmd>) super.getWidgets();
	}		

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return description;
	}
	
	
}
