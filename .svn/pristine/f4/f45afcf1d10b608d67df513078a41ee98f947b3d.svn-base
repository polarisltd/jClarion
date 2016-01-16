package org.jclarion.clarion.ide.model;

import java.util.HashMap;
import java.util.Map;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.IAdapterFactory;

public class AppProjectFactory implements IAdapterFactory
{
	private Map<IProject,AppProject> project=new HashMap<IProject,AppProject>(); 
	
	
	@Override
	@SuppressWarnings("rawtypes")
	public Object getAdapter(Object adaptableObject, Class adapterType) {
		IProject p = (IProject)adaptableObject;
		if (!p.isOpen()) return null;
		AppProject proj = project.get(adaptableObject);
		if (proj==null) {			
			proj=new AppProject(p);
			project.put(p,proj);
		}
		return proj;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Class[] getAdapterList() {
		return null;
	}

}
