package org.jclarion.clarion.appgen.symbol;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.user.UserScopeMonitor;

/**
 * TODO: improve performance of this algorithm by not explicitly preserving all dependents. Do it implicitly by modifying store
 * so that it not only returns a modify version number of an object representing the modifications; so if a store reverts back to
 * what it was, the dependents are implicitly retained
 * 
 * TODO: figure out why we have to explicitly capture dependencies too
 * 
 * @author barney
 *
 */
public class PreserveBarrier implements UserScopeMonitor
{
	private static class Entry {
		SymbolEntry entry;
		int position;
		//SymbolValue value;
		boolean hasSystemDep;
		public ListSymbolValue lastValues;
	}
	
	private Map<String,PreserveBarrier.Entry> fix  = new LinkedHashMap<String,PreserveBarrier.Entry>();
		
	@Override
	public void monitor(String name, SymbolEntry val) {
		doMonitor(name,val);
	}
	
	
	private boolean doMonitor(String name,SymbolEntry val) 
	{		
		if (val==null) return false;
		if (val.list()==null) return false;
		name=name.toLowerCase();
		
		Entry e=fix.get(name);
		if (e!=null) return e.hasSystemDep;
		
		e=new Entry();
		e.entry=val;

		
		if (val.getStore().isSystemStore()) {
			e.hasSystemDep=true;
		} else {
			/*
			for (SymbolEntry dep : val.getDependencies()) {
				if (dep.getStore().isSystemStore()) {
					e.hasSystemDep=true;
				}
			}
			*/
		}
		
		
		for (SymbolEntry dep : val.getDependencies()) {
			if (doMonitor(dep.getName(),dep)) {
				e.hasSystemDep=true;
			}
		}
		
		if (val.list()!=null) {			
			ListSymbolValue vals=val.list().lastValues();
			e.lastValues=vals;
			if (vals!=null) { 
				if (e.hasSystemDep) {
					e.position=vals.instance();			
					//e.value=vals.value();
				}
			}
		}
		fix.put(name,e);
		return e.hasSystemDep;
	}

	public void restoreFixChanges()
	{
		//System.err.println("Restoring...");
		while (!fix.isEmpty()) {
			
			Iterator<Entry> scan = fix.values().iterator();
			while (scan.hasNext()) {
				Entry e = scan.next();
				
				/*
				boolean deps=false;
				for (SymbolEntry test : e.entry.getDependencies()) {
					if (fix.containsKey(test.getName().toLowerCase())) {
						deps=true;
						break;
					}
				}
				if (deps) {
					//System.err.println("ignoring restore for at this time:"+e.entry.getName());
					continue;
				}
				*/


				//System.err.println("Restore:"+e.entry.getName()+" from "+e.entry.list().lastValues().value() +" to "+e.value);
				if (e.position>0) {
					ListSymbolValue lsv = e.entry.list().values();
					if (lsv==e.lastValues && e.entry.list().values().instance()!=e.position) {
						lsv.select(e.position);
					}
				}
				
				//scan.remove();
			}
			break;
		}
	}
}