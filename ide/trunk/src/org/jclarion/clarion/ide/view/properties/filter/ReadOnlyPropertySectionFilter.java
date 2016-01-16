package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.TextControl;

public class ReadOnlyPropertySectionFilter extends AbstractControlWrapperPropertySectionFilter {

	@Override
	boolean selectControl(AbstractControl control) {
		return (control instanceof EntryControl) || (control instanceof TextControl);
	}

}
