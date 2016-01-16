package org.jclarion.clarion.control;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;

public class PropertyChange {
	private PropertyObject 	source;
	private int 			property;
	private ClarionObject 	oldValue;
	private ClarionObject 	newValue;
	
	public PropertyChange(PropertyObject source,int property,ClarionObject newValue)
	{
		this.source=source;
		this.property=property;
		this.oldValue=source.getRawProperty(property,false);
		this.newValue=newValue;
	}
	
	public boolean changed()
	{
		if (oldValue==null ^ newValue==null) return true;
		if (oldValue==null) return true;
		return oldValue.equals(newValue);
	}

	public PropertyObject getSource() {
		return source;
	}

	public int getProperty() {
		return property;
	}

	public ClarionObject getOldValue() {
		return oldValue;
	}

	public ClarionObject getNewValue() {
		return newValue;
	}
	
	
}
