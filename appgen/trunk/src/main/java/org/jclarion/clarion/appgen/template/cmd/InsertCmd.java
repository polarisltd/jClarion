package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

/**
 * Is a special case type of command.  In statement context (where parent is a statement block), it will behave exactly the same as #CALL
 * 
 * In all other contexts, it will register with the current CodeSection.  Once a #GROUP is presented that matches the group, the system will 
 * call execute on all children of that group.
 * 
 * @author barney
 *
 */
public class InsertCmd extends Statement
{

	private String returnVal;
	private boolean noIndent;
	private TemplateID group;
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
			return;
		}
		throw new ParseException("Unknown");
	}

	
	
	@Override
	protected void initCommand(TemplateParser parser, CommandLine line, Lexer l) throws ParseException {
		
		group=getTemplateID(l,true,false);
		
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



	public TemplateID getGroup() {
		return group;
	}



	public List<CExpr> getParams() {
		return params;
	}

	@Override
	public String toString() {
		return "InsertCmd [returnVal=" + returnVal + ", noIndent=" + noIndent
				+ ", group=" + group + ", params=" + params
				+ "]";
	}
	
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		
		if (parent instanceof InsertAwareParent) {
			if (group.getChain()==null) {
				group.setChain(parser.getFamily());
			}
			((InsertAwareParent)parent).addInsert(parser.getChain(),this);
		} else {		
			((StatementBlock)parent).addStatement(this);
		}
	}

	@Override
	public void noteIndent(int indent)
	{
		this.indent=indent;
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		int oldIndent = scope.getIndent();
		scope.setIndent(noIndent ? oldIndent : oldIndent+indent);
		scope.run(group,params,returnVal,true);
		scope.setIndent(oldIndent);

		return CodeResult.OK;
	}
	
	
	
}
