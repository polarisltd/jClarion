package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.ide.Messages;

public class OrientationOffsetPropertySection extends AbstractTextPropertySection {

	public OrientationOffsetPropertySection() {
	}

	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	Integer getValue() {
		return getPropertyManager().getOrientationOffset();
	}

	@Override
	void setValueAsString(Object priorValue, String value, boolean commit) {
		Integer ivalue = null;
		if (value!=null && value.trim().length()>0) {
			try {
				ivalue=Integer.parseInt(value);
			} catch (NumberFormatException ex) { }
		}		
		if (commit) {
			getPropertyManager().setOrientationOffset((Integer)priorValue,ivalue);
		}
	}

}
