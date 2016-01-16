package org.jclarion.clarion.appgen.template;

import java.io.IOException;
import java.util.List;

import org.jclarion.clarion.appgen.template.cmd.CodeResult;
import org.jclarion.clarion.appgen.template.cmd.Statement;
import org.jclarion.clarion.runtime.expr.ParseException;

public class SourceItem extends Statement 
{
	private SourceLine line;

	public SourceItem(SourceLine line)
	{
		this.line=line;
	}
	
	public String toString()
	{
		return line.toString();
	}

	@Override
	public String getItemType() {
		return "Source";
	}

	@Override
	public void initFlag(String flag) throws ParseException {
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {		
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		if (!line.isConditional()) {
			scope.release();
		}
		
		try {			
			WriteTarget a = scope.getWriteTarget();
			
			/*
			String item = getSrcRef();
			for (int scan=item.length();scan<20;scan++) {
				a.append(' ');
			}			
			//if (getSrcFile().equalsIgnoreCase("abgroup.tpw")) {
			//	a.append(scope.getNonGroup().getSrcRef()).append(" :  ");
			//} else {
				a.append(getSrcRef()).append(" :  ");
			//}
			 */
			
			
			line.render(scope, a);
			a.append('\n');
			
			
			//scope.logStack();
			
		} catch (IOException e) {
			scope.error(e.getMessage());
		}
		return CodeResult.OK;
	}	
}
