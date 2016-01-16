package org.jclarion.clarion.ide.view.properties;


public class LabelPropertySection extends AbstractTextPropertySection {

	public LabelPropertySection() {
		super();
	}

	@Override
	String getLabel() {
		return "Label";
	}

	@Override
	Object getValue() {
		return getPropertyManager().getLabel();
	}

	@Override
	void setValueAsString(Object priorValue, String value, boolean commit) {
		if (!commit) return;
		getPropertyManager().setLabel(value);
	}
}
