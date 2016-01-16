package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class FieldCmd extends AbstractWidgetContainer
{

	private CExpr where;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#FIELD") && params.size()==0) {
			return;
		}
		if (name.equals("WHERE") && params.size()==1) {
			where=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}

	public CExpr getWhere() {
		return where;
	}

	@Override
	public String toString() {
		return "FieldCmd [where=" + where + "]";
	}

	@Override
	protected String endType() {
		return "#ENDFIELD";
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return null;
	}

	
	@Override
	public void declare(UserSymbolScope scope, SymbolList dependents) {
		dependents.add(scope.get("%control"));
		super.declare(scope, dependents);
		dependents.remove();
	}	
	
	
}
