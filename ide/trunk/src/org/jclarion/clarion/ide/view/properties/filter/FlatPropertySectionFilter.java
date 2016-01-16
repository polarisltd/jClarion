package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.control.AbstractButtonControl;
import org.jclarion.clarion.control.AbstractControl;

public class FlatPropertySectionFilter extends AbstractControlWrapperPropertySectionFilter {

	@Override
	boolean selectControl(AbstractControl control) {
		return (control instanceof AbstractButtonControl);
	}

}
