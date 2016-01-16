package org.jclarion.clarion.appgen.template.cmd;

import java.util.List;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

/**
 * SV Proprietory. Not documented. Nothing we need I suspect; seems to have something to do with sourcing DLL that contains template generator
 * 
 * @author barney
 */
public class ServiceCmd extends Statement
{
	private String key=""; 
	
	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("RETAIN")) {
			//retain=true;
			return;
		}
		throw new ParseException("Unknown "+flag);
	}
	
	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#SERVICE")) {
			for (Parameter p : params) {
				key=key+ (key.length()>0 ? "#" : "") + p.getString();
			}
			return;
		}
		
		throw new ParseException("Unknown "+name);
	}


	@Override
	public String toString() {
		return "ServiceCmd";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		CodeResult cr=scope.getService(key).run(scope);
		return cr;
	}

	
}
