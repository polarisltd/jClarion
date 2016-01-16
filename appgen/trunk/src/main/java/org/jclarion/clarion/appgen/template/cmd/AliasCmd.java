package org.jclarion.clarion.appgen.template.cmd;
import java.util.List;

import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

/** 
 * Do not understand what alias does at all.
 * 
 * @author barney
 *
 */
public class AliasCmd extends Statement
{
	private String newsymbol;
	private String oldsymbol;
	private String instance;
	private boolean error=false; 

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if ((name.equals("#ALIAS") || name.equals("#TRYALIAS")) && params.size()>=2 && params.size()<=3) {
			newsymbol=params.get(0).getString();
			newsymbol=params.get(1).getString();
			if (params.size()==3) {
				instance=params.get(2).getString();
			}
			error=name.equals("#ALIAS");
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	public String getNewsymbol() {
		return newsymbol;
	}

	public String getOldsymbol() {
		return oldsymbol;
	}

	public String getInstance() {
		return instance;
	}

	public boolean isError() {
		return error;
	}

	@Override
	public String toString() {
		return "AliasCmd [newsymbol=" + newsymbol + ", oldsymbol=" + oldsymbol
				+ ", instance=" + instance + ", error=" + error + "]";
	}

	
}
