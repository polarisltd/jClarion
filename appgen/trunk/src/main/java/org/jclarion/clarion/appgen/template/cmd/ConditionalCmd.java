package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * 
 * Abstract representation of conditionals:  IF, ELSIF, CASE, OF, OROF, etc
 * 
 * @author barney
 *
 */
public class ConditionalCmd extends Statement
{

	private String type;
	private CExpr test;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown "+flag);
	}
	
	

	@Override
	protected void initCommand(TemplateParser parser, CommandLine line, Lexer l) throws ParseException {
		type=line.getCommand();
		List<Parameter> p = popParams(l);
		if (p.size()!=1) throw new ParseException("Expected test");
		test=p.get(0).getExpression();
	}



	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown "+name);
	}

	public String getType()
	{
		return type;
	}
	
	public CExpr getTest() {
		return test;
	}

	@Override
	public String toString() {
		return "ConditionalCmd [type="+type+" test=" + test + "]";
	}

	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
		parser.getReader().error("Do not know how to add "+this.getItemType()+" to "+parent.getItemType());
	}	
	
}
