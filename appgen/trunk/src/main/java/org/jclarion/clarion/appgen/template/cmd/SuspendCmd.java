package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class SuspendCmd extends Statement
{

	
	private String section;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#SUSPEND") && params.size()==0) {
			return;
		}
		if (name.equals("#SUSPEND") && params.size()==1) {
			section=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown:"+name);		
	}

	public String getSection() {
		return section;
	}

	@Override
	public String toString() {
		return "SuspendCmd [section=" + section + "]";
	}


	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.suspend(section);
		return CodeResult.OK;
	}

	
}
