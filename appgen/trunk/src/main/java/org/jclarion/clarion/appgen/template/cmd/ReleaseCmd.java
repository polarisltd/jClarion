package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ReleaseCmd extends Statement
{

	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown:"+name);		
	}


	@Override
	public String toString() {
		return "ReleaseCmd []";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.release();
		return CodeResult.OK;
	}


	
}
