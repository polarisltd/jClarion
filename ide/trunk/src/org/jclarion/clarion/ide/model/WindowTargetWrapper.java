package org.jclarion.clarion.ide.model;

import org.eclipse.core.commands.operations.UndoContext;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.ide.Messages;

public class WindowTargetWrapper extends AbstractPropertyObjectWrapper {

	private final String name;

	public WindowTargetWrapper(AbstractTarget awt, JavaSwingProvider provider, String name, UndoContext undoContext) {
		super(awt, provider, undoContext);
		this.name = name;
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return Messages.getString(getClass(), "name_pattern", name);
	}

	public AbstractTarget getTarget() {
		return (AbstractTarget) po;
	}

}
