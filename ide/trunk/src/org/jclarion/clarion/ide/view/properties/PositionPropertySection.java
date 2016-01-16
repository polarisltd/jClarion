package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.ide.Messages;

public class PositionPropertySection extends AbstractDualIntegerPropertySection {

	public PositionPropertySection() {
		super(Prop.XPOS,Prop.YPOS);
	}

	@Override
	String getLabel1() {
		return Messages.getString(getClass(), "X.label");
	}

	@Override
	String getLabel2() {
		return Messages.getString(getClass(), "Y.label");
	}
}
