package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.constants.Prop;

public class RatioPositionPropertySection extends AbstractDualIntegerPropertySection {

	public RatioPositionPropertySection() {
		super(Prop.RATIO_X,Prop.RATIO_Y);
	}

	@Override
	String getLabel1() {
		return "X Ratio";
	}

	@Override
	String getLabel2() {
		return "Y Ratio";
	}
}
