package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class FreeCmd extends Statement
{
	private String name;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#FREE") && params.size()==1) {
			this.name=params.get(0).getString();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}


	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return "FreeCmd [name=" + name + "]";
	}


	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.getScope().get(name).list().values().free();
		return CodeResult.OK;
	}	

}
