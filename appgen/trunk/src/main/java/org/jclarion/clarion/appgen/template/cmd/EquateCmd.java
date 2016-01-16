package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class EquateCmd extends Statement
{
	private String key;
	private CExpr value;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#EQUATE") && params.size()==2) {
			key=params.get(0).getString();
			value=params.get(1).getExpression();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getKey() {
		return key;
	}

	public CExpr getValue() {
		return value;
	}

	@Override
	public String toString() {
		return "EquateCmd [key=" + key + ", value=" + value + "]";
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		scope.getScope().declare(key,"STRING",ValueType.scalar).scalar().setValue(SymbolValue.construct(scope.eval(value)));
		return CodeResult.OK;
	}
	
}
