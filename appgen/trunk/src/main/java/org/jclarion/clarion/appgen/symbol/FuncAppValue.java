package org.jclarion.clarion.appgen.symbol;

import java.util.List;

public class FuncAppValue extends ArrayListSymbolValue
{
	private String name;

	public FuncAppValue(String name,List<SymbolValue> params) {
		this.name=name;
		for (SymbolValue sv : params ) {
			add(sv);
		}
	}
	
	public String getFunctionName()
	{
		return name;
	}	
}
