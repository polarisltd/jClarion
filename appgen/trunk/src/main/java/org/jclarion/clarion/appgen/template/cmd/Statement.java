package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;

import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;

public abstract class Statement extends CommandItem implements TemplateCode
{
	@Override
	protected void execute(TemplateParser parser, TemplateItem parent) throws IOException {
		((StatementBlock)parent).addStatement(this);
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		throw new IllegalStateException("Not implemented:"+this.getClass());
	}

	public CodeResult debug(ExecutionEnvironment scope) 
	{
		debug("");
		return run(scope);
	}

	public void debug(String string) {
		System.err.println(this.getSrcRef()+" "+getItemType()+" "+string);
	}
	
}
