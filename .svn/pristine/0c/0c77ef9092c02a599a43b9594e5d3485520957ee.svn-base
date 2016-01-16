package org.jclarion.clarion.appgen.symbol.system;

import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.appgen.symbol.DependentListener;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.user.SymbolEntryKey;
import org.jclarion.clarion.appgen.symbol.user.SymbolPosFixKey;


public class SystemDepContainer implements DependentListener
{
	private static class Entry
	{
		private SymbolValue[] array;
	}
	
	private SymbolEntryKey deps;
	private int size=0;
	private Map<SymbolPosFixKey,Entry> container = new LinkedHashMap<SymbolPosFixKey,Entry>();  
	private int[] fixCounters;
	private int containerVersionCount;
	private Entry currentEntry;
	private SymbolPosFixKey fix;
	
	public SystemDepContainer(SymbolEntryKey deps)
	{
		this.deps=deps;
		for (SymbolEntry se : deps.getKeys()) {
			se.addDependentListener(this);
		}
		fixCounters = new int[deps.getKeyCount()];		
	}
	
	public int getContainerVersion()
	{
		return containerVersionCount;
	}
	
	public <X extends SystemSymbolScope> SystemDepStore<X> create(X scope,SymbolFactory<X> factory)
	{		
		return new SystemDepStore<X>(scope,factory,this,size++);
	}

	public void set(int ofs, SymbolValue val) 
	{
		getCurrentEntry();
		if (currentEntry.array.length<=ofs) {
			SymbolValue se[] = new SymbolValue[size];
			System.arraycopy(currentEntry.array,0,se,0,currentEntry.array.length);
			currentEntry.array=se;
		}
		currentEntry.array[ofs]=val;
	}

	public SymbolValue get(int ofs) {
		getCurrentEntry();
		if (ofs>=currentEntry.array.length)  return null;
		return currentEntry.array[ofs];
	}
	

	public SymbolEntryKey getDependencies() {
		return deps;
	}
	
	public boolean getCurrentEntry()
	{
		getModifyVersion();
		if (currentEntry==null) {
			fix = deps.getPosFixKey();
			if (fix==null) return false;
			Entry e = container.get(fix);
			if (e==null) {
				e=new Entry();
				e.array=new SymbolValue[size];
				container.put(fix, e);
			}
			currentEntry=e;
		}
		return true;
	}
	
	public SymbolPosFixKey getLastFix()
	{
		return fix;
	}

	@Override
	public void alertPurge(SymbolEntry source) 
	{
	}

	private int modify;
	public int getModifyVersion() {
		for (int scan=0;scan<fixCounters.length;scan++) {
			int id = deps.getKey(scan).getFixCounter();
			if (id!=fixCounters[scan]) {
				fixCounters[scan]=id;
				currentEntry=null;
				modify++;
			}
		}						
		return modify;
	}

	public void recycle()
	{
		modify++;
		for (int scan=0;scan<fixCounters.length;scan++) {
			fixCounters[scan]=0;
		}
		currentEntry=null;
		container.clear();
	}
	
	@Override
	public void alertValueChange(SymbolEntry source, String from,String to) 
	{
		throw new IllegalStateException("Not Implemented");
	}

}
