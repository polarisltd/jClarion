package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.TextControl;

public class TextControlPropertySectionFilter extends AbstractControlWrapperPropertySectionFilter {

	@Override
	boolean selectControl(AbstractControl control) {
		return (control instanceof TextControl);
	}

}
