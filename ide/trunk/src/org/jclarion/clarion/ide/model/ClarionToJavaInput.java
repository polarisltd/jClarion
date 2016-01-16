package org.jclarion.clarion.ide.model;

import org.eclipse.core.resources.IProject;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IPersistableElement;

public class ClarionToJavaInput implements IEditorInput,ClarionProjectInput {

	public final WindowDefinitionProvider provider;

	public ClarionToJavaInput(WindowDefinitionProvider provider) {
		this.provider = provider;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Object getAdapter(Class adapter) {
		return null;
	}

	@Override
	public boolean exists() {
		return true; // We want this to appear in the MRU list
	}

	@Override
	public ImageDescriptor getImageDescriptor() {
		return null;
	}

	@Override
	public String getName() {
		return provider.getName();
	}

	@Override
	public IPersistableElement getPersistable() {
		return null;
	}

	@Override
	public String getToolTipText() {
		return getName();
	}

	@Override
	public boolean equals(Object o) {
		if (!(o instanceof ClarionToJavaInput)) {
			return false;
		}
		ClarionToJavaInput that = (ClarionToJavaInput) o;
		return that.provider.equals(provider);
	}

	public WindowDefinitionProvider getProvider() {
		return provider;
	}

	
	public IProject getProject()
	{
		return provider.getProject();
	}
}
