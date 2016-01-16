package org.jclarion.clarion.appgen.symbol.system;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.ROSymbolScope;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.user.SymbolEntryKey;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;

/**
 * Class is used to help manufacture scopes that feed off system data stores. i.e.:
 *   Application
 *   Dictionary
 *   Procedure
 *   Window/Report
 * 
 * 
 * @author barney
 * 
 */
public abstract class SystemSymbolScope extends ROSymbolScope
{
	
	private Map<String,SymbolEntry> vars = new HashMap<String,SymbolEntry>();
	private Map<String,SymbolFactory<?extends SystemSymbolScope>> factory = new HashMap<String,SymbolFactory<? extends SystemSymbolScope>>();
	private SymbolScope parent;
	
	private Map<SymbolEntryKey,SystemDepContainer> depStore = new HashMap<SymbolEntryKey,SystemDepContainer>();
	private ExecutionEnvironment environment; 

	public SystemSymbolScope(Map<String,SymbolFactory<? extends SystemSymbolScope>> factory,ExecutionEnvironment environment)
	{
		this.factory=factory;
		this.environment=environment;
	}
	
	public ExecutionEnvironment env()
	{
		return environment;
	}
	
	public <X> X alt(X base)
	{
		if (environment==null) return base;
		if (base==null) return null;
		return environment.getAlternative(base);
	}
	
	public void recycle()
	{
		for (SystemDepContainer scan : depStore.values()) {
			scan.recycle();
		}		
		for (SymbolEntry se : vars.values()) {
			se.alertDependentsOfFixChange();
			if (se.getStore() instanceof SystemFactoryStore) {
				((SystemFactoryStore<?>)se.getStore()).recycle();
			}
		}
	}
	
	public SystemDepContainer getDepContainer(SymbolEntryKey key) {
		SystemDepContainer result = depStore.get(key);
		if (result==null) {
			result=new SystemDepContainer(key);
			depStore.put(key,result);
		}
		return result;
	}
	
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public SymbolEntry get(String name) 
	{
		String l_name=name.toLowerCase();
		SymbolEntry se = vars.get(l_name);
		if (se==null) {
			SymbolFactory f = factory.get(l_name);
			if (f==null) {
				if (parent!=null) {
					se = parent.get(name);
				}
			} else {
				se=f.create(name,this);
			}
			if (se!=null) {
				vars.put(l_name,se);
			}
		}
		return se;
	}

	@Override
	public SymbolScope getParentScope() {
		return parent;
	}

	@Override
	public void setParentScope(SymbolScope parent) {
		this.parent=parent;
	}

}
