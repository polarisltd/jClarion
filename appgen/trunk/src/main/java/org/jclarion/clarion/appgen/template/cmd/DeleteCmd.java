package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class DeleteCmd extends Statement
{
	private String  symbol;
	private CExpr   position;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#DELETE") && params.size()>=1 && params.size()<=2) {
			this.symbol=params.get(0).getString();
			if (params.size()==2) {
				this.position=params.get(1).getExpression();
			}
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getSymbol() {
		return symbol;
	}

	public CExpr getPosition() {
		return position;
	}

	@Override
	public String toString() {
		return "DeleteCmd [symbol=" + symbol + ", position=" + position + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {		
		if (position!=null) {
			return super.run(scope);
		}
		scope.getScope().get(symbol).list().values().delete();
		return CodeResult.OK;
	}
	
	
}
