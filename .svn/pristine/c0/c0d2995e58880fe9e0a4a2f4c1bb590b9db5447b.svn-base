package org.jclarion.clarion.appgen.template.cmd;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * This is quite confusing; what a section is.  It seems to emit code to a temp file which is then reinserted later.  Presumably this is a good thing
 * because it allows embed order to differ from how code is laid out.  (i.e. procedure routine embed at bottom of embed list even though the embed appears in upper code)
 * 
 * One confusing thing: #AT block can occur within a section. What does this even mean when this happens? Is it just convenience and these should fall through?
 * 
 * @author barney
 *
 */
public class SectionCmd extends Statement implements StatementBlock
{
	private String name;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#SECTION") && params.size()==0) {
			return;
		}
		if (name.equals("#SECTION") && params.size()==1) {
			name=params.get(0).getString();
			return;
		}
		throw new ParseException("Unknown:"+name);
	}

	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return "SectionCmd [name=" + name + "]";
	}

	private List<Statement> code=new ArrayList<Statement>();

	@Override
	public void addStatement(Statement stmt) {
		code.add(stmt);
	}

	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException 
	{
		while ( true ) {
			TemplateItem ti = parser.read();
			ti.consume(parser, parent);
			
			if (ti instanceof EndCmd && ((EndCmd)ti).isEnd("#ENDSECTION")) {
				break;
			}
		}
		((StatementBlock)parent).addStatement(this);
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return scope.runBlock(code);
	}

}
