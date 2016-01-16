package org.jclarion.clarion.appgen.symbol.system;

import java.util.HashMap;
import java.util.Map;

public class FactoryBuilder<X extends SystemSymbolScope> {

	private Map<String,SymbolFactory<X>> factory=new HashMap<String,SymbolFactory<X>>(); 
	
	public FactoryBuilder<X> add(String name,SymbolFactory<X> factory) 
	{
		this.factory.put(name.toLowerCase(),factory);
		return this;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String,SymbolFactory<? extends SystemSymbolScope>> get()
	{
		Map erased=factory;
		return (Map<String,SymbolFactory<? extends SystemSymbolScope>>)erased;
	}
}
