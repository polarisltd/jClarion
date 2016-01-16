package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.appgen.symbol.user.UserScopeMonitor;

public abstract class ROSymbolScope implements SymbolScope
{
	@Override
	public SymbolEntry declare(String name, String type, ValueType valueType,String... deps) 
	{
		throw new IllegalStateException("Read Only");
	}

	@Override
	public void declareAsReference(String name, SymbolEntry entry) 
	{
		throw new IllegalStateException("Read Only");
	}

	@Override
	public void remove(String name) 
	{
		throw new IllegalStateException("Read Only");
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
