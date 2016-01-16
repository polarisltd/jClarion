package org.jclarion.clarion.appgen.symbol;



/**
 *  A symbol entry represents an entry from a scope.
 *  
 *  These objects can be cached in different scopes. For example to save walking down scope tree every lookup, the topmost tree can cache 
 *  results from deeper scopes. 
 *  
 * @author barney
 *
 */
public class ScalarSymbolEntry extends SymbolEntry
{
	public ScalarSymbolEntry(String name,String type,SymbolStore store) 
	{
		super(name,type,store);
	}
	
	@Override
	public SymbolValue getValue()
	{
		return getStore().load();
	}
	
	public void setValue(SymbolValue value)
	{
		getStore().save(value);
		alertDependentsOfFixChange();
	}

	@Override
	public SymbolEntry clone() {
		return null;
	}

	@Override
	public ScalarSymbolEntry clone(SymbolStore clonedStore) {
		ScalarSymbolEntry se = new ScalarSymbolEntry(getName(),getType(),clonedStore);
		se.setWidget(this.getWidget());
		return se;
	}

	@Override
	public ScalarSymbolEntry scalar() {
		return this;
	}

	@Override
	public MultiSymbolEntry list() {
		return null;
	}

	@Override
	public String toString() {
		return "ScalarSymbolEntry [" + getName() + " ("+ getType() + ") =" + getStore() + "]";
	}

	@Override
	public SymbolValue getAny() {
		return getValue();
	}

	@Override
	public void clear() {
		setValue(new NullSymbolValue());
	}

	@Override
	public ValueType getValueType() {
		return ValueType.scalar;
	}
}
	
	
