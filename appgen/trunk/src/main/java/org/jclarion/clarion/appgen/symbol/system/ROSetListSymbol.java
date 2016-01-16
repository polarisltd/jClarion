package org.jclarion.clarion.appgen.symbol.system;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeSet;

import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolValue;

public class ROSetListSymbol extends ListSymbolValue
{
	private Map<SymbolValue,Integer> tree;
	private SymbolValue[]				 order;

	public static ROSetListSymbol create(String ...bits)
	{
		TreeSet<String> ts = new TreeSet<String>();
		for (String s : bits ) {
			ts.add(s);
		}
		return new ROSetListSymbol(ts);
	}

	public static ROSetListSymbol createList(String ...bits)
	{
		ArrayList<String> ts = new ArrayList<String>();
		for (String s : bits ) {
			ts.add(s);
		}
		return new ROSetListSymbol(ts);
	}
	
	public ROSetListSymbol(Collection<?> set)
	{
		tree=new HashMap<SymbolValue,Integer>();
		order=new SymbolValue[set.size()];
		int pos=0;
		for (Object o  : set ) {
			SymbolValue s = new StringSymbolValue(o.toString());
			order[pos++]=s;
			tree.put(s,pos);
		}
	}
	
	private int fixLocation=0;
	
	@Override
	public void add(SymbolValue value) {
		throw new IllegalStateException("Read only");
	}

	@Override
	public void add(SymbolValue value, int pos) 
	{
		throw new IllegalStateException("Read only");
	}

	@Override
	public void delete(int pos) 
	{
		throw new IllegalStateException("Read only");	
	}

	@Override
	public void delete() {
		throw new IllegalStateException("Read only");
	}

	@Override
	public int size() {
		return order.length;
	}

	@Override
	public boolean fix(SymbolValue value) {
		Integer i = tree.get(value);
		if (i!=null) {
			fixLocation=i;
			alertFixChange();
			return true;
		} else {
			clear();
		}
		return false;
	}

	@Override
	public boolean select(int ofs) 
	{
		fixLocation=ofs;
		alertFixChange();
		return true;
	}

	@Override
	public int instance() 
	{
		return fixLocation;
	}

	@Override
	public SymbolValue value() {
		if (fixLocation<1 || fixLocation>order.length) return null;
		return order[fixLocation-1];
	}

	@Override
	public void free() {
		throw new IllegalStateException("Read only");
	}

	@Override
	public ListSymbolValue clone() {
		return this; // is read only
	}

	private class ROListScanner extends ListScanner
	{
		private int start;
		private int dir;

		public ROListScanner(int start,int dir)
		{
			this.start=start;
			this.dir=dir;
		}

		@Override
		public boolean next() {
			if (start<1 || start>order.length) {
				return false;
			}
			select(start);
			start+=dir;
			return true;
		}

		@Override
		public void dispose() {
		}
		
	}
	
	@Override
	public ListScanner loop(boolean reverse) 
	{
		if (reverse) {
			return new ROListScanner(order.length,-1);
		} else {
			return new ROListScanner(1,1);
		}		
	}

	@Override
	public void clear() {
		fixLocation=0;
		alertFixChange();
	}
	
	@Override
	public final void alertFixChange() {
		if (fixLocation>=1 && fixLocation<=order.length) {
			applyFix(fixLocation-1);
		}
		
		super.alertFixChange();
	}

	public void applyFix(String value)
	{
	}

	public void applyFix(int ofs)
	{
		applyFix(order[ofs].getString());
	}

	@Override
	public boolean contains(SymbolValue value) {
		return tree.containsKey(value);
	}

	@Override
	public String toString() {
		return "["+Arrays.toString(order)
				+ "]:" + fixLocation + "";
	}

	@Override
	public int containsPos(SymbolValue value) {
		Integer pos = tree.get(value);
		if (pos==null) return 0;
		return pos;
	}
}
