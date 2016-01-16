package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class SheetCmd extends AbstractWidgetContainer
{
	private boolean hscroll;
	private boolean adjust;

	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("HSCROLL")) {
			hscroll=true;
			return;
		}
		if (flag.equals("ADJUST")) {
			adjust=true;
			return;
		}
		throw new ParseException("Unknown: "+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown: "+name);
	}
	
	

	public boolean isHscroll() {
		return hscroll;
	}

	public boolean isAdjust() {
		return adjust;
	}

	@Override
	public String toString() {
		return "SheetCmd";
	}
	
	@Override
	protected String endType() {
		return "#ENDSHEET";
	}	
	
	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return "#SheetCmd";
	}	
}
