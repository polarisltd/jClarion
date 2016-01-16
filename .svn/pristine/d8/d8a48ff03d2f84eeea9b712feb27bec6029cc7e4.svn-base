package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolStore;
import org.jclarion.clarion.appgen.symbol.user.DependentStore;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * TODO: implementation is not perfect. It does not traverse into variables that depend on us and purge them
 * 
 * @author barney
 *
 */
public class PurgeCmd extends Statement
{
	private String name;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#PURGE") && params.size()==1) {
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
		return "PurgeCmd [name=" + name + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		SymbolEntry se = scope.getScope().get(name);
		se.clear();
		se.alertDependentsOfPurge();
		SymbolStore ss = se.getStore();
		if (ss instanceof DependentStore) {
			((DependentStore)ss).purge();
		}
		return CodeResult.OK;
	}			
	

}
