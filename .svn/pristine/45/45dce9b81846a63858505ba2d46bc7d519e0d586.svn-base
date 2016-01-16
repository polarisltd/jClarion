package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.ClarionString;

public class EOFObject extends ClarionString implements SymbolObject,SpecialObject
{
	private SymbolValue symbol;
	
	public EOFObject()
	{
	}

	public EOFObject(SymbolValue symbol)
	{
		this.symbol=symbol;
	}
	
	@Override
	public SymbolValue getSymbolValue() {
		return symbol;
	}
	
	@Override
	public boolean equals(Object o) {
		if (o==null) return false;
		if (o instanceof EOFObject) return true;
		return false;
	}
	
}
