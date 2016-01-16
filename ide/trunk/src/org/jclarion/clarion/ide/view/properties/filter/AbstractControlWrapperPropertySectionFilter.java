package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;

abstract class AbstractControlWrapperPropertySectionFilter extends AbstractPropertyObjectWrapperPropertySectionFilter {

	abstract boolean selectControl(AbstractControl control);

	@Override
	final boolean selectPropertyObject(PropertyObject po) {
		return (po instanceof AbstractControl) && selectControl((AbstractControl) po);
	}

}
