package org.jclarion.clarion.appgen.symbol.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.appgen.symbol.IndependentStore;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.ValueType;

public class  UserSymbolScope implements SymbolScope
{
	private SymbolScope parent;
	private Map<String,SymbolEntry> fields;
	private Map<String,SymbolEntry> declaredFields;
	private Map<SymbolEntryKey,DependentSymbolStore> dependentFieldBuffer;
	private String name; 
	
	
	public UserSymbolScope(String name)
	{
		this.name=name;
		fields=new LinkedHashMap<String,SymbolEntry>();
		declaredFields=new LinkedHashMap<String,SymbolEntry>();
		dependentFieldBuffer=new HashMap<SymbolEntryKey,DependentSymbolStore>();
	}
	
	public String getName()
	{
		return name;
	}
	
	/**
	 * Create a cloned symbol scope, derived from this scope but using a different
	 * parent.  This is used to take a scope loaded on the App and use it for
	 * running on app generator.  For number of reasons:
	 * 
	 * 1. substitute placeholder symbols with their real symbols derived from 
	 * the supplied parent
	 * 
	 * 2. Any changes to scope variables during template generation occur on a 
	 *    duplicated version of the scope and cannot effect the scope tracked on
	 *    the App entity.  I suspect this will not be a problem so protecting against
	 *    this should be unnecessary, but in theory it is possible so we want to 
	 *    protect against it just in case. It is highly unlikely this is desirable
	 *    behaviour if it does occur.
	 *    
	 * 3. For extra complexity, the cloning process yields objects which implement
	 *    notions of copy on write; in an attempt to make template generation fast 
	 *  
	 *  One possible way to make this faster is to clone the fields hashmap, then walk the EntrySet replacing values.
	 *   * advantage: hash resizing and insertion overheads avoided
	 *   * disadvantage: the entry set is iterated twice.  
	 *  To benchmark to see which method is faster
	 *  
	 * @param parent
	 * @return
	 */
	public UserSymbolScope(UserSymbolScope base,SymbolScope parent)
	{
		this(base,parent,true);
	}
	
	public UserSymbolScope(UserSymbolScope base,SymbolScope parent,boolean cloneUndeclared)
	{
		if (parent==null && base.getParentScope() instanceof AppLoaderScope) {
			parent = new AppLoaderScope((AppLoaderScope) base.getParentScope());
		} else {
			if (parent instanceof AppLoaderScope && base.getParentScope() instanceof AppLoaderScope) {
				throw new IllegalStateException("Pass null : this method will clone the AppLoaderScope for you");
			}
		}
		
		name=base.name;
		setParent(parent);

		fields=new LinkedHashMap<String,SymbolEntry>(base.fields.size());
		declaredFields=new LinkedHashMap<String,SymbolEntry>(base.declaredFields.size());
		
		dependentFieldBuffer=new HashMap<SymbolEntryKey,DependentSymbolStore>(base.dependentFieldBuffer.size());		
		Map<DependentSymbolStore,DependentSymbolStore> remapped=new IdentityHashMap<DependentSymbolStore,DependentSymbolStore>(base.dependentFieldBuffer.size());

		
		int lastRemain=-1;		
		List<SymbolEntry> remain=null;
		
		boolean containsPlaceholders=false;
		
		// clone fields, cloning their dependencies as we go. Generally dependents should occur after their dependees, but this is not
		// always the case.  Sometimes the dependees may not of even been fetched yet
		while ( true ) {
			Collection<SymbolEntry> fieldScan=remain==null ? base.fields.values() : remain;
			remain=new ArrayList<SymbolEntry>();
			for (SymbolEntry field : fieldScan) {	
				String lc_name=field.getName().toLowerCase();				
				String name = field.getName();
				if (fields.containsKey(lc_name)) {
					continue; // already cloned
				}
				
				if (field.getStore().isSystemStore() && parent instanceof AppLoaderScope) {
					field = parent.get(name);
					if (field==null) {
						continue;						
					}
					fields.put(lc_name,field);
					containsPlaceholders=true;
					continue;					
				}
				
				if (!cloneUndeclared && !base.declaredFields.containsKey(lc_name)) {
					continue;
				}
			
				
				if (field instanceof PlaceholderDependency) {
					
					boolean ok=true;
					for (SymbolEntry se : field.getDependencies()) {
						if (fields.containsKey(se.getName().toLowerCase())) {
							continue;
						}
						ok=false;
						remain.add(se);
					}
					if (!ok) {
						remain.add(field);
						continue;
					}
					
					field=parent.get(name);
					if (field instanceof PlaceholderDependency) {
						if (!(parent instanceof AppLoaderScope)) {
							throw new IllegalStateException("placeholder not replaced:"+name);	
						}					
					}
					if (field==null) {
						throw new IllegalStateException("placeholder not found:"+name);
					}
					fields.put(lc_name,field);
					continue;
				}
				
				if (field.getStore() instanceof DependentStore) {
					DependentStore oldStore = (DependentStore)field.getStore(); 
					DependentSymbolStore newStore = remapped.get(oldStore.getStore());
					if (newStore==null) {
						boolean ok=true;
						SymbolEntryKey oldKeys = oldStore.getStore().getDependentVariables();
						SymbolEntry newKey[] = new SymbolEntry[oldKeys.getKeyCount()];
						for (int scan=0;scan<newKey.length;scan++) {
							SymbolEntry oe = oldKeys.getKey(scan);
							newKey[scan]=fields.get(oe.getName().toLowerCase());
							if (newKey[scan]==null) {
								ok=false;
								remain.add(oldKeys.getKey(scan));
							}
						}				
						if (!ok) {
							remain.add(field);
							continue;
						}
						SymbolEntryKey newKeys = new SymbolEntryKey(newKey);					
						newStore=new DependentSymbolStore(oldStore.getStore(),newKeys);
						dependentFieldBuffer.put(newKeys,newStore);
						remapped.put(oldStore.getStore(),newStore);
					}
				
					field=field.clone(new DependentStore(newStore,oldStore));
				} else if (field.getStore() instanceof IndependentStore) {
					field=field.clone( ((IndependentStore)field.getStore()).clone());
				}

				fields.put(lc_name,field );			
				if (base.declaredFields.containsKey(lc_name)) {
					declaredFields.put(lc_name,field );	
				}
			}
			
			if (remain.isEmpty()) break;
			if (remain.size()==lastRemain) {
				throw new IllegalStateException("Could not clone");
			}
			lastRemain=remain.size();
		}
		
		if (containsPlaceholders) {
			for (DependentSymbolStore scan : remapped.values()) {
				scan.clean(base);
			}
		}
	}
	
	public void constrainFields(UserSymbolScope base)
	{
		java.util.Iterator<Map.Entry<String, SymbolEntry>> scan = fields.entrySet().iterator();
		while (scan.hasNext()) {
			Map.Entry<String, SymbolEntry> ent = scan.next();
			if (base.fields.containsKey(ent.getKey())) {
				continue;
			}
			declaredFields.remove(ent.getKey());
			scan.remove();
		}
	}

	public void setParent(SymbolScope parent)
	{
		this.parent=parent;
	}
	
	private LinkedList<UserScopeMonitor> monitors=null;
	@Override
	public void pushMonitor(UserScopeMonitor monitor)
	{
		if (monitors==null) {
			monitors=new LinkedList<UserScopeMonitor>();
		}
		monitors.add(monitor);
	}
	
	@Override
	public void popMonitor()
	{
		monitors.removeLast();
	}
	
	public SymbolEntry get(String name)
	{
		
		name=name.toLowerCase();
		SymbolEntry se = fields.get(name);
		if (se==null) {
			if (parent==null) return null;
			se=parent.get(name);
			if (se!=null) {
				fields.put(name,se);
			}
		}
		if (monitors!=null) {
			for (UserScopeMonitor monitor : monitors ) {
				monitor.monitor(name, se);
			}
		}
					
		return se;
	}
	
	public SymbolEntry declare(String name,boolean multi)
	{
		return declare(name,multi ? ValueType.multi : ValueType.scalar);
	}
	
	public SymbolEntry declare(String name,boolean multi,String type,String... params)
	{
		return declare(name,type,multi ? ValueType.multi : ValueType.scalar,params);		
	}


	public SymbolEntry declare(String name,ValueType valueType)
	{
		return declare(name,"STRING",valueType,new SymbolEntry[0]);
	}

	public SymbolEntry declare(String name,String type,ValueType valueType)
	{
		return declare(name,type,valueType,new SymbolEntry[0]);
	}
	
	public SymbolEntry declare(String name,String type,ValueType valueType,String... deps)
	{
		testDeclare(name);		
		if (deps.length==0) {
			return declareIndependent(name,type,valueType);
		}
		
		List<SymbolEntry> se = new ArrayList<SymbolEntry>();
		Map<SymbolEntry,SymbolEntry> test = new IdentityHashMap<SymbolEntry,SymbolEntry>();
		for (int scan=0;scan<deps.length;scan++) {
			SymbolEntry kid = get(deps[scan]);
			if (kid==null) throw new IllegalStateException("Dependency not declared");
			add(se,test,kid);			
		}
		
		return declareDependent(name,type,valueType,se.toArray(new SymbolEntry[se.size()]));
	}
	
	
	private void add(List<SymbolEntry> se, Map<SymbolEntry, SymbolEntry> test,SymbolEntry kid) {
		if (test.containsKey(kid)) {
			return;			
		}
		test.put(kid,kid);
		for (SymbolEntry scan : kid.getDependencies()) {
			add(se,test,scan);
		}
		se.add(kid);
	}

	public SymbolEntry declare(String name,String type,ValueType valueType,SymbolEntry... deps)
	{		
		testDeclare(name);		
		if (deps.length==0) {
			return declareIndependent(name,type,valueType);
		}
		
		// check if deps have deps of their own
		boolean nestedDeps=false;
		for (SymbolEntry se : deps ) {
			if (se.getDependencies().iterator().hasNext()) {
				nestedDeps=true;
				break;
			}
		}
		
		if (nestedDeps) {
			Map<SymbolEntry,SymbolEntry> test = new IdentityHashMap<SymbolEntry,SymbolEntry>();
			for (SymbolEntry se : deps ) {
				test.put(se,se);
			}
			testDependencies(test.keySet(),test.keySet());
		}
		
		return declareDependent(name,type,valueType,deps);
	}	
	
	private void testDeclare(String name) {
		name=name.toLowerCase();
		if (!declaredFields.containsKey(name)) return;

		debug();
		
		throw new IllegalStateException("Declaration for "+name+" eclipses prior declaration. Should this be allowed?");
	}

	private SymbolEntry declareDependent(String name, String type,ValueType valueType, SymbolEntry[] deps) 
	{		
		SymbolEntryKey  sek = new SymbolEntryKey(deps);
		DependentSymbolStore val = dependentFieldBuffer.get(sek);
		if (val==null) {
			val=new DependentSymbolStore(sek);
			dependentFieldBuffer.put(sek,val);
		}
		
		SymbolEntry se = val.create(name,type,valueType);
		String lc_name=name.toLowerCase();
		fields.put(lc_name,se);
		declaredFields.put(lc_name,se);
		return se;
	}
	
	public void declareAsReference(String name,SymbolEntry se)
	{
		fields.put(name.toLowerCase(),se);		
	}

	private SymbolEntry declareIndependent(String name,String type,ValueType valueType)
	{
		SymbolEntry se = SymbolEntry.create(name, type, valueType, new IndependentStore());
		String lc_name=name.toLowerCase();
		fields.put(lc_name,se);
		declaredFields.put(lc_name,se);
		return se;		
	}
	
	private void testDependencies(Set<SymbolEntry> keySet, Iterable<SymbolEntry> deps) 
	{
		for (SymbolEntry test : deps) {
			if (!keySet.contains(test)) throw new IllegalStateException("Dependent Key not found:"+test+" in "+keySet);
			testDependencies(keySet,test.getDependencies());
		}
	}

	
	public void dispose()
	{
		for (DependentSymbolStore scan : dependentFieldBuffer.values()) {
			scan.tearDown();
		}
		
		for (SymbolEntry se : this.declaredFields.values()) {
			se.dispose();
		}
		
		this.fields=null;
		this.dependentFieldBuffer=null;
		this.parent=null;
	}
	
	public SymbolScope getParentScope()
	{
		return parent;
	}
	
	public void debug()
	{
		System.err.println("SCOPE : "+this.name);
		for (SymbolEntry se : fields.values()) {
			if (getParentScope()!=null && getParentScope().get(se.getName())==se) continue;
			System.err.println("   "+se);
		}
		
		/*
		for (Map.Entry<SymbolEntryKey,DependentSymbolStore> me : dependentFieldBuffer.entrySet() ) {
			System.err.println("DEPENDENT GROUP:"+me.getKey());	
			me.getValue().debug();
		}
		*/
		
		if (parent instanceof UserSymbolScope) {
			((UserSymbolScope)parent).debug();
		}
	}

	public Iterable<SymbolEntry> getAllSymbols() {
		return fields.values();
	}

	@Override
	public void setParentScope(SymbolScope parent) {
		this.parent=parent;
	}

	@Override
	public String toString() {
		return name+" [fields=" + fields + "]";
	}

	public void remove(String counter) {
		counter=counter.toLowerCase();
		fields.remove(counter.toLowerCase());
		declaredFields.remove(counter.toLowerCase());
	}

	public UserSymbolScope save() {
		UserSymbolScope save=this;
		save = new UserSymbolScope(save,save.getParentScope());
		return save;
	}
	
	public void restore(UserSymbolScope save)
	{
		this.fields=save.fields;
		this.declaredFields=save.declaredFields;
		this.dependentFieldBuffer=save.dependentFieldBuffer;
	}

}


