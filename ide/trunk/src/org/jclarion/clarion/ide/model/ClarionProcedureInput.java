package org.jclarion.clarion.ide.model;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IPersistableElement;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class ClarionProcedureInput implements IEditorInput, ClarionProjectInput
{
	private ProcedureModel procedure;

	public ClarionProcedureInput(ProcedureModel procedure)
	{
		this.procedure=procedure;
	}

	@Override
	public Object getAdapter(@SuppressWarnings("rawtypes") Class adapter) {
		return Platform.getAdapterManager().getAdapter(this, adapter);
	}

	@Override
	public boolean exists() {
		return true;
	}
	
	public ProcedureModel getModel()
	{
		return procedure;
	}

	@Override
	public ImageDescriptor getImageDescriptor() {
		return null;
	}

	@Override
	public String getName() {
		return procedure.getProcedure().getName();
	}

	@Override
	public IPersistableElement getPersistable() {
		return null;
	}

	@Override
	public String getToolTipText() {
		return procedure.getProcedure().getName();
	}

	@Override
	public int hashCode() {
		return procedure.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof ClarionProcedureInput)) return false;
		return ( ((ClarionProcedureInput)obj).procedure.getProcedure()==this.procedure.getProcedure());
	}

	@Override
	public IProject getProject() {
		return procedure.getApp().getAppProject().getProject();
	}
	
	

}
