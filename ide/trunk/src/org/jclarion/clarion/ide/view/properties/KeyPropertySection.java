package org.jclarion.clarion.ide.view.properties;

import java.util.Collection;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

public class KeyPropertySection extends AbstractComboPropertySection {

	public KeyPropertySection() {
		super();
	}

	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	Collection<String> getValues() {
		return PropertyManager.getKeyNames();
	}

	@Override
	String getValueAsString() {
		return getPropertyManager().getString(Prop.KEY);
	}

	@Override
	void setValueAsString(String value) {
		getPropertyManager().setProp(Prop.KEY, getValueAsString(), value);
	}

}
