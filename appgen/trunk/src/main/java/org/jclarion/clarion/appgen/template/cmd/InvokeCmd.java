package org.jclarion.clarion.appgen.template.cmd;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

public class InvokeCmd extends Statement
{

	private String returnVal;
	private boolean noIndent;
	private String  symbol;
	private List<CExpr> params=new ArrayList<CExpr>();
	private int indent;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.startsWith("%")) {
			returnVal=flag;
			return;
		}
		if (flag.equals("NOINDENT")) {
			noIndent=true;
		}
		throw new ParseException("Unknown");
	}

	
	
	@Override
	protected void initCommand(TemplateParser parser, CommandLine line, Lexer l) throws ParseException {
		
		if (l.next().type!=LexType.lparam) throw new ParseException("Expected (");
		while (l.lookahead().type!=LexType.label) {
			throw new ParseException("Expected symbol. Got:"+l.lookahead());
		}
		symbol=l.next().value;
		Parser p = new Parser(l);
		while (l.lookahead(0).type==LexType.param) {
			l.next();
			params.add(p.expr(null));
		}
		
		if (l.next().type!=LexType.rparam) throw new ParseException("Expected )");
	}



	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown");
	}



	public Object getReturnVal() {
		return returnVal;
	}



	public boolean isNoIndent() {
		return noIndent;
	}


	public List<CExpr> getParams() {
		return params;
	}

	@Override
	public String toString() {
		return "CallCmd [returnVal=" + returnVal + ", noIndent=" + noIndent
				+ ", symbol=" + symbol + ", params=" + params
				+ "]";
	}
	

	@Override
	public void noteIndent(int indent)
	{
		this.indent=indent;
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) 
	{
		String result  = scope.getScope().get(symbol).getValue().getString();
		TemplateID group = getTemplateID(result);
		
		int oldIndent = scope.getIndent();
		scope.setIndent(noIndent ? oldIndent : oldIndent+indent);
		scope.run(group,params,returnVal,false);
		scope.setIndent(oldIndent);
		return CodeResult.OK;
	}	
}
