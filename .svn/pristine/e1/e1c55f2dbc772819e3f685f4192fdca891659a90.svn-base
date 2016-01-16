package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * 
 * Unusual block of code this one. The documented behaviour is weird.  The code can emit only if the section it refers to is later released. 
 * 
 * @author barney
 *
 */
public class QueryCmd extends Statement
{
	private String section;
	private CExpr source;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#QUERY") && params.size()==2) {
			section=params.get(0).getString();
			source=params.get(1).getExpression();
			return;
			
		}
		throw new ParseException("Unknown:"+name);		
	}

	public String getSection() {
		return section;
	}

	public CExpr getSource() {
		return source;
	}

	@Override
	public String toString() {
		return "QueryCmd [section=" + section + ", source=" + source + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		int pad=scope.getIndent();
		char p[]=new char[pad];
		for (int len=0;len<pad;len++) {
			p[len]=' ';
		}
		scope.alternative(section,new String(p)+scope.eval(source).toString()+"\n");
		return CodeResult.OK;
	}
	


	
}
