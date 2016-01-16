package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractReportControl;

public class BandPropertySectionFilter extends AbstractPropertyObjectWrapperPropertySectionFilter
{
	@Override
	boolean selectPropertyObject(PropertyObject po) {
		return (po instanceof AbstractReportControl);
	}

}
