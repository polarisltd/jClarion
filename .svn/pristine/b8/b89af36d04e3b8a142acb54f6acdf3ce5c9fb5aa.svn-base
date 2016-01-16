package org.jclarion.clarion.appgen.symbol;

import java.util.Iterator;
import java.util.Map;
import java.util.NavigableSet;
import java.util.TreeMap;



public class UniqueListSymbolValue extends ListSymbolValue
{
	private TreeMap<SymbolValue,Integer> values;	
	private int 						 modified=0;
	
	private boolean						 copyMapOnWrite;
	private boolean						 copyArrayOnWrite;

	private boolean										fullyOrdered;
	private SymbolValue[]				 				orderedValues;
	private int							 				orderedProgress=0;	
	private Iterator<Map.Entry<SymbolValue,Integer>>	orderedScan;
	
	
	private SymbolValue					 fixLocation;
	
	public UniqueListSymbolValue() {
		values=new TreeMap<SymbolValue,Integer>();
	}
	
	public UniqueListSymbolValue(UniqueListSymbolValue base) {
		base.copyMapOnWrite=true;
		base.copyArrayOnWrite=true;
		this.values=base.values;
		this.copyArrayOnWrite=true;
		this.copyMapOnWrite=true;
		this.fullyOrdered=base.fullyOrdered;
		this.orderedValues=base.orderedValues;
		this.orderedProgress=base.orderedProgress;
		this.orderedScan=null;
		this.fixLocation=base.fixLocation;
	}
	
	private void copyOnWrite()
	{
		if (copyMapOnWrite) {
			values=new TreeMap<SymbolValue,Integer>(values);
			orderedScan=null;
			copyMapOnWrite=false;
		}
		
		if (copyArrayOnWrite) {
			copyArrayOnWrite=false;
			if (orderedProgress==0) {
				orderedValues=null;
			} else {
				SymbolValue[] newList = new SymbolValue[values.size()+4];
				System.arraycopy(orderedValues,0,newList,0,orderedProgress);
				orderedValues=newList;				
			}
		}
		modified++;
	}

	
	@Override
	public void add(SymbolValue value) 
	{
		copyOnWrite();
		values.put(value, null);
		fixLocation=value;
		alertFixChange();			
		disorder(value);
	}

	private void delete(SymbolValue value) 
	{
		copyOnWrite();
		values.remove(value);
		disorder(value);
	}
	
	@Override
	public void add(SymbolValue value, int pos) {
		add(value);
	}

	private void disorder(SymbolValue value)
	{
		fullyOrdered=false;
		if (orderedProgress==0) {
			orderedScan=null;
			return;
		}
			
		int cmp = value.compareTo(orderedValues[orderedProgress-1]);
		if (cmp<0) {
			orderedProgress=0;
			orderedScan=null;
			return;
		}
		if (cmp==0) {
			orderedProgress--;
			if (orderedProgress==0) {
				orderedScan=null;
				return;
			}
		}
		orderedScan = values.tailMap(orderedValues[orderedProgress-1],false).entrySet().iterator();
	}
	
	private void order(SymbolValue untilValue,int untilIndex)
	{
		if (fullyOrdered) {
			return;
		}
		
		if (orderedProgress==0) {
			orderedScan=values.entrySet().iterator();
			if (orderedValues==null || orderedValues.length<values.size()) {
				orderedValues=new SymbolValue[values.size()+4];
			}
		} else {
			orderedScan = values.tailMap(orderedValues[orderedProgress-1],false).entrySet().iterator();
			if (orderedValues.length<values.size()) {
				int len = orderedValues.length;
				while (len<values.size()) {
					len=len<<1;
				}
				SymbolValue[] newList = new SymbolValue[len];
				System.arraycopy(orderedValues,0,newList,0,orderedProgress);
				orderedValues=newList;
			}
		}
		
		while (orderedScan.hasNext()) {
			Map.Entry<SymbolValue,Integer> me = orderedScan.next();
			SymbolValue key = me.getKey();
			orderedValues[orderedProgress++]=key;
			me.setValue(orderedProgress);
			
			if (untilIndex>0 && orderedProgress>=untilIndex) return;
			if (untilValue!=null && untilValue.compareTo(key)<=0) return;
		}
		fullyOrdered=true;
		orderedScan=null;
	}
	
	@Override
	public void delete(int pos) {
		if (pos>values.size()) return;
		order(null,pos);
		delete(orderedValues[pos-1]);
	}

	@Override
	public void delete() {
		delete(fixLocation);
	}

	@Override
	public int size() {
		return values.size();
	}

	@Override
	public boolean fix(SymbolValue value) 
	{
		if (values.containsKey(value)) {
			fixLocation=value;
			alertFixChange();
			return true;
		} 
		fixLocation=null;
		alertFixChange();
		return false;
	}

	public boolean contains(SymbolValue value)
	{
		return values.containsKey(value);
	}
	
	@Override
	public boolean select(int ofs) {
		if (ofs>values.size()) return false;
		order(null,ofs);
		fixLocation=orderedValues[ofs-1];
		alertFixChange();
		return true;
	}

	@Override
	public int instance() {
		if (fixLocation==null) return 0;
		order(fixLocation,0);
		Integer i = values.get(fixLocation);
		if (i==null) return 0;
		return i;
	}

	@Override
	public SymbolValue value() {
		return fixLocation;
	}

	@Override
	public void free() {
		if (copyArrayOnWrite) {
			this.orderedValues=null;
			copyArrayOnWrite=false;
		} 
		values=new TreeMap<SymbolValue,Integer>();
		copyMapOnWrite=false;
		fullyOrdered=true;
		orderedProgress=0;
		orderedScan=null;
	}

	@Override
	public UniqueListSymbolValue clone() {
		return new UniqueListSymbolValue(this);
	}

	private class UniqueListScanner extends ListScanner
	{
		private boolean finished;
		private SymbolValue last=null;
		private Iterator<SymbolValue> scanner;
		private int lastModified=0;
		private boolean reverse;
		
		public UniqueListScanner(boolean reverse)
		{
			this.reverse=reverse;
		}
		
		@Override
		public boolean next() {
			if (finished) return false;
			if (lastModified<modified) {
				scanner=null;
				lastModified=modified;
			}
			
			NavigableSet<SymbolValue> set = reverse ? values.descendingKeySet() : values.navigableKeySet();
			if (last==null) {
				scanner=set.iterator();
			} else {
				scanner=set.tailSet(last, false).iterator();
			}
			
			if (scanner.hasNext()) {
				last=scanner.next();
				alertFixChange();
				fixLocation=last;
				return true;
			}
			scanner=null;
			finished=true;
			return false;
		}

		@Override
		public void dispose() {
			finished=true;
			scanner=null;
			last=null;			
		}
	}
	
	@Override
	public ListScanner loop(final boolean reverse) 
	{
		return new UniqueListScanner(reverse);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("[");
		for (SymbolValue sv : this.values.keySet()) {
			if (sb.length()>1) sb.append(',');
			sb.append(sv);
		}
		sb.append(']');
		return sb.toString();
	}

	@Override
	public void clear() {
		alertFixChange();
		fixLocation=null;
	}

	@Override
	public int containsPos(SymbolValue value) {
		order(value,0);
		Integer pos = values.get(value);
		if (pos==null) return 0;
		return pos;
	}	
}

