package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class LocalDataCmd extends CommandItem implements StatementBlock
{
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown:"+name);
	}
	
	@Override
	public String toString() {
		return "LocalData";
	}

	private List<Statement> statements=new ArrayList<Statement>();
	
	@Override
	public void addStatement(Statement stmt) 
	{
		statements.add(stmt);
	}
	
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		while ( true ) {
			TemplateItem ti = parser.read();
			ti.consume(parser, this);
			
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDLOCALDATA")) {
				break;
			}
		}
		((CodeSection)parent).setLocalData(statements);
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return scope.runBlock(this.statements);
	}	
}
