package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * See comments on FindCmd
 * 
 * @author barney
 *
 */
public class GenerateCmd extends Statement
{
	private String section;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#GENERATE") && params.size()==1) {
			section=params.get(0).getString();
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getSection() {
		return section;
	}

	@Override
	public String toString() {
		return "GenerateCmd [section=" + section + "]";
	}


	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		AtSource source=null;
		if (section.equalsIgnoreCase("%program")) {
			source = scope.getApp().getProgram();
		}
		if (section.equalsIgnoreCase("%procedure")) {
			Module m = scope.getApp().getModule(scope.getScope().get("%module").getFix());
			source = m.getProcedure(scope.getScope().get("%procedure").getFix());
		}
		if (section.equalsIgnoreCase("%module")) {
			source = scope.getApp().getModule(scope.getScope().get("%module").getFix());
		}
		
		if (source==null) {
			throw new IllegalStateException("failed to find:"+section);
		}
		
		scope.generate(source);
		return CodeResult.OK;
	}		
}

