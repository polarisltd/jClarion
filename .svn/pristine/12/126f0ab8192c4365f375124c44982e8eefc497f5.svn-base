package org.jclarion.clarion.appgen.symbol.user;

import org.jclarion.clarion.appgen.symbol.SymbolValue;

class SimpleValueList
{
	private SymbolValue[] values;
	
	public SimpleValueList()
	{
	}

	public SimpleValueList(SimpleValueList base)
	{
		if (base.values==null) return;
		values=new SymbolValue[base.values.length];
		for (int scan=0;scan<values.length;scan++) {
			if (base.values[scan]!=null) {
				values[scan]=base.values[scan].clone();
			}
		}
				
	}

	public SymbolValue get(int ofs) 
	{
		if (values==null || ofs>=values.length) return null;
		return values[ofs];
	}

	public void set(int ofs, int variableCount, SymbolValue value) 
	{
		if (values==null || ofs>=values.length) {
			SymbolValue[] newValues=new SymbolValue[variableCount];
			if (values!=null) {
				System.arraycopy(values, 0, newValues, 0, values.length);
			}
			values=newValues;
		}
		values[ofs]=value;
	}
}