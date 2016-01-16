package org.jclarion.clarion.appgen.template.cmd;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ConstExpr;

public class EmbedSymbol
{
	private String name;
	private CExpr description;
	private CExpr  prepare;
	private Map<String,String> params;
	private boolean literal;
	
	public EmbedSymbol(String name, boolean literal)
	{
		this.name=name;
		this.literal=literal;
	}

	public String getName() {
		return name;
	}
	
	public boolean isLiteral()
	{
		return literal;
	}

	public CExpr getDescription() {
		return description;
	}

	public CExpr getPrepare() {
		return prepare;
	}

	public String getParam(String key)
	{
		if (params==null) return null;
		return params.get(key);
	}

	public void setParam(String key,String value)
	{
		if (params==null) params=new HashMap<String,String>();
		params.put(key,value);
	}
	
	public void setDescription(CExpr description) {
		this.description = description;
	}

	public void setDescription(String description) {
		this.description = new ConstExpr(new ClarionString(description));
	}
	
	public void setPrepare(CExpr prepare) {
		this.prepare = prepare;
	}

	@Override
	public String toString() {
		return "EmbedSymbol [name=" + name + ", description=" + description
				+ ", prepare=" + prepare + ", params=" + params + "]";
	}
}