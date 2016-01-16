package org.jclarion.clarion.appgen.template.cmd;

import java.io.File;
import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class RemoveCmd extends Statement
{

	private CExpr file;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#REMOVE") && params.size()==1) {
			file=params.get(0).getExpression();
			return;
		}
		throw new ParseException("Unknown");
	}
	
	
	public CExpr getFile() {
		return file;
	}

	@Override
	public String toString() {
		return "RemoveCmd [file:"+file+"]";
	}
	
	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		String filename = scope.getTargetPath()+scope.eval(file).toString();
		File f = new File(filename);
		f.delete();		
		return CodeResult.OK;
	}
	
}
