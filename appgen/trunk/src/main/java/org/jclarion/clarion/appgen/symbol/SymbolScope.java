package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.appgen.symbol.user.UserScopeMonitor;

public interface  SymbolScope 
{
	public SymbolEntry get(String name);
	public SymbolScope getParentScope();
	public void		   setParentScope(SymbolScope parent);
	public SymbolEntry declare(String name,String type,ValueType valueType,String... deps);
	public void 	   declareAsReference(String name,SymbolEntry entry);
	public void	 	   remove(String counter);
	public void		   pushMonitor(UserScopeMonitor barrier);
	public void		   popMonitor();
}
