package org.jclarion.clarion.ide.view.properties;

import java.util.Collection;

import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

public class StdPropertySection extends AbstractComboPropertySection {

	public StdPropertySection() {
		super();
	}

	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	Collection<String> getValues() {
		return PropertyManager.getStdNames();
	}

	@Override
	String getValueAsString() {
		return getPropertyManager().getStdName();
	}

	@Override
	void setValueAsString(String value) {
		getPropertyManager().setStdName(value);
	}

}
