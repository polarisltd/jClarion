package org.jclarion.clarion.appgen.template.cmd;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ConstExpr;
import org.jclarion.clarion.runtime.expr.ParseException;

public class ImageCmd extends Widget
{

	private String image;
	private AtParam at;
	private Map<String,CExpr> prop=new HashMap<String,CExpr>();

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown");
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#IMAGE") && params.size()==1) {
			this.image=params.get(0).getString();
			return;
		}
		if (name.equals("AT")) {
			this.at=new AtParam(params);
			return;
		}
		if (name.equals("PROP") && params.size()==2) {
			this.prop.put(params.get(0).getString(),params.get(1).getExpression());
			return;
		}
		if (name.equals("PROP") && params.size()==1) {
			this.prop.put(params.get(0).getString(),new ConstExpr(new ClarionBool(true)));
			return;
		}
		throw new ParseException("Unknown : "+name);
	}

	public String getImage() {
		return image;
	}

	public AtParam getAt() {
		return at;
	}

	public Map<String, CExpr> getProp() {
		return prop;
	}

	@Override
	public String toString() {
		return "ImageCmd [display=" + image + ", at=" + at + ", prop="
				+ prop + "]";
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return image;
	}
	
}
