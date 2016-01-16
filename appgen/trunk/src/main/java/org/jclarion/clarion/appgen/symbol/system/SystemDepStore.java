package org.jclarion.clarion.appgen.symbol.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.NullSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolStore;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.SymbolFixKey;
import org.jclarion.clarion.appgen.symbol.user.SymbolPosFixKey;


public class SystemDepStore<X extends SystemSymbolScope> extends SymbolStore implements SystemFactoryStore<X>
{
	private SymbolFactory<X> factory;
	private X base;
	private SystemDepContainer container;
	private int ofs;
	
	public SystemDepStore(X scope,SymbolFactory<X> factory,SystemDepContainer container,int ofs)
	{
		this.base=scope;
		this.container=container;
		this.ofs=ofs;
		this.factory=factory;
	}	

	@Override
	public SymbolValue load() {
		
		if (!container.getCurrentEntry()) {
			if (factory.isMulti()) {
				return ROSetListSymbol.create();
			} else {
				return new NullSymbolValue();
			}
		}
		SymbolValue val = container.get(ofs);
		if (val==null) {
			val=factory.load(base);
			container.set(ofs,val);
		}
		return val;
	}

	@Override
	public void save(SymbolValue value) 
	{
		throw new IllegalStateException("System Store is read only");
	}
	
	@Override
	public Iterable<SymbolEntry> getDependencies() 
	{
		return container.getDependencies();
	}
	
	@Override
	public Iterable<SymbolValue> getAllPossibleValues() 
	{
		return null;
	}
	
	private SymbolPosFixKey findCacheRoot;
	private Map<SymbolValue,List<SymbolFixKey>> findCache;
	private int findCacheVersion;	
	private static final List<SymbolFixKey> empty =new ArrayList<SymbolFixKey>();
	
	@Override
	public void recycle() {
		findCacheRoot=null;
		findCache=null;
		findCacheVersion=0;
	}
	

	public void debug()
	{
		System.err.println(container.getCurrentEntry());
		System.err.println(container.getLastFix());
		container.getModifyVersion();
		container.getCurrentEntry();
		System.err.println(container.getCurrentEntry());
		System.err.println(container.getLastFix());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Iterable<SymbolFixKey> find(SymbolValue match,int limit) {
		// make sure there are no gates above the limit
		for (int scan=limit;scan<container.getDependencies().getKeyCount();scan++) {
			if ( ((SystemFactoryStore<X>)container.getDependencies().getKey(scan).getStore()).getFactory().isGate() ) {
				throw new IllegalStateException("Find limit:"+limit+" occurs prior to memory gate at position #"+scan+" "+container.getDependencies().getKey(scan).getName());
			}
		}
		
		if (findCache!=null && findCacheVersion!=container.getContainerVersion()) {
			findCache=null;
		}
		
		if (findCache!=null && findCacheRoot.getSize()>0) {
			if (limit<findCacheRoot.getSize()) {
				findCache=null;
			} else {
				int pos=0;
				for (SymbolEntry test : container.getDependencies()) {
					if (test.list().values().instance()!=findCacheRoot.getPosition(pos++)) {
						findCache=null;
						break;
					}
					if (pos>=findCacheRoot.getSize()) break;
				}
			}
		}
		
		if (findCache==null) {
			findCache=new HashMap<SymbolValue,List<SymbolFixKey>>();
			findCacheRoot=container.getDependencies().getPosFixKey(limit);
			findCacheVersion=container.getContainerVersion();
			
			// only cache after the last gate
			int pos=container.getDependencies().getKeyCount()-1;
			while ( pos>=limit && !((SystemFactoryStore<X>)container.getDependencies().getKey(pos).getStore()).getFactory().isGate() ) {
				pos--;
			}
			pos++;

			
			SymbolEntry entries[] = new SymbolEntry[container.getDependencies().getKeyCount()-pos];
			int lastPos[] = new int[container.getDependencies().getKeyCount()-pos]; 
			for (int scan=0;scan<entries.length;scan++) {
				entries[scan]=container.getDependencies().getKey(scan+pos);
				lastPos[scan]=entries[scan].list().values().instance();
			}
			
			ListScanner scanners[] = new ListScanner[entries.length];
			int depth=0;
			main: while ( true ) {
				if (depth<scanners.length) {
					scanners[depth]=entries[depth].list().values().loop(false);
					depth++;
				}
				
				while (!scanners[depth-1].next()) {
					depth--;
					if (depth==0) break main;
				}
				if (depth<scanners.length) {
					continue;
				}
				
				SymbolFixKey key = container.getDependencies().getFixKey();
				
				SymbolValue value = load();
				if (value instanceof ListSymbolValue) {
					for (SymbolValue scan : (ListSymbolValue)value) {
						List<SymbolFixKey> fixlist = findCache.get(scan);
						if (fixlist==null) {
							fixlist=new ArrayList<SymbolFixKey>();
							findCache.put(scan,fixlist);
						}
						fixlist.add(key);
					}
				} else {
					List<SymbolFixKey> fixlist = findCache.get(value);
					if (fixlist==null) {
						fixlist=new ArrayList<SymbolFixKey>();
						findCache.put(value,fixlist);
					}
					fixlist.add(key);					
				}
			}
			
			for (int scan=0;scan<entries.length;scan++) {
				entries[scan].list().values().select(lastPos[scan]);
			}			
		}
		
		List<SymbolFixKey> fixlist = findCache.get(match);
		if (fixlist!=null) return fixlist;
		return empty;
	}

	@Override
	public SymbolFactory<X> getFactory() {
		return factory;
	}
	
	@Override
	public int getModifyVersion() {
		return container.getModifyVersion();
	}

	@Override
	public boolean isSystemStore() {
		return true;
	}


}
