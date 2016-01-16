package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.RadioControl;

public class RadioControlPropertySectionFilter extends AbstractControlWrapperPropertySectionFilter {

	@Override
	boolean selectControl(AbstractControl control) {
		return (control instanceof RadioControl);
	}

}
