package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.ide.Messages;

public class AbstractPropCheckPropertySection extends AbstractCheckPropertySection
{
	private int property;
	
	public AbstractPropCheckPropertySection(int property)
	{
		this.property=property;
	}
	
	
	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	boolean getValue() {
		return getPropertyManager().getBoolean(property);
	}

	@Override
	void setValue(boolean value) {
		getPropertyManager().setProp(property, getValue() ? Boolean.TRUE : null ,value ? Boolean.TRUE : null);
	}

}
