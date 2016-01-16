package org.jclarion.clarion.appgen.template.cmd;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class DisplayCmd extends Widget
{

	private CExpr display;
	private AtParam at;
	private Map<String,String> prop=new HashMap<String,String>();

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#DISPLAY") && params.size()==0) {
			return;
		}
		if (name.equals("#DISPLAY") && params.size()==1) {
			this.display=params.get(0).getExpression();
			return;
		}
		if (name.equals("AT")) {
			this.at=new AtParam(params);
			return;
		}
		if (name.equals("PROP") && params.size()==2) {
			this.prop.put(params.get(0).getString(),params.get(1).getString());
			return;
		}
		throw new ParseException("Unknown : "+name);
	}

	public CExpr getDisplay() {
		return display;
	}

	public AtParam getAt() {
		return at;
	}

	public Map<String, String> getProp() {
		return prop;
	}

	@Override
	public String toString() {
		return "DisplayCmd [display=" + display + ", at=" + at + ", prop="
				+ prop + "]";
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return environment.eval(display).toString();
	}
	
}
