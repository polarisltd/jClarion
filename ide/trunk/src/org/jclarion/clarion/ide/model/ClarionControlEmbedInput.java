package org.jclarion.clarion.ide.model;

import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IPersistableElement;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;

public class ClarionControlEmbedInput implements IEditorInput, ClarionEditorInput
{
	private AbstractClarionEditor baseEditor;
	private String control;

	public ClarionControlEmbedInput(AbstractClarionEditor baseEditor,String control)
	{
		this.baseEditor=baseEditor;
		this.control=control;
	}
	
	public String getControl()
	{
		return control;
	}

	@Override
	public Object getAdapter(@SuppressWarnings("rawtypes") Class adapter) {
		return Platform.getAdapterManager().getAdapter(this, adapter);
	}

	@Override
	public boolean exists() {
		return true;
	}
	
	@Override
	public ImageDescriptor getImageDescriptor() {
		return null;
	}

	@Override
	public String getName() {
		return baseEditor.getModel().getName()+" "+control+" Embeds";
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
	public int hashCode() {
		return baseEditor.getModel().hashCode()*17+control.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof ClarionControlEmbedInput)) return false;
		ClarionControlEmbedInput base = (ClarionControlEmbedInput)obj;
		return base.baseEditor.getModel()==baseEditor.getModel() && base.control.equals(control);
	}

	@Override
	public AbstractClarionEditor getEditor() {
		return baseEditor;
	}

}
