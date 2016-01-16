package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.constants.Prop;

public class RatioSizePropertySection extends AbstractDualIntegerPropertySection {

	public RatioSizePropertySection() {
		super(Prop.RATIO_WIDTH,Prop.RATIO_HEIGHT);
	}

	@Override
	String getLabel1() {
		return "R Width";
	}

	@Override
	String getLabel2() {
		return "R Height";
	}
}
