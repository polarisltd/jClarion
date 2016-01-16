package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class RestrictCmd extends CommandItem implements StatementBlock
{

	private CExpr where;
	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("WHERE") && params.size()==1) {
			where=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown:"+name);		
	}

	public CExpr getWhere() {
		return where;
	}

	@Override
	public String toString() {
		return "RestrictCmd [where=" + where + "]";
	}

	private List<Statement> statements=new ArrayList<Statement>();
	
	@Override
	public void addStatement(Statement stmt) {
		statements.add(stmt);
	}
	
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		while ( true ) {
			TemplateItem ti = parser.read();
			ti.consume(parser, this);
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDRESTRICT")) {
				break;
			}
		}
		((CodeSection)parent).addRestriction(this);
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return scope.runBlock(statements);
	}
	
	
}
