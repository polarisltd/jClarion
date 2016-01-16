package org.jclarion.clarion.appgen.symbol.user;

import java.util.Arrays;


public class SymbolFixKey
{
	private String[] values;
	private int hashCode=0;
	
	public SymbolFixKey(String values[])
	{
		this.values=values;
		for (String val : values) {		
			hashCode=31*hashCode+val.hashCode();
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
		SymbolFixKey t = (SymbolFixKey)obj;
		if (t.values.length!=values.length) return false;
		for (int scan=0;scan<values.length;scan++) {
			if (!values[scan].equals(t.values[scan])) {
				return false;
			}
		}
		return true;
	}

	@Override
	public String toString() {
		return Arrays.toString(values);
	}

	public String getValue(int scan) {
		return values[scan];
	}

	public String[] getValues() {
		String[] clone = new String[values.length];
		System.arraycopy(values,0,clone,0,values.length);
		return clone;
	}			
}