package org.jclarion.clarion.ide.view.properties.filter;

import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.PropertyObject;

public class ReportPropertySectionFilter extends AbstractPropertyObjectWrapperPropertySectionFilter
{
	@Override
	boolean selectPropertyObject(PropertyObject po) {
		return po instanceof ClarionReport;
	}

}
