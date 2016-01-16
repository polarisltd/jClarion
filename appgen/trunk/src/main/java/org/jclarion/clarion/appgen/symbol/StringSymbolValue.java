package org.jclarion.clarion.appgen.symbol;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.lang.SourceEncoder;


public class StringSymbolValue extends SymbolValue
{
	public static final StringSymbolValue BLANK = new StringSymbolValue("");
	private String value;

	public StringSymbolValue(String value)
	{
		this.value=value;
	}
	
	public String getValue()
	{
		return value;
	}
	
	public String toString()
	{
		return "string:"+value;
	}
	
	private int i_value;
	private boolean i_value_ready=false;
	@Override
	public int getInt() {
		if (!i_value_ready) {
			if (value.equals("")) {
				i_value=0;
			} else {
				i_value=Integer.parseInt(value);
			}
			i_value_ready=true;
		}
		return i_value;
	}

	@Override
	public String getString() {
		return value;
	}

	@Override
	public SymbolValue clone() {
		return this;
	}

	@Override
	public ClarionObject asClarionObject() {
		return new StringScalarObject(value,this);
	}

	@Override
	public String serialize() {		
		return SourceEncoder.encodeString(value);
	}

}
