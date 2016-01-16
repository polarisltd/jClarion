package org.jclarion.clarion.appgen.symbol;

/**
 * Special clarion object that represents EOF
 */
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.loader.Definition;

public class DefinitionSymbolValue extends SymbolValue
{
	public DefinitionSymbolValue(Definition definition)
	{
		this.definition=definition;
	}
	
	private Definition definition;

	@Override
	public int getInt() {
		return 0;
	}

	@Override
	public String getString() {
		return definition.render();
	}

	@Override
	public SymbolValue clone() {
		return this;
	}

	@Override
	public ClarionObject asClarionObject() {
		return new DefinitionObject(definition);
	}

	@Override
	public String serialize() {		
		return "#Not implemented";
	}
	

}
