package org.jclarion.clarion.appgen.loader;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class DefinitionProperty 
{
	private String name;
	private List<Lex> params;
	
	public DefinitionProperty(DefinitionProperty base)
	{
		this.name=base.name;
		if (base.params!=null) {
			params=new ArrayList<Lex>();
			for (Lex l : base.params) {
				params.add(new Lex(l.type, l.value));
			}
		}
	}
	
	public DefinitionProperty(String name,List<Lex> params)
	{
		this.name=name;
		this.params=params;
	}

	public DefinitionProperty(String name,Lex... params)
	{
		this.name=name;		
		this.params=new ArrayList<Lex>();
		for (Lex l : params ) {
			this.params.add(l);
		}
	}
	
	public String getName()
	{
		return name;
	}
	
	public int getPropCount()
	{
		return params.size();
	}
	
	public Lex getProp(int ofs)
	{
		return params.get(ofs);
	}
	
	public List<Lex> getParams()
	{
		return params;
	}

	@Override
	public String toString() {
		return "[name=" + name + ", params=" + params + "]";
	}

	public SymbolValue get(int i) {
		return SymbolValue.construct(params.get(i));
	}

	public int size() {
		return params.size();
	}
	
	public String renderPart()
	{
		StringBuilder render=new StringBuilder();
		renderPart(render);
		return render.toString();
	}
	
	public String render(int pos)
	{
		Lex l = params.get(pos);
		if (l.type==LexType.string) {
			return SourceEncoder.encodeString(l.value);
		} else {
			return l.value;
		}
	}

	private String render=null;
	public String render() 
	{
		if (params.isEmpty()) return name;
		if (this.render!=null) return this.render;
		StringBuilder render=new StringBuilder();
		render.append(name).append('(');
		renderPart(render);
		render.append(')');
		this.render=render.toString();
		return this.render;
	}

	private void renderPart(StringBuilder render) {
		boolean first=true;
		for (Lex l : params ) {
			
			if (first) {
				first=false;
			} else {
				render.append(',');
			}
			if (l==null) continue;
			if (l.type==LexType.string) {
				try {
					SourceEncoder.encodeString(l.value, render,true);
				} catch (IOException e) {
					e.printStackTrace();
				}				
			} else {
				render.append(l.value);
			}
		}
	}	
}
