package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * See comments on FindCmd
 * 
 * @author barney
 *
 */
public class SelectCmd extends Statement
{
	private String key;
	private CExpr instance;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#SELECT") && params.size()==2) {
			key=params.get(0).getString();
			instance=params.get(1).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getKey() {
		return key;
	}

	public CExpr geInstance() {
		return instance;
	}

	@Override
	public String toString() {
		return "SelectCmd [key=" + key + ", instance=" + instance + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.getScope().get(key).list().values().select(scope.eval(instance).intValue());
		return CodeResult.OK;
	}			

	@Override
	public CodeResult debug(ExecutionEnvironment scope) {
		int ofs = scope.eval(instance).intValue();
		scope.getScope().get(key).list().values().select(ofs);
		debug("key = "+ofs);
		return CodeResult.OK;
	}			
	
}

