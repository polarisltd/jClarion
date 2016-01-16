package org.jclarion.clarion.ide.view.properties;


public class UsePropertySection extends AbstractTextPropertySection {

	public UsePropertySection() {
		super();
	}

	@Override
	String getLabel() {
		return "Use";
	}

	@Override
	Object getValue() {
		return getPropertyManager().getUse();
	}

	@Override
	void setValueAsString(Object priorValue, String value, boolean commit) {
		if (!commit) return;
		getPropertyManager().setUse(value);
	}
}
