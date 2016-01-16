package org.jclarion.clarion.ide.view.properties;


public class PrePropertySection extends AbstractTextPropertySection {

	public PrePropertySection() {
		super();
	}

	@Override
	String getLabel() {
		return "Prefix";
	}

	@Override
	Object getValue() {
		return getPropertyManager().getPre();
	}

	@Override
	void setValueAsString(Object priorValue, String value, boolean commit) {
		if (!commit) return;
		getPropertyManager().setPre(value);
	}
}
