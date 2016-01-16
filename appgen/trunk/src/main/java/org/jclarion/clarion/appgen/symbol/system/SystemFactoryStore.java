package org.jclarion.clarion.appgen.symbol.system;

public interface SystemFactoryStore<X extends SystemSymbolScope> {

	public SymbolFactory<X> getFactory();
	public void recycle();
}
