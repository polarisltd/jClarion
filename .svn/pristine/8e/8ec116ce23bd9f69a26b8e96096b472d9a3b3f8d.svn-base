package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.appgen.symbol.user.SymbolFixKey;

public abstract class SymbolStore 
{
	public abstract SymbolValue load();
	public abstract void save(SymbolValue value);
	public abstract Iterable<SymbolEntry> getDependencies();
	public abstract Iterable<SymbolValue> getAllPossibleValues();
	public abstract Iterable<SymbolFixKey> find(SymbolValue match,int limitPosition);
	public abstract int getModifyVersion();
	public abstract boolean isSystemStore();
}
