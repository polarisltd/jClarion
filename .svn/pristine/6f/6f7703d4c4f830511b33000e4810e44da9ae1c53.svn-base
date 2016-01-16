package org.jclarion.clarion.appgen.symbol.system;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolStore;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.SymbolEntryKey;

public abstract class SymbolFactory<X extends SystemSymbolScope> 
{
	private String type;
	private boolean multi;
	private String dependencies[];
	private boolean gate;

	public SymbolFactory(String type,boolean multi,boolean gate,String ...dependencies)
	{
		this.type=type;
		this.multi=multi;
		this.dependencies=dependencies;
		//this.gate=gate;
	}

	public SymbolFactory(boolean multi,String ...dependencies)
	{
		this("STRING",multi,false,dependencies);
	}

	public SymbolFactory(String type)
	{
		this(type,false,false);
	}

	public SymbolFactory()
	{
		this("STRING",false,false);
	}
	
	public boolean isGate()
	{
		return gate;
	}
	
	public abstract SymbolValue load(X scope);
	
	public SymbolEntry create(String name,final X scope)
	{
		SymbolStore store;
		if (dependencies.length==0) {
			store=new SystemStore<X>(scope,this);
		} else {
			List<SymbolEntry> se = new ArrayList<SymbolEntry>();
			for (String dep : dependencies) {
				SymbolEntry child = scope.get(dep);
				for (SymbolEntry nestedDep : child.getStore().getDependencies()) {
					se.add(nestedDep);
				}
				se.add(child);
			}
			store=scope.getDepContainer(new SymbolEntryKey(se.toArray(new SymbolEntry[se.size()]))).create(scope, this);
		}
		SymbolEntry se = SymbolEntry.create(name,type,multi ? ValueType.multi : ValueType.scalar,store);
		return se;
	}

	public boolean isMulti() {
		return multi;
	}
}
