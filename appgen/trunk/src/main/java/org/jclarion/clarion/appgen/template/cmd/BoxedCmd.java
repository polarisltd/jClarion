package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class BoxedCmd extends AbstractWidgetContainer
{

	private String description;
	private AtParam at;
	private CExpr where;
	private boolean clear;
	private boolean hide;
	private boolean section;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("CLEAR")) {
			clear=true;
			return;
		}
		if (flag.equals("HIDE")) {
			hide=true;
			return;
		}
		if (flag.equals("SECTION")) {
			section=true;
			return;
		}
		throw new ParseException("Unknown "+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("HLP")) return;
		if (name.equals("AT")) {
			at=new AtParam(params);
			return;
		}
		if (name.equals("WHERE") && params.size()==1) {
			where=params.get(0).getExpression();
			return;
		}
		if (name.equals("#BOXED") && params.size()==1) {
			this.description=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getDescription() {
		return description;
	}

	public AtParam getAt() {
		return at;
	}
	
	public CExpr getWhere()
	{
		return where;
	}
	
	

	public boolean isClear() {
		return clear;
	}

	public boolean isHide() {
		return hide;
	}

	public boolean isSection() {
		return section;
	}

	@Override
	public String toString() {
		return "BoxedCmd [description=" + description + ", at=" + at + "]";
	}

	@Override
	protected String endType() {
		return "#ENDBOXED";
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) 
	{
		return description; 
	}

	
}
