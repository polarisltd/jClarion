package org.jclarion.clarion.appgen.symbol.user;

import java.util.ArrayList;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolStore;
import org.jclarion.clarion.appgen.symbol.SymbolValue;

public class PlaceholderStore extends SymbolStore
{
	private ArrayList<SymbolEntry> deps=new ArrayList<SymbolEntry>();
	private PlaceholderDependency store;
	private int ofs=0;
	
	public PlaceholderStore(PlaceholderDependency dep)
	{
		deps.add(dep);
		store=dep;
		ofs=store.getDepSlot();
	}

	public PlaceholderStore(PlaceholderStore base,PlaceholderDependency newParent)
	{
		deps.add(newParent);
		store=newParent;
		this.ofs=base.ofs;
	}
	
	@Override
	public SymbolValue load() 
	{
		return store.get(ofs);
	}

	@Override
	public void save(SymbolValue value) 
	{
		store.set(ofs,value);
	}

	@Override
	public Iterable<SymbolEntry> getDependencies() 
	{
		return deps;
	}

	@Override
	public Iterable<SymbolValue> getAllPossibleValues() {
		return null;
	}

	@Override
	public Iterable<SymbolFixKey> find(SymbolValue match, int limitPosition) {
		return null;
	}

	@Override
	public int getModifyVersion() {
		return store.getModifyVersion();
	}

	@Override
	public boolean isSystemStore() {
		return false;
	}


}
