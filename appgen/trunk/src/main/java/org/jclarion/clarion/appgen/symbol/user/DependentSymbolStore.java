package org.jclarion.clarion.appgen.symbol.user;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.DependentListener;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;

public class DependentSymbolStore implements DependentListener
{
	private SymbolEntryKey 						dependentVars;	
	private int 								createCount=0;
	private int[]								fixCounters;
	private Map<SymbolFixKey,SimpleValueList> 	values;	
	private SimpleValueList	 					currentEntry = null;

	/**
	 * Create a new store
	 * 
	 * @param values The dependent keys
	 */
	public DependentSymbolStore(SymbolEntryKey values)
	{		
		this.dependentVars=values;
		this.values=new LinkedHashMap<SymbolFixKey,SimpleValueList>();
		
		for (SymbolEntry se : this.dependentVars) {
			se.addDependentListener(this);
		}
		
		fixCounters = new int[dependentVars.getKeyCount()];
	}
	
	
	/**
	 * Clone a new store from an existing store.  
	 * 
	 * @param base 			The Store being cloned
	 * @param newValues		New set of dependent keys, in case the keys change on the clone
	 */
	public DependentSymbolStore(DependentSymbolStore base,SymbolEntryKey newValues)
	{		
		this.dependentVars=newValues;
		this.values=new LinkedHashMap<SymbolFixKey,SimpleValueList>();
		this.createCount=base.createCount;

		for (Map.Entry<SymbolFixKey,SimpleValueList> e : base.values.entrySet()) {
			values.put(e.getKey(),new SimpleValueList(e.getValue()));
		}
		
		for (SymbolEntry se : this.dependentVars) {
			se.addDependentListener(this);
		}
		fixCounters = new int[dependentVars.getKeyCount()];
	}
	
	/**
	 * Supposed to reclone the store with a new version tree. Intended to 'vacuum' the store of dead version store records.  Largely pointless.  
	 */
	public void vacuum()
	{
		currentEntry=null;
	}
	
	public int getVariableCount()
	{
		return createCount;
	}
	
	public SimpleValueList getEntry()
	{
		getModifyVersion();
		if (currentEntry==null) {
			SymbolFixKey key = dependentVars.getFixKey();
			currentEntry=values.get(key);
			if (currentEntry==null) {
				currentEntry=new SimpleValueList();
				values.put(key,currentEntry);
			}
		}
		return currentEntry;
	}
	
	public SymbolEntry create(String name,String type,ValueType valueType)
	{
		return SymbolEntry.create(name,type, valueType, new DependentStore(this,createCount++));
	}
	
	public int getNewCreateCount()
	{
		return createCount++;
	}
	
	public void tearDown()
	{
		for (SymbolEntry se : dependentVars) {
			se.removeDependentListener(this);
		}
	}
	
	public SymbolEntryKey getDependentVariables()
	{
		return dependentVars;
	}

	@Override
	public String toString() {
		return "SymbolEntryValue [dependentVars="
				+ dependentVars 
				+ ", values=" + values + ", currentEntry=" + currentEntry
				+ "]";
	}	
	
	public void debug()
	{
		System.err.println("   CE:"+currentEntry);
		for (Map.Entry<SymbolFixKey,SimpleValueList> me: values.entrySet() ) {
			System.err.println("   "+me.getKey()+" = "+me.getValue());
		}
		
	}

	public Iterable<SimpleValueList> getValues() 
	{
		return values.values();
	}

	public Iterable<SymbolFixKey> find(final DependentStore store,final SymbolValue value) 
	{
		return new Iterable<SymbolFixKey>() {

			@Override
			public Iterator<SymbolFixKey> iterator() {
				
				final Iterator<Map.Entry<SymbolFixKey,SimpleValueList>> scan = values.entrySet().iterator();
				
				return new Iterator<SymbolFixKey>() {

					private SymbolFixKey next=null;
					
					@Override
					public boolean hasNext() {
						while (next==null) {
							if (!scan.hasNext()) return false;
							Map.Entry<SymbolFixKey,SimpleValueList> test = scan.next();
							SymbolValue sv = store.load(test.getValue());
							if (sv==null) continue;
							if (!sv.contains(value)) continue;
							next=test.getKey();
						}
						return true;
					}

					@Override
					public SymbolFixKey next() {
						if (!hasNext()) throw new IllegalStateException("Iterator Exhausted");
						SymbolFixKey ret=next;
						next=null;
						return ret;
					}

					@Override
					public void remove() {
					}
					
				};
			}
		};
	}




	/*
	@Override
	public void alertFixChange(SymbolEntry source) 
	{
		currentEntry=null;
		modified++;
	}
	*/

	@Override
	public void alertPurge(SymbolEntry source) {
		this.values=new LinkedHashMap<SymbolFixKey,SimpleValueList>();
		modified++;
		currentEntry=null;
	}
	
	private int	modified=0;
	public int getModifyVersion()
	{
		for (int scan=0;scan<fixCounters.length;scan++) {
			int id = dependentVars.getKey(scan).getFixCounter();
			if (id!=fixCounters[scan]) {
				fixCounters[scan]=id;
				currentEntry=null;
				modified++;
			}
		}				
		return modified;
	}


	public boolean isPurged() {
		return values.isEmpty();
	}


	@Override
	public void alertValueChange(SymbolEntry source, String from,String to) 
	{
		int pos=dependentVars.getPosition(source);
		
		Map<SymbolFixKey,SimpleValueList> 	newValues=new LinkedHashMap<SymbolFixKey,SimpleValueList>();
		
		for (Map.Entry<SymbolFixKey,SimpleValueList> scan : values.entrySet()) {
			boolean changed=true;
			for (int fkey=0;fkey<pos;fkey++) {
				if (!dependentVars.getKey(fkey).getFix().equals(scan.getKey().getValue(fkey))) {
					changed=false;
					break;
				}
			}
			SimpleValueList value = scan.getValue();
			SymbolFixKey key = scan.getKey();
			if (changed && scan.getKey().getValue(pos).equals(from)) {
				if (to==null) continue; // deletion
				String values[] = key.getValues();
				values[pos]=to;
				key=new SymbolFixKey(values);
			}
			newValues.put(key,value);
		}
		values=newValues;
		currentEntry=null;
		modified++;		
	}


	public void clean(UserSymbolScope base) 
	{
		int count=0;
		PlaceholderDependency placeholder[] = new PlaceholderDependency[5];
		SymbolEntry system[] = new SymbolEntry[5];
		
		for (SymbolEntry scan : getDependentVariables()) {
			if (!(scan instanceof PlaceholderDependency)) break;
			placeholder[count]=(PlaceholderDependency)scan;
			system[count]=base.get(scan.getName());
			if (system[count]==null || system[count].list()==null) {
				throw new IllegalStateException("Could not locate symbol for :"+scan.getName());
			}
			count++;
		}
		if (count==0) return;
		
		Iterator<SymbolFixKey> scan = this.values.keySet().iterator();
		
		while (scan.hasNext()) {
			SymbolFixKey fix = scan.next();		
			if (fix==null) {
				scan.remove();
				continue;
			}
			boolean ok=true;
			for (int it=0;it<count;it++) {
				if (!system[it].list().values().fix(SymbolValue.construct(fix.getValue(it)))) {
					ok=false;
				}
			}
			if (!ok) {
				scan.remove();
				continue;
			}
			for (int it=0;it<count;it++) {
				SymbolValue sv = SymbolValue.construct(fix.getValue(it));
				ListSymbolValue lsv = placeholder[it].list().values();
				if (!lsv.fix(sv)) {
					lsv.add(sv);
					lsv.fix(sv);
				}
			}
		}			
	}	
}