package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class WithCmd extends AbstractWidgetContainer
{

	private String symbol;
	private CExpr value;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#WITH") && params.size()==2) {
			symbol=params.get(0).getString();
			value=params.get(1).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public String getSymbol() {
		return symbol;
	}

	public CExpr getValue() {
		return value;
	}

	@Override
	public String toString() {
		return "WithCmd [symbol=" + symbol + ", value=" + value + "]";
	}

	@Override
	protected String endType() {
		return "#ENDWITH";
	}
	
	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return "#WithCmd";
	}
	
	public void prime(ExecutionEnvironment scope)
	{
		ListSymbolValue se = scope.getScope().get(symbol).list().values();
		SymbolValue val = SymbolValue.construct(scope.eval(value));
		if (!se.fix(val)) {
			se.add(val);
			se.fix(val);
		}
		
		for (Widget scan : getWidgets()) {
			scan.prime(scope);
		}
	}
	
	public void declare(UserSymbolScope scope,SymbolList dependents)
	{
		SymbolList sl = new SymbolList();
		sl.add(scope.get(symbol));
		super.declare(scope,sl);
	}	
}
