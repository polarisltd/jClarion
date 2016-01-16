package org.jclarion.clarion.appgen.symbol.user;

import java.util.Iterator;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolStore;
import org.jclarion.clarion.appgen.symbol.SymbolValue;

public class DependentStore extends SymbolStore
{
	private int 				 ofs=0;
	private DependentSymbolStore store;

	public DependentStore(DependentSymbolStore store,int ofs)
	{
		this.ofs=ofs;
		this.store=store;
	}
	
	public void purge()
	{
		if (!store.isPurged()) {
			ofs=store.getNewCreateCount();
		}
	}

	public DependentStore(DependentSymbolStore store,DependentStore old)
	{
		this.ofs=old.ofs;
		this.store=store;
	}

	@Override
	public SymbolValue load() {
		return load(store.getEntry());
	}

	public SymbolValue load(SimpleValueList entry) {
		return entry.get(ofs);
	}

	@Override
	public void save(SymbolValue value) {
		store.getEntry().set(ofs,store.getVariableCount(),value);
	}

	@Override
	public Iterable<SymbolEntry> getDependencies() {
		return store.getDependentVariables();
	}
	
	@Override
	public Iterable<SymbolValue> getAllPossibleValues() {
		return new Iterable<SymbolValue>() {
			@Override
			public Iterator<SymbolValue> iterator() {
				return new Iterator<SymbolValue>() {
					
					private Iterator<SimpleValueList> scan=store.getValues().iterator();
					private SymbolValue next=null; 
					
					@Override
					public boolean hasNext() {
						while (next==null) {
							if (!scan.hasNext()) return false;
							SimpleValueList vl = scan.next();
							SymbolValue sv = vl.get(ofs);
							if (sv==null) continue;
							next=sv;
						} 
						return true;
					}

					@Override
					public SymbolValue next() {
						if (!hasNext()) throw new IllegalStateException("Iterator exhausted");
						SymbolValue r = next;
						next=null;
						return r;
					}

					@Override
					public void remove() {
					}
				};
			}
		};
	}

	public DependentSymbolStore getStore() {
		return store;
	}

	@Override
	public String toString() {
		SymbolValue sv = load();
		if (sv==null) return "(null)";
		return sv.toString();
	}

	@Override
	public Iterable<SymbolFixKey> find(final SymbolValue match,int limit) {
		
		return store.find(this, match);
	}

	@Override
	public int getModifyVersion() {
		return store.getModifyVersion();
	}

	@Override
	public boolean isSystemStore() {
		return false;
	}

}
