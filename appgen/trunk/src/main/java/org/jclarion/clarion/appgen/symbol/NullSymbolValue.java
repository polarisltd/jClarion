package org.jclarion.clarion.appgen.symbol;

/**
 * Special clarion object that represents EOF
 */
import org.jclarion.clarion.ClarionObject;

public class NullSymbolValue extends SymbolValue
{

	@Override
	public int getInt() {
		return 0;
	}

	@Override
	public String getString() {
		return "";
	}

	@Override
	public SymbolValue clone() {
		return this;
	}

	@Override
	public ClarionObject asClarionObject() {
		return new NullObject();
	}
	
	@Override
	public String serialize() {		
		return "NULL";
	}	

}
