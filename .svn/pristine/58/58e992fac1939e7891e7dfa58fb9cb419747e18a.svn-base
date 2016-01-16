package org.jclarion.clarion.ide.view.properties.filter;

import org.eclipse.jface.viewers.IFilter;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.ide.model.AbstractPropertyObjectWrapper;

abstract class AbstractPropertyObjectWrapperPropertySectionFilter implements IFilter {

	abstract boolean selectPropertyObject(PropertyObject po);

	@Override
	public final boolean select(Object toTest) {
		return (toTest instanceof AbstractPropertyObjectWrapper) &&
			selectPropertyObject(((AbstractPropertyObjectWrapper) toTest).po);
	}

}
