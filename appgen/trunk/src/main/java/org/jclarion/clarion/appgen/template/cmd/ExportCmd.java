package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ExportCmd extends Statement
{

	private String symbol;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#EXPORT") && params.size()==1) {
			this.symbol=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown : "+name);
	}

	public String getSymbol() {
		return symbol;
	}

	@Override
	public String toString() {
		return "ExportCmd [symbol=" + symbol + "]";
	}


	
}
