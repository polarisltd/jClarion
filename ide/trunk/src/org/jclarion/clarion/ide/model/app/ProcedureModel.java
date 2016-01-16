package org.jclarion.clarion.ide.model.app;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.app.TextAppStore;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.util.SharedOutputStream;

public class ProcedureModel extends AbstractModel implements ProcedureSaveListener 
{
	private Procedure 				procedure;
	private boolean 				orphaned;
	
	
	public ProcedureModel(String name,AbstractModel parent,Procedure procedure)
	{
		super(name,parent);
		this.procedure=procedure;
	}
	
	public void init()
	{
		if (procedure!=null) {
			ProcedureSave.get(procedure).add(this);
		} else {
			ProcedureNameSave.get(getApp().getApp(),getName()).add(this);
		}		
	}
	
	public AppModel getApp()
	{
		AbstractModel scan = getParent();
		while (!(scan instanceof AppModel)) {
			scan=scan.getParent();
		}
		return (AppModel)scan;
	}
	
	public Procedure getProcedure() {
		return procedure;
	}

	public String toString()
	{
		if (procedure==null) {
			return getName()+" <TODO>";
		}
		if (procedure.getBase()!=null && procedure.getBase().getType()!=null) {
			return procedure.getName()+" ("+procedure.getBase().getType()+")";
		} else {
			return procedure.getName();
		}
	}

	public boolean isOrphaned() {
		return orphaned;
	}

	public void setOrphaned(boolean orphaned) {
		this.orphaned = orphaned;
	}

	@Override
	public void delete()
	{
		if (procedure!=null) {
			ProcedureSave.get(procedure).remove(this);
		} else {
			ProcedureNameSave.get(getApp().getApp(),getName()).remove(this);
		}
	}

	public void save(IProgressMonitor monitor) {
		save(procedure,monitor);
	}
		
	public void save(Procedure procedure,IProgressMonitor monitor) {
		
		save(getApp().getAppProject(),(Module)procedure.getParent(),monitor);
		
	}

	public void save(Module module,IProgressMonitor monitor) 
	{
		save(getApp().getAppProject(),module,monitor);
	}
	
	public static void save(AppProject project,Module module,IProgressMonitor monitor) 
	{
		IFile file = (IFile)module.getSource();
		boolean exists=file.exists();
		
		SharedOutputStream sos = new SharedOutputStream();
		PrintStream ps = new PrintStream(sos);
		TextAppStore store = new TextAppStore(project.getChain());
		store.setTarget(ps);		
		store.serializeModule(module);
		ps.close();
		
		try {
			if (!exists) {
				file.create(sos.getInputStream(),true,monitor);
			} else {
				file.setContents(sos.getInputStream(),true,false,monitor);
			}
		} catch (CoreException ex) {
			ex.printStackTrace();
		}	
		
		for (Procedure procedure : module.getProcedures()) {
			if (exists) {
				for (ProcedureSaveListener psl : ProcedureSave.get(procedure)) {
					psl.procedureSaved();
				}
		
				if (procedure.getOldName(true)!=null) {
					for (ProcedureSaveListener psl : ProcedureNameSave.get(project.getApp(),procedure.getName())) {
						psl.procedureSaved();
					}	
				}
			} else {
				procedure.getOldName(true);
				for (ProcedureSaveListener psl : ProcedureNameSave.get(project.getApp(),procedure.getName())) {
					psl.procedureSaved();
				}
			}
		}
	}
	
	
	
	@Override
	public List<AbstractModel> loadChildren() {
		App a = getApp().getApp();
		List<AbstractModel> kids = new ArrayList<AbstractModel>();
		if (procedure!=null) {
			for (String scan : procedure.getAllCalls()) {
				Procedure x = a.getProcedure(scan);
				kids.add(new ProcedureModel(scan,this,x));
			}
		}
		return kids;
	}
	
	@Override
	public int hashCode()
	{
		return getName().hashCode()*17+(procedure!=null ? procedure.hashCode() : 0);
	}
	
	@Override
	public boolean equals(Object o) {
		if (o==null) return false;
		if (o.getClass()!=getClass()) return false;
		ProcedureModel model = (ProcedureModel)o;
		if (model.procedure!=procedure) return false;
		return getName().equals(model.getName());
	}
	
	@Override
	public void procedureSaved() 
	{
		if (procedure==null) {
			if (getParent().reloadChildren()) {
				getApp().getViewer().refresh(getParent());	
			}			
			return;
		}
		
		if (!getName().equals(procedure.getName())) {
			// procedure name change
			setName(procedure.getName());
			if (getParent().reloadChildren()) {
				getApp().getViewer().refresh(getParent());	
			}			
			if (getParent()!=getApp() && getApp().reloadChildren()) {
				getApp().getViewer().refresh(getApp());
			}
		}
		
		if (reloadChildren()) {
			getApp().getViewer().refresh(this);
			if (getApp().reloadChildren()) {
				getApp().getViewer().refresh(getApp());
			}
		}
	}

	public void setProcedure(Procedure p) {
		procedure=p;
	}
	
	public void update()
	{
		getApp().getViewer().refresh(this,true);	
	}

	@Override
	public void procedureDeleted() 
	{
		getParent().reloadChildren();
		getApp().getViewer().refresh(getParent());	
	}

	
}
