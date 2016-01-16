package org.jclarion.clarion.ide.view.properties;

import org.jclarion.clarion.constants.Prop;

public class RatioPropertySection extends AbstractStringPropertySection {

	public RatioPropertySection() {
		super(Prop.RATIO);
	}

	@Override
	String getLabel() {
		return "Ratio";
	}
	
	
}
