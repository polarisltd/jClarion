package org.jclarion.clarion.ide.view.properties;

import java.util.Collection;

import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

public class UnitsPropertySection extends AbstractComboPropertySection {

	public UnitsPropertySection() {
		super();
	}

	@Override
	Collection<String> getValues() {
		return PropertyManager.getUnitsNames();
	}

	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	String getValueAsString() {
		return getPropertyManager().getUnits();
	}

	@Override
	void setValueAsString(String value) {
		getPropertyManager().setUnits(value,getValueAsString());
	}

}
