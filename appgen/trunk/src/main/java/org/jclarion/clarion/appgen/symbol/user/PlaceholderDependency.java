package org.jclarion.clarion.appgen.symbol.user;

import java.util.HashMap;
import java.util.Map.Entry;

import org.jclarion.clarion.appgen.symbol.IndependentStore;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;

public class PlaceholderDependency extends MultiSymbolEntry
{
	private int varCount;
	private HashMap<String,SimpleValueList> map;


	public PlaceholderDependency(String name, String type) 
	{
		super(name, type,ValueType.multi,new IndependentStore());
	}
	
	public PlaceholderDependency(String name, String type,PlaceholderDependency dependent) 
	{
		super(name, type,ValueType.multi,new PlaceholderStore(dependent));
	}

	public PlaceholderDependency(PlaceholderDependency base)
	{
		super(base.getName(),base.getType(),ValueType.multi,((IndependentStore)base.getStore()).clone());
		cloneDepSymbols(base);
	}


	public PlaceholderDependency(PlaceholderDependency base,PlaceholderDependency newParent)
	{
		super(base.getName(),base.getType(),ValueType.multi,new PlaceholderStore((PlaceholderStore)base.getStore(),newParent));
		cloneDepSymbols(base);
	}
	
	private void cloneDepSymbols(PlaceholderDependency base) {
		this.varCount=base.varCount;
		if (base.map!=null) {
			map=new HashMap<String,SimpleValueList>();
			for (Entry<String, SimpleValueList> me : base.map.entrySet()) {
				map.put(me.getKey(),new SimpleValueList(me.getValue()));
			}
		}		
	}
	
	
	public int getDepSlot()
	{
		return varCount++;
	}
	
	
	public SymbolValue get(int ofs)
	{
		if (map==null) return null;
		String key = getFix();
		if (key==null) return null;
		SimpleValueList svl = map.get(key);
		if (svl==null) return null;
		return svl.get(ofs);
	}
	
	public void set(int ofs,SymbolValue value)
	{
		String key = getFix();
		if (key==null) {
			throw new IllegalStateException("No good");
		}

		if (map==null) {
			map=new HashMap<String,SimpleValueList>();
		}
		SimpleValueList svl = map.get(key);
		if (svl==null) {
			svl = new SimpleValueList();
			map.put(key,svl);
		}
		svl.set(ofs, varCount, value);
	}

	public int getModifyVersion() {
		return getFixCounter();
	}
}
