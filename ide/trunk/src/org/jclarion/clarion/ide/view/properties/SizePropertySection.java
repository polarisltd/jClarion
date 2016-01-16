package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.ide.Messages;

public class SizePropertySection extends AbstractDualIntegerPropertySection {

	public SizePropertySection() {
		super(Prop.WIDTH,Prop.HEIGHT);
	}

	@Override
	String getLabel1() {
		return Messages.getString(getClass(), "Width.label");
	}

	@Override
	String getLabel2() {
		return Messages.getString(getClass(), "Height.label");
	}
}
