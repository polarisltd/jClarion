package org.jclarion.clarion.appgen.loader;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.symbol.DefinitionObject;
import org.jclarion.clarion.appgen.symbol.DefinitionSymbolValue;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class Definition implements Iterable<DefinitionProperty> 
{
	private String name;
	private String whitespace;
	private int indent;
	
	private DefinitionProperty type;
	private Map<String,DefinitionProperty> props=new LinkedHashMap<String,DefinitionProperty>();
	private List<DefinitionProperty> flatProps=new ArrayList<DefinitionProperty>();
	
	private Definition parent;
	
	@SuppressWarnings("unused")
	private Definition prevSibling;
	private Definition nextSibling;
	
	private Definition firstChild;
	private Definition lastChild;
	
	
	public Definition(Definition base)
	{
		this.name=base.name;
		this.whitespace=base.whitespace;
		this.indent=base.indent;
		this.comment=base.comment;
		if (base.type!=null) {
			this.type=new DefinitionProperty(base.type);
		}
		
		for (DefinitionProperty d : base.flatProps) {
			d=new DefinitionProperty(d);
			this.props.put(d.getName().toUpperCase(),d);			
			this.flatProps.add(d);
		}
	}
	
	public Definition(String name,String whitespace)
	{
		this.name=name;
		this.whitespace=whitespace;
	}
	
	private static final String PAD="                                                          ";
	
	public void setPadding(int len)
	{
		whitespace=PAD.substring(0,len-name.length());
	}
	
	public int getIndent()
	{
		return indent;
	}
	
	public void setIndent(int indent)
	{
		this.indent=indent;
	}
	
	public void add(DefinitionProperty prop)
	{
		if (type==null) {
			type=prop;
		} else {
			this.props.put(prop.getName().toUpperCase(),prop);			
			this.flatProps.add(prop);
		}
	}
	
	public String getName()
	{
		return name;
	}
	
	public void setName(String newName)
	{
		this.name=newName;
	}

	public DefinitionProperty getProperty(String name)
	{
		return this.props.get(name.toUpperCase());
	}
	
	public Collection<DefinitionProperty> getProperties()
	{
		return props.values();
	}
	
	public Definition getParent()
	{
		return parent;
	}
	
	public void addItem(Definition child)
	{
		child.parent=this;
		if (lastChild==null) {
			lastChild=child;
			firstChild=child;
		} else {
			lastChild.nextSibling=child;
			child.prevSibling=lastChild;
			lastChild=child;
		}
	}
	
	public Iterable<Definition> getAll()
	{
		return new Iterable<Definition>() {
			@Override
			public Iterator<Definition> iterator() {
				return new DeepScan(Definition.this);
			}			
		};
	}

	public Iterable<Definition> getChildren()
	{
		return new Iterable<Definition>() {
			@Override
			public Iterator<Definition> iterator() {
				return new ChildScan(firstChild);
			}			
		};
	}

	private static class DeepScan implements Iterator<Definition>
	{
		private Definition base;
		private Definition next;
		private boolean consumed;

		public DeepScan(Definition base)
		{
			this.base=base;
			this.next=base;
			consumed=false;
		}
		
		@Override
		public boolean hasNext() {
			if (!consumed) return true;
			
			if (next==null) return false;
			if (next.firstChild!=null) {
				next=next.firstChild;
				consumed=false;
				return true;	
			}
			
			while ( next!=null ) {
				if (next.nextSibling!=null) {
					next=next.nextSibling;
					consumed=false;
					return true;	
				}
				if (next==base) return false;
				next=next.parent;
			}
			return false;
		}

		@Override
		public Definition next() {
			if (!hasNext()) throw new IllegalStateException("Exhausted");
			consumed=true;
			return next;
		}

		@Override
		public void remove() {
		}
	}
	
	
	private static class ChildScan implements Iterator<Definition>
	{
		private Definition 	next;
		private boolean		consumed;

		public ChildScan(Definition child)
		{
			this.next=child;
			consumed=false;
		}
		
		@Override
		public boolean hasNext() {
			if (next==null) return false;
			if (!consumed) return true;
			next=next.nextSibling;
			consumed=next==null;
			return next!=null;
		}

		@Override
		public Definition next() {
			if (consumed) {
				if (!hasNext()) throw new IllegalStateException("Exhausted");
			}
			consumed=true;
			return next;
		}

		@Override
		public void remove() {
		}
	}



	@Override
	public String toString() {
		return name+" "+type+","+flatProps;
	}

	public String getTypeName() {
		return type.getName();
	}

	public DefinitionProperty getTypeProperty() {
		return type;
	}	

	/*
	public Collection<String> getParameterNames()
	{
		return this.props.keySet();
	}
	*/

	public DefinitionProperty get(int ofs)
	{
		return flatProps.get(ofs);
	}

	private int defUseID;
	
	public void setDefUseID(int def)
	{
		defUseID=def;
	}
	
	public String getUse() {
		if (defUseID>0) {
			return "?"+getTypeName()+defUseID;
		}
		DefinitionProperty use = getProperty("use");	
		if (use==null) return null;
		String result = use.getProp(use.getPropCount()-1).value;
		if (!result.startsWith("?")) {
			result="?"+result.replace("[","_").replace("]","");
		}
		return  result;
	}

	public int size() {
		return props.size();
	}
	
	public Definition getStatement()
	{
		Definition d = new Definition(null,null);
		d.type=type;
		d.indent=indent;
		
		// copy params across, but not # ones
		
		for (DefinitionProperty prop : getProperties()) {
			if (prop.getName().startsWith("#")) continue;
			d.add(prop);
		}
		
		return d;
	}

	
	private String render=null;
	private String comment;
	
	private static class MuteInt
	{
		private int val;
		
		private MuteInt(int val)
		{
			this.val=val;
		}
	}
	
	public String render()
	{
		if (render==null) {
			
			MuteInt len_limit=new MuteInt(87);
			
			//System.out.println(renderUnsplit());
			
			StringBuilder render=new StringBuilder();
			if (name!=null) {
				render.append(name);
			}
			if (whitespace!=null) {
				render.append(whitespace);
			}
			MuteInt start=new MuteInt(render.length());			
			if (type!=null) {
				//render.append(type.render());
				renderSplitProp(render,type,start,len_limit);
			}

			
			for (DefinitionProperty prop : flatProps) {
				render.append(',');
				if (render.length()-start.val>=len_limit.val+3) {
					if (len_limit.val==87) {
						len_limit.val=85;
					}
					render.append(" |\n  ");
					start.val=render.length();
				}
				
				renderSplitProp(render,prop,start,len_limit);				
			}
			this.render=render.toString();
		}
		return render;
	}
	
	private void renderSplitProp(StringBuilder target,DefinitionProperty prop,MuteInt offset,MuteInt initLength)
	{
		int nextlength=initLength.val-2;
		if (nextlength<85) {
			nextlength=85;
		}
		target.append(prop.getName());
		if (prop.getParams().isEmpty()) {
			if (prop.getName().equals("PRE")) {
				target.append("()");
			}
			return;
		}
		target.append('(');
		
		boolean first=true;
		for (Lex l : prop.getParams()) {
			if (!first) {
				target.append(',');
				if (target.length()-offset.val>=90) {
					target.append(" |\n  ");
					offset.val=target.length();
					initLength.val=nextlength;
				}
			}
			
			if (l==null) {
				first=false;
				continue;
			}
			if (l.type==LexType.string) {
				try {
					if (first) {
						String content = SourceEncoder.encodeString(l.value);
						
						if (content.length()<22) {
							target.append(content);
						} else {
							int start=0;
							int remain=content.length();	
							
							while (remain>0) {
								
								int t=initLength.val;
								
								t=t-target.length()+offset.val;
								if (t<=10) t=11;
								if (remain-t<=10) {
									t=remain;
								}
								
								target.append(content,start,start+t);
								start=start+t;
								remain=remain-t;
								if (remain>0) {
									target.append("' & |\n  '");
									offset.val=target.length()-1;
									initLength.val=nextlength;
								}
							}
						}
					} else {
						SourceEncoder.encodeString(l.value, target,true);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}				
			} else {
				target.append(l.value);
			}
			first=false;
		}
		target.append(')');
	}
	
	public String renderUnsplit() {
		StringBuilder render=new StringBuilder();
		if (name!=null) {
			render.append(name);
		}
		if (whitespace!=null) {
			render.append(whitespace);
		}
		if (type!=null) {
			render.append(type.render());
		}
		for (DefinitionProperty prop : flatProps) {
			render.append(',');
			render.append(prop.render());
		}
		return render.toString();
	}
	
	
	@Override
	public Iterator<DefinitionProperty> iterator() {
		return flatProps.iterator();
	}

	public Definition extract(String string) {
		Definition d = new Definition(name,whitespace);
		DefinitionProperty p = getProperty(string);
		if (p!=null) {
			d.add(p);
		}
		return d;
	}
	
	public DefinitionProperty delete(String name)
	{
		DefinitionProperty p = props.remove(name.toUpperCase());
		if (p!=null) {
			flatProps.remove(p);
		}
		return p;
	}
	
	public Definition split(Set<String> items) {
		Definition extracted=null;
		Iterator<DefinitionProperty> scan = flatProps.iterator();
		while (scan.hasNext()) {
			DefinitionProperty prop = scan.next();
			if (items.contains(prop.getName().toUpperCase())) {
				scan.remove();
				if (extracted==null) {
					extracted=new Definition(null,null);
				}
				extracted.add(prop);
			}
		}
		return extracted;
	}
	
	
	public Definition remove(String string) {
		Definition d = new Definition(name,whitespace);
		d.type=type;
		for (DefinitionProperty p : flatProps) {
			if (p.getName().equalsIgnoreCase(string)) continue;
			d.add(p);
		}
		return d;
	}	

	
	
	public Definition extractGUI()
	{
		Definition d = new Definition(null,null);
		Iterator<DefinitionProperty> prop = flatProps.iterator();
		while (prop.hasNext()) {
			DefinitionProperty dp = prop.next();
			if (dp.getName().equalsIgnoreCase("GUID") || d.type!=null) {
				d.add(dp);
				prop.remove();
				this.props.remove(dp.getName().toUpperCase());
			}
		}
		return d;
	}
	
	public DefinitionObject asClarionObject()
	{
		return new DefinitionObject(this);
	}

	public DefinitionSymbolValue asSymbolValue()
	{
		return new DefinitionSymbolValue(this);
	}

	public String getValue(String string) 
	{
		DefinitionProperty prop = getProperty(string);
		if (prop==null) {
			return "";
		} 
		return prop.renderPart();
	}

	public String getWhitespace() {
		return whitespace;
	}

	public void setComment(String value) {
		this.comment=value;
	}
	
	public String getComment()
	{
		return comment;
	}


}
