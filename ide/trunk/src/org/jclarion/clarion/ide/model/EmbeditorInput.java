package org.jclarion.clarion.ide.model;

import java.util.Iterator;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IPersistableElement;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class EmbeditorInput implements IEditorInput, ClarionProjectInput
{
	private Procedure 	   procedure;
	private Module  	   module;
	private AppProject     project;
	private ProcedureModel model;
	private boolean		   editModule;
	private boolean		   allEmbedPoints;
	
	public EmbeditorInput(ProcedureModel model,boolean editModule,boolean allEmbedPoints)
	{		
		this.model=model;
		this.project=model.getApp().getAppProject();
		this.procedure=model.getProcedure();
		this.module=(Module)procedure.getParent();
		this.editModule=editModule;
		this.allEmbedPoints=allEmbedPoints;
	}
	
	
	public ProcedureModel getProcedureModel()
	{
		return model;		
	}
	
	public EmbeditorInput(AppProject project,Module module,boolean allEmbedPoints)
	{		
		this.project=project;
		this.module=module;		
		Iterator<Procedure> scan  = module.getProcedures().iterator();
		if (scan.hasNext()) {
			this.procedure=scan.next();
		}
		this.editModule=true;
		this.allEmbedPoints=allEmbedPoints;
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
		if (editModule) {
			if (procedure!=null) {
				return procedure.getName()+" Module Embeditor"; 
			} else {
				return module.getName()+" Module Embeditor";
			}
		} else {
			return procedure.getName()+" Embeditor"; 
		}
	}
	
	public Procedure getProcedure()
	{
		return procedure;
	}
	
	public Module getModule()
	{
		return module;
	}
	
	public AppProject getAppProject()
	{
		return project;
	}

	public IProject getProject()
	{
		return project.getProject();
	}
	
	public boolean isEditModule() {
		return editModule;
	}

	public boolean isAllEmbedPoints() {
		return allEmbedPoints;
	}

	@Override
	public IPersistableElement getPersistable() {
		return null;
	}

	@Override
	public String getToolTipText() {
		if (procedure!=null) {
			return getProcedure().getName();
		} else {
			return getModule().getName();
		}
	}
	
	@Override
	public boolean equals(Object o)
	{
		if (o==null) return false;
		if (!(o instanceof EmbeditorInput)) return false;
		EmbeditorInput target = (EmbeditorInput)o;
		if (editModule!=target.editModule) return false;
		if (editModule) {
			return module==target.module;
		}
		return procedure==target.procedure;
	}
	
	@Override
	public int hashCode()
	{
		if (editModule) {
			return 17*module.hashCode();
		}
		return 31*procedure.hashCode();
	}

	public void save(IProgressMonitor monitor) {
		ProcedureModel.save(project, module, monitor);
	}
}
