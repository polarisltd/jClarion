package org.jclarion.clarion.appgen.symbol.system;

import java.util.Iterator;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolStore;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.SymbolFixKey;


public class SystemStore<X extends SystemSymbolScope> extends SymbolStore implements SystemFactoryStore<X>
{
	private SymbolFactory<X> factory;
	private X base;
	private int modifyVersion=0;
	
	public SystemStore(X scope,SymbolFactory<X> factory)
	{
		this.base=scope;
		this.factory=factory;
	}	

	private SymbolValue cache;
	
	@Override
	public SymbolValue load() {
		if (cache==null) {
			cache=factory.load(base);
		}
		return cache;
	}

	public void recycle()
	{
		cache=null;
		modifyVersion++;
	}
	
	
	@Override
	public void save(SymbolValue value) 
	{
		throw new IllegalStateException("System Store is read only");
	}

	private static Iterator<SymbolEntry> emptyIterator=new Iterator<SymbolEntry>()
	{
		@Override
		public boolean hasNext() {
			return false;
		}

		@Override
		public SymbolEntry next() {
			return null;
		}

		@Override
		public void remove() {
			
		}
	};
	
	private static  Iterable<SymbolEntry> emptyIterable = new Iterable<SymbolEntry>()
	{
		@Override
		public Iterator<SymbolEntry> iterator() {
			return emptyIterator;
		}
	};
	
	@Override
	public Iterable<SymbolEntry> getDependencies() 
	{
		return emptyIterable;
	}

	@Override
	public Iterable<SymbolValue> getAllPossibleValues() 
	{
		return null;
	}

	@Override
	public Iterable<SymbolFixKey> find(SymbolValue match,int limit) {
		return null;
	}

	@Override
	public SymbolFactory<X> getFactory() {
		return factory;
	}

	@Override
	public int getModifyVersion() {
		return modifyVersion;
	}

	@Override
	public boolean isSystemStore() {
		return true;
	}
}
