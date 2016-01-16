package org.jclarion.clarion.appgen.template.cmd;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.Parameter;
import org.jclarion.clarion.runtime.expr.ParseException;

public class DeclareCmd extends Statement
{
	private ValueType valueType=ValueType.scalar;
	private boolean save;
	private List<String> parentSymbols=new ArrayList<String>();
	private String name;
	private String type;

	@Override
	public void initFlag(String flag) throws ParseException 
	{
		if (flag.equals("MULTI")) {
			if (valueType==ValueType.scalar) { 
				valueType=ValueType.multi;
			}
			return;
		}
		if (flag.equals("UNIQUE")) {
			valueType=ValueType.unique;
			return;
		}
		if (flag.equals("SAVE")) {
			save=true;
			return;
		}
		throw new ParseException("Unknown:"+flag);
	}

	@Override
	public void initSetting(String name, List<Parameter> params) throws ParseException {
		if (name.equals("#DECLARE") && params.size()>0) {
			this.name=params.get(0).getString();
			for (int scan=1;scan<params.size();scan++) {
				String val = params.get(scan).getString();
				if (val.startsWith("%")) {
					parentSymbols.add(val);
					continue;
				}
				if (scan==params.size()-1) {
					type=val;
					continue;
				}
				throw new ParseException("Unknown:"+val);
			}
			
			return;
		}
		
		throw new ParseException("Unknown:"+name);
	}

	@Override
	public String toString() {
		return "DeclareCmd [valueType=" + valueType + ", save=" + save
				+ ", parentSymbols=" + parentSymbols + ", name=" + name
				+ ", type=" + type + "]";
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		
		SymbolScope target=null;
		if (this.save) {
			target=scope.getPersist(); 
			if (target.get(name)!=null) return CodeResult.OK;
 		} else {
 			target=scope.getScope();
 		}
		
		if (parentSymbols.isEmpty()) {
			target.declare(name, type,valueType);
		} else {
			target.declare(name, type,valueType,parentSymbols.toArray(new String[parentSymbols.size()]));
		}
		
		return CodeResult.OK;
	}
	

}
