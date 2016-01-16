package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ClearCmd extends Statement
{
	private String key;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#CLEAR") && params.size()==1) {
			key=params.get(0).getString();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getKey() {
		return key;
	}

	@Override
	public String toString() {
		return "ClearCmd [key=" + key + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.getScope().get(key).clear();
		return CodeResult.OK;
	}			
		
}
