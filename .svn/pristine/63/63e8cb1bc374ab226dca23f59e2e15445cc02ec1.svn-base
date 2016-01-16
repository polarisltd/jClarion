package org.jclarion.clarion.appgen.symbol;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.user.UserScopeMonitor;

public class JoinedSymbolScope implements SymbolScope
{
	private SymbolScope parent;
	private Map<String,SymbolEntry> entries =new HashMap<String,SymbolEntry>();
	private SymbolScope sibling;
	
	public JoinedSymbolScope(SymbolScope sibling)
	{
		this.sibling=sibling;
	}

	@Override
	public SymbolEntry get(String name) 
	{
		String lc_name = name.toLowerCase();
		SymbolEntry se = entries.get(lc_name);
		if (se!=null) return se;
		
		se = sibling.get(name);
		if (se==null && parent!=null) se = parent.get(name);
		if (se==null) return null;
		entries.put(lc_name,se);
		return se;
	}

	@Override
	public SymbolScope getParentScope() {
		return parent;
	}

	@Override
	public void setParentScope(SymbolScope parent) 
	{
		this.parent=parent;
	}

	@Override
	public SymbolEntry declare(String name, String type, ValueType valueType,String... deps) 
	{
		entries.remove(name.toLowerCase());
		return sibling.declare(name,type,valueType,deps);
	}

	@Override
	public void declareAsReference(String name, SymbolEntry entry) 
	{
		entries.remove(name.toLowerCase());
		sibling.declareAsReference(name,entry);
	}

	@Override
	public void remove(String counter) {
		entries.remove(counter.toLowerCase());
		sibling.remove(counter);
	}

	@Override
	public String toString() {
		return "JoinedSymbolScope: "+sibling;
	}

	@Override
	public void pushMonitor(UserScopeMonitor barrier) {
		throw new IllegalStateException("Not implemented");
	}

	@Override
	public void popMonitor() {
		throw new IllegalStateException("Not implemented");
	}
}
