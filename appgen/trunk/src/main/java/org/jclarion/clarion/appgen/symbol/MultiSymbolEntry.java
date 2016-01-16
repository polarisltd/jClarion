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
public class MultiSymbolEntry extends SymbolEntry
{
	private ValueType valueType;


	public MultiSymbolEntry(String name, String type, ValueType valueType,SymbolStore store) 
	{
		super(name, type, store);
		this.valueType=valueType;
	}
	
	public ValueType getValueType()
	{
		return valueType;
	}

	@Override
	public SymbolValue getValue() {
		return values().value();
	}
	
	private int monitorModify=-1;
	private ListSymbolValue lastValue;
	
	public void alertDependentsOfPurge()
	{
		super.alertDependentsOfPurge();
		lastValue=null;
	}	

	public ListSymbolValue lastValues()
	{
		return lastValue;
	}
	
	public ListSymbolValue values()
	{
		int newVersion=getStore().getModifyVersion();
		if (newVersion==monitorModify && lastValue!=null) return lastValue;
		
		ListSymbolValue array = (ListSymbolValue)getStore().load();
		if (array==null) {
			if (valueType==ValueType.unique) {
				array=new UniqueListSymbolValue();
			} else {
				array=new ArrayListSymbolValue();
			}
			getStore().save(array);
		}		
		
		
		if (monitorModify!=newVersion) {
			
			if (array!=lastValue) {
				// list has changed, so clear fix on newly selected list
				array.clear();
				lastValue=array;
			} else {
				// list is the same even though store has changed since last access
				// we want to notify system code of change so it can reset globals,
				// but we don't want to trigger more fix changes
				array.setSymbolEntry(null);
				array.alertFixChange(); 
			}
			array.setSymbolEntry(this);
			monitorModify=newVersion;
		} else if (lastValue!=null && lastValue!=array) {
			throw new IllegalStateException("Invariant failed for symbol:"+getName());
		} else {
			lastValue=array;
			array.setSymbolEntry(this);
			monitorModify=newVersion;
		}
		return array;
	}
	
	@Override
	public SymbolEntry clone(SymbolStore clonedStore) 
	{
		SymbolEntry se = new MultiSymbolEntry(getName(),getType(),valueType,clonedStore);
		se.setWidget(this.getWidget());
		return se;
	}

	@Override
	public ScalarSymbolEntry scalar() {
		return null;
	}

	@Override
	public MultiSymbolEntry list() {
		return this;
	}

	@Override
	public String toString() {
		return "ScalarSymbolEntry [" + getName() + " ("+ getType() + ") " + "]";
	}

	@Override
	public SymbolValue getAny() {
		return values();
	}

	@Override
	public void clear() {
		values().clear();
	}
	
}
	
	
