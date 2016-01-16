package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.ide.Messages;

/**
 * Minimises the effort required to implement a string property section
 */
abstract class AbstractStringPropertySection extends AbstractTextPropertySection {

	private int property;

	public AbstractStringPropertySection(int property)
	{
		this.property=property;
	}
	
	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	String getValue() {
		return getPropertyManager().getString(property);
	}

	@Override
	void setValueAsString(Object priorValue, String value, boolean commit) 
	{
		if (!commit) {
			getObject().setClonedProperty(property,value);
		} else {
			getPropertyManager().setProp(property, priorValue,value);
		}		
	}

	@Override
	public int getProperty() {
		return property;
	}

	
	
}
