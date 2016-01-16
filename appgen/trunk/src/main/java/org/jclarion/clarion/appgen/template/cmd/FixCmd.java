package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
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
public class FixCmd extends Statement
{
	private String key;
	private CExpr fix;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#FIX") && params.size()==2) {
			key=params.get(0).getString();
			fix=params.get(1).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getKey() {
		return key;
	}

	public CExpr getFix() {
		return fix;
	}

	@Override
	public String toString() {
		return "FixCmd [key=" + key + ", fix=" + fix + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		SymbolEntry entry = scope.getScope().get(key);
		SymbolValue sv = SymbolValue.construct(scope.eval(fix));
		entry.list().values().fix(sv);
		return CodeResult.OK;
	}

	@Override
	public CodeResult debug(ExecutionEnvironment scope) {
		SymbolEntry entry = scope.getScope().get(key);
		ClarionObject co = scope.eval(fix);
		debug(key+" = "+co);
		entry.list().values().fix(SymbolValue.construct(co));
		return CodeResult.OK;
	}
}

