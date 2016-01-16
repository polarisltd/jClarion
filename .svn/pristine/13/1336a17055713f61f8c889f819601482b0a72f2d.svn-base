package org.jclarion.clarion.ide.model.app;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.eclipse.core.resources.IProject;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.TreePath;
import org.eclipse.jface.viewers.TreeSelection;
import org.eclipse.ui.navigator.CommonViewer;
import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.view.navigator.AppProcedure;

public class AppModel extends AbstractModel
{

	private AppProject app;
	private IProject project;
	private CommonViewer viewer;

	public AppModel(AppProject app, IProject project,CommonViewer viewer) {
		super(app.getApp().getName(),null);
		this.app = app;
		this.project = project;
		this.viewer=viewer;
		app.setAppModel(this);
	}
	
	public void find(String procedureName)
	{
		AppProcedure scanner = new AppProcedure();		
		LinkedList<ProcedureModel> toScan = new LinkedList<ProcedureModel>();
		for (Object o : scanner.getChildren(this)) {
			toScan.add((ProcedureModel)o);
		}
		
		ProcedureModel match=null;
		
		main :while ( !toScan.isEmpty() ) {
			
			LinkedList<ProcedureModel> nextScan = new LinkedList<ProcedureModel>();
			
			for (ProcedureModel scan : toScan) {
				if (scan.getName().equalsIgnoreCase(procedureName)) {
					match=scan;
					break main;
				}
				
				//check if recursive
				ProcedureModel parent=scan;
				while (parent!=null) {
					if (parent.getParent() instanceof ProcedureModel) {
						parent=(ProcedureModel)parent.getParent();
						if (parent.equals(scan)) break;
					} else {
						parent=null;
					}
				}
				if (parent!=null) continue; 
				
				for (Object o : scanner.getChildren(scan)) {
					nextScan.add((ProcedureModel)o);
				}				
			}
			toScan=nextScan;
		}

		

		if (match!=null) {
			
			LinkedList<Object> path = new LinkedList<Object>();
			AbstractModel scan = match;
			while (scan!=null) {
				path.addFirst(scan);
				scan=scan.getParent();
			}
			path.addFirst(this.project);
			
			StructuredSelection ss =new TreeSelection(new TreePath(path.toArray()));
			viewer.setSelection(ss,true);
		}		
	}
	
	public CommonViewer getViewer()
	{
		return viewer;
	}

	public App getApp() {
		return app.getApp();
	}

	public AppProject getAppProject() {
		return app;
	}

	public IProject getProject() {
		return project;
	}

	public String toString() {
		return (app.getApp() != null) ? app.getApp().getName() : Messages .getString(getClass(), "default_name");
	}

	@Override
	public List<AbstractModel> loadChildren() 
	{
		Map<String,Procedure>  rootProcedures=new LinkedHashMap<String,Procedure>();
		Map<String,Procedure>  unknownProcedures=new LinkedHashMap<String,Procedure>();
		
		if (app == null) {
			return null;
		}

		for (Module m : app.getApp().getModules()) {
			for (Procedure p : m.getProcedures()) {
				if (p.getName().equals(app.getApp().getProcedure())) {
					rootProcedures.put(p.getName(),p);
				} 
				unknownProcedures.put(p.getName(),p);
			}
		}
		
		for (Procedure keep : rootProcedures.values()) {
			removeProcedure(unknownProcedures,keep);
		}
		
		List<AbstractModel> result = new ArrayList<AbstractModel>();
		for (Procedure base : rootProcedures.values()) {
			result.add(new ProcedureModel(base.getName(),this,base));
		}
		
		if (!unknownProcedures.isEmpty()) {
			List<Procedure> scan = new ArrayList<Procedure>(unknownProcedures.values());
			for (Procedure test : scan ) {
				if (!unknownProcedures.containsKey(test.getName())) continue;
				removeProcedure(unknownProcedures,test);
				unknownProcedures.put(test.getName(),test);
			}
			for (Procedure base : unknownProcedures.values()) {			
				ProcedureModel o=new ProcedureModel(base.getName(),this,base);
				o.setOrphaned(true);
				result.add(o);
			}
			
		}

		return result;
	}
	
	private void removeProcedure(Map<String, Procedure> unknownProcedures,Procedure remove) {
		unknownProcedures.remove(remove.getName());
		for (String name : remove.getAllCalls()) {
			Procedure child = unknownProcedures.get(name);
			if (child==null) continue;
			removeProcedure(unknownProcedures,child);
		}
	}
	
	@Override
	public int hashCode()
	{
		return app.getApp().hashCode();
	}
	
	@Override
	public boolean equals(Object o) {
		if (o==null) return false;
		if (o.getClass()!=getClass()) return false;
		AppModel model = (AppModel)o;
		return model.app.getApp()==app.getApp();
	}

	@Override
	public void init() {
	}
	
}
