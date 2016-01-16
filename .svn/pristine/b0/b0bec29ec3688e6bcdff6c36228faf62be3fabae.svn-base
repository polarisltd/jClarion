package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.ClarionObject;


public class IntSymbolValue extends SymbolValue
{
	public static final IntSymbolValue ONE = new IntSymbolValue(1);
	public static final IntSymbolValue ZERO = new IntSymbolValue(0);
	private int value;
	private String s_value;

	public IntSymbolValue(int value)
	{
		this.value=value;
	}
	
	public int getValue()
	{
		return value;
	}
	
	public String toString()
	{
		return "int:"+value;
	}

	@Override
	public int getInt() {
		return value;
	}

	@Override
	public String getString() {
		if (s_value==null) {
			s_value=String.valueOf(value);
		}
		return s_value;
	}

	@Override
	public SymbolValue clone() {
		return this;
	}	
	
	@Override
	public ClarionObject asClarionObject() {
		return new NumberScalarObject(value,this);
	}
	
	@Override
	public String serialize() {		
		return String.valueOf(value);
	}	
	
}
