package org.jclarion.clarion.appgen.symbol.user;

import java.util.Arrays;
import java.util.Iterator;

import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;

public class SymbolEntryKey implements Iterable<SymbolEntry>
{
	private SymbolEntry keys[];
	private int hash=0;
	
	public SymbolEntryKey(SymbolEntry[] keys)
	{
		this.keys=keys;
		for (SymbolEntry scan : keys ) {
			hash=hash*31+scan.hashCode();
		}
	}
	
	public int getPosition(SymbolEntry se) 
	{
		for (int pos=keys.length-1;pos>=0;pos--) {
			if (keys[pos]==se) return pos;
		}
		return -1;
	}

	
	
	public SymbolFixKey getFixKey()
	{
		String[] bits =new String[keys.length];
		for (int scan=0;scan<keys.length;scan++) {
			bits[scan]=keys[scan].getFix();
			if (bits[scan]==null) return null;
		}
		return new SymbolFixKey(bits);
	}

	public SymbolPosFixKey getPosFixKey()
	{
		return getPosFixKey(keys.length);
	}
	
	public SymbolPosFixKey getPosFixKey(int len)
	{
		int[] bits =new int[len];
		for (int scan=0;scan<len;scan++) {
			int pos=0;
			if (keys[scan]!=null) {
				MultiSymbolEntry msv =keys[scan].list();
				if (msv==null) {
					pos=1;
				} else {
					ListSymbolValue l = msv.values();
					if (l!=null) {
						pos=l.instance();
					}
				}
			}
			
			 
			if (pos<=0) return null;
			bits[scan]=pos;
		}
		return new SymbolPosFixKey(bits);
	}
	
	@Override
	public int hashCode() {
		return hash;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		SymbolEntryKey t = (SymbolEntryKey)obj;
		if (t.keys.length!=keys.length) return false;
		
		for (int scan=0;scan<t.keys.length;scan++) {
			if (t.keys[scan]!=keys[scan]) return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "SymbolEntryKey [keys=" + Arrays.toString(keys) + "]";
	}

	@Override
	public Iterator<SymbolEntry> iterator() 
	{
		return new Iterator<SymbolEntry>() {
			
			int pos=0;
			
			@Override
			public boolean hasNext() {
				return pos<keys.length;
			}

			@Override
			public SymbolEntry next() {
				return keys[pos++];
			}

			@Override
			public void remove() {
			}
			
		};
	}

	public int getKeyCount() {
		return keys.length;
	}			
	
	public SymbolEntry getKey(int ofs) {
		return keys[ofs];
	}

	public SymbolEntry[] getKeys() {
		return keys;
	}			
}