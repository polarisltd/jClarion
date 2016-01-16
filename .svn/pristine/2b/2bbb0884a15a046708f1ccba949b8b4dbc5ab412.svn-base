package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.CommandLine;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.TemplateParser;
import org.jclarion.clarion.runtime.expr.ParseException;

public class FlowControlCmd extends Statement
{
	private CodeResult result;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);		
	}
	
	@Override
	public void init(TemplateParser parser, CommandLine line) throws ParseException 
	{
		super.init(parser, line);
		String cmd = line.getCommand().toLowerCase();
		if (cmd.equals("break")) {
			result=CodeResult.BREAK;
			return;
		}
		if (cmd.equals("cycle")) {
			result=CodeResult.CYCLE;
			return;
		}
		if (cmd.equals("accept")) {
			result=CodeResult.ACCEPT;
			return;
		}
		if (cmd.equals("reject")) {
			result=CodeResult.REJECT;
			return;
		}
		throw new ParseException("Unknown flow control cmd:"+cmd);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		throw new ParseException("Unknown:"+name);
	}
	
	@Override
	public String toString() {
		return "FlowControl:"+result;
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return result;
	}
}
