package org.jclarion.clarion.ide.view.properties;

import jclarion.Activator;

import org.eclipse.core.runtime.Assert;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.ide.model.AbstractPropertyObjectWrapper;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

/**
 * Handles the setting of the input and provides convenience methods for the
 * creation of property section forms
 */
abstract class AbstractPropertyObjectWrapperPropertySection extends AbstractJClarionPropertySection
		implements PropertyObjectListener {

	private AbstractPropertyObjectWrapper wrapper;

	public AbstractPropertyObjectWrapperPropertySection() {
		// Empty
	}

	@Override
	public void dispose() {
		super.dispose();
		setWrapper(null);
	}

	/**
	 * Calls {@link #refresh()} whenever the property changes
	 */
	@Override
	public void propertyChanged(PropertyObject owner, int property, ClarionObject value) {
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				refresh();
			}
		});
	}

	/**
	 * Default implementation returns <code>null</code>
	 */
	@Override
	public Object getProperty(PropertyObject owner, int property) {
		return null;
	}

	@Override
	final void doSetInput(Object input) {
	    Assert.isTrue(input instanceof AbstractPropertyObjectWrapper);
	    setWrapper((AbstractPropertyObjectWrapper) input);
	}

	final PropertyManager getPropertyManager() {
		return wrapper.getManager();
	}
	
	public PropertyObject getObject()
	{
		return wrapper.po;
	}

	private void setWrapper(AbstractPropertyObjectWrapper wrapper) {
		if (this.wrapper != null) {
			this.wrapper.po.removeListener(this);
		}
	    this.wrapper = wrapper;
	    if (wrapper != null) {
	    	wrapper.po.addListener(this);
	    }
	}
}
