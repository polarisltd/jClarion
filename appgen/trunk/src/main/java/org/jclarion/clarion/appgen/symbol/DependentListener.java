package org.jclarion.clarion.appgen.symbol;


public interface DependentListener {
	public void alertPurge(SymbolEntry source);
	public void alertValueChange(SymbolEntry source,String from,String to);
}
