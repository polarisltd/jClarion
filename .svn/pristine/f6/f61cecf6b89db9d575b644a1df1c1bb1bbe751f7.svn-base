package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class EnableCmd extends AbstractWidgetContainer
{

	private CExpr expr;
	private boolean section;
	private boolean clear;
	private boolean hide;
	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if(flag.equals("SECTION")) {
			section=true;
			return;
		}
		if(flag.equals("CLEAR")) {
			clear=true;
			return;
		}
		if(flag.equals("HIDE")) {
			hide=true;
			return;
		}
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#ENABLE") && params.size()==1) {
			expr=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getExpr() {
		return expr;
	}

	public boolean isSection() {
		return section;
	}

	public boolean isClear() {
		return clear;
	}

	public boolean isHide() {
		return hide;
	}

	@Override
	public String toString() {
		return "EnableCmd [expr=" + expr + ", section=" + section + ", clear="
				+ clear + "]";
	}

	@Override
	protected String endType() {
		return "#ENDENABLE";
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return "#EnabledCmd";
	}
	
}
