package org.jclarion.clarion.appgen.symbol.user;

import java.util.Arrays;


public class SymbolPosFixKey
{
	private int[] values;
	private int hashCode=0;
	
	public SymbolPosFixKey(int values[])
	{
		this.values=values;
		for (int val : values) {		
			hashCode=31*hashCode+val;
		}
	}
	
	@Override
	public int hashCode()
	{
		return hashCode;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		SymbolPosFixKey t = (SymbolPosFixKey)obj;
		if (t.values.length!=values.length) return false;
		for (int scan=0;scan<values.length;scan++) {
			if (values[scan]!=t.values[scan]) {
				return false;
			}
		}
		return true;
	}

	@Override
	public String toString() {
		return Arrays.toString(values);
	}

	public int getPosition(int scan) {
		return values[scan];
	}

	public int getSize() {
		return values.length;
	}			
}