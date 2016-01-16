package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractButtonControl;

public class IconPropertySectionFilter extends AbstractPropertyObjectWrapperPropertySectionFilter {

	@Override
	boolean selectPropertyObject(PropertyObject po) {
		return (po instanceof AbstractButtonControl) || (po instanceof AbstractWindowTarget);
	}

}
