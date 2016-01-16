package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ReturnCmd extends Statement
{

	
	private CExpr value;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.startsWith("%")) {
			value=new LabelExpr(flag);
			return;
		}
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#RETURN") && params.size()==0) {
			return;
		}
		if (name.equals("#RETURN") && params.size()==1) {
			value=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown:"+name);		
	}

	public CExpr getValue() {
		return value;
	}

	@Override
	public String toString() {
		return "ReturnCmd [value=" + value + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return new CodeResult(CodeResult.CODE_RETURN,value!=null ? SymbolValue.construct(scope.eval(value)) : null);
	}


	
}
