package org.jclarion.clarion.ide.view.properties;


import org.jclarion.clarion.ide.Messages;

/**
 * Minimises the effort required to implement an integer property section
 */
abstract class AbstractIntegerPropertySection extends AbstractTextPropertySection {

	private int property;

	public AbstractIntegerPropertySection(int property)
	{
		this.property=property;
	}


	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}	
	
	@Override
	Integer getValue() {
		return getPropertyManager().getInteger(property);
	}

	@Override
	void setValueAsString(Object priorValue, String value, boolean commit) {
		
		Integer ivalue = null;
		if (value!=null && value.trim().length()>0) {
			try {
				ivalue=Integer.parseInt(value);
			} catch (NumberFormatException ex) { }
		}
		if (!commit) {
			getObject().setClonedProperty(property,ivalue);
		} else {
			getPropertyManager().setProp(property, priorValue,ivalue);
		}
	}
	
}