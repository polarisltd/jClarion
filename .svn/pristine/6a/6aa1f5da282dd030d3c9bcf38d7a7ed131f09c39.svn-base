package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractListControl;
import org.jclarion.clarion.control.TextControl;

public class VScrollPropertySectionFilter extends AbstractPropertyObjectWrapperPropertySectionFilter {

	@Override
	boolean selectPropertyObject(PropertyObject po) {
		return (po instanceof AbstractListControl)
				|| (po instanceof TextControl)
				|| (po instanceof AbstractWindowTarget);
	}

}
