package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class AddCmd extends Statement
{
	private String  symbol;
	private CExpr 	value;
	private CExpr   position;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#ADD") && params.size()>=2 && params.size()<=3) {
			this.symbol=params.get(0).getString();
			this.value=params.get(1).getExpression();
			if (params.size()==3) {
				this.position=params.get(2).getExpression();
			}
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getSymbol() {
		return symbol;
	}

	public CExpr getValue() {
		return value;
	}

	public CExpr getPosition() {
		return position;
	}

	@Override
	public String toString() {
		return "AddCmd [symbol=" + symbol + ", value=" + value + ", position="
				+ position + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		ListSymbolValue lsv = scope.getScope().get(symbol).list().values();
		if (position!=null) {
			lsv.add(SymbolValue.construct(scope.eval(value)),scope.eval(position).intValue());
		} else {
			lsv.add(SymbolValue.construct(scope.eval(value)));
		}
		return CodeResult.OK;
	}

	

}
