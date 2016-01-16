package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class PostEmbedCmd extends Statement
{
	private CExpr text;
	private CExpr condition;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#POSTEMBED") && params.size()>=1 && params.size()<=2) {
			this.text=params.get(0).getExpression();
			if (params.size()==2) {
				this.condition=params.get(1).getExpression();
			}
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public CExpr getText() {
		return text;
	}

	public CExpr getCondition() {
		return condition;
	}

	@Override
	public String toString() {
		return "PostEmbedCmd [text=" + text + ", condition=" + condition + "]";
	}

	public CodeResult run(ExecutionEnvironment scope) {
		return CodeResult.OK;
	}	

}
