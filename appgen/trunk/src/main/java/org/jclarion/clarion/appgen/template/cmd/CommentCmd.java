package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class CommentCmd extends Statement
{
	private int value;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#COMMENT") && params.size()==1) {
			value = params.get(0).getInt();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public int getValue() {
		return value;
	}

	@Override
	public String toString() {
		return "EquateCmd [value=" + value + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.setComment(value);
		return CodeResult.OK;
	}	
	
}
