package org.jclarion.clarion.ide.model;

import org.eclipse.core.commands.operations.UndoContext;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.ide.model.manager.PropertyManager;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

abstract public class AbstractPropertyObjectWrapper {

	public final PropertyObject po;
	public final JavaSwingProvider provider;
	public final UndoContext undoContext;

	abstract public String getName();

	public AbstractPropertyObjectWrapper(PropertyObject po, JavaSwingProvider provider, UndoContext undoContext) {
		this.po = po;
		this.provider = provider;
		this.undoContext = undoContext;
	}

	public PropertyObject getPropertyObject() {
		return po;
	}

	public PropertyManager getManager() {
		ExtendProperties ep = (ExtendProperties)po.getExtend();
		if (ep==null) return null;
		if (ep.manager==null) {
			ep.manager = new PropertyManager(po, provider, undoContext);
		}
		return ep.manager;
	}

	@Override
	public boolean equals(Object o) {
		if (!(o instanceof AbstractPropertyObjectWrapper)) {
			return false;
		}
		AbstractPropertyObjectWrapper that = (AbstractPropertyObjectWrapper) o;
		return this.po.equals(that.po);
	}

}