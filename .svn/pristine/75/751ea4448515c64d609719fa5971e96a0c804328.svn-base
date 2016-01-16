package org.jclarion.clarion.ide.view.properties;

import java.util.Collection;

import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

public class OrientationPropertySection extends AbstractComboPropertySection {

	public OrientationPropertySection() {
		super();
	}

	@Override
	Collection<String> getValues() {
		return PropertyManager.getOrientationNames();
	}

	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	String getValueAsString() {
		return getPropertyManager().getOrientation();
	}

	@Override
	void setValueAsString(String value) {
		getPropertyManager().setOrientation(value,getValueAsString());
	}

}
