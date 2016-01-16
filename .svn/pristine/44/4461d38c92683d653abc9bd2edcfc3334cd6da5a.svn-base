package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.ClarionNumber;

public class NumberScalarObject extends ClarionNumber implements SymbolObject
{
	private SymbolValue symbol;

	public NumberScalarObject(int value,SymbolValue symbol)
	{
		super(value);
		this.symbol=symbol;
	}

	@Override
	public SymbolValue getSymbolValue() 
	{
		return symbol;
	}
	
	@Override
	public boolean equals(Object o) {
		if (o==null) return false;
		if (o instanceof SpecialObject) {
			return o.equals(this);
		}
		return super.equals(o);
	}	
}
