package org.jclarion.clarion.ide.view.navigator;

import java.net.URL;
import java.util.List;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.FileLocator;
import org.eclipse.core.runtime.Path;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.viewers.ILabelProvider;
import org.eclipse.jface.viewers.ILabelProviderListener;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.swt.graphics.Image;
import org.eclipse.ui.navigator.CommonViewer;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.app.AbstractModel;
import org.jclarion.clarion.ide.model.app.AppModel;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.osgi.framework.Bundle;


public class AppProcedure implements ITreeContentProvider, ILabelProvider 
{
	
	private CommonViewer viewer;

	public AppProcedure()
	{
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
		this.viewer = (CommonViewer)viewer;
	}

	@Override
	public void addListener(ILabelProviderListener listener) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean isLabelProperty(Object element, String property) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void removeListener(ILabelProviderListener listener) {
		// TODO Auto-generated method stub
		
	}

	private static Image blankProcedure=getImage("icons/proc-blank.png");
	private static Image embedProcedure=getImage("icons/proc-embed.png");
	private static Image globalProcedure=getImage("icons/proc-global.png");
	private static Image orphanedProcedure=getImage("icons/proc-orphaned.png");
	
	
	  private static Image getImage(String file) {
		   
		    Bundle bundle = Platform.getBundle("clarion-ide");
		    URL url = FileLocator.find(bundle, new Path(file), null);
		    ImageDescriptor image = ImageDescriptor.createFromURL(url);
		    return image.createImage();
		  }
	  
	@Override
	public Image getImage(Object element) {
		if (element instanceof ProcedureModel) {
			ProcedureModel pm = (ProcedureModel)element;
			if (pm.getProcedure()==null) {
				return blankProcedure;
			}
			if (pm.getProcedure().isGlobal()) {
				return globalProcedure;
			}
			if (pm.isOrphaned()) {
				return orphanedProcedure;
			}
			if (pm.getProcedure().getEmbeds().iterator().hasNext()) {
				return embedProcedure;				
			} else {
				return blankProcedure;
			}
		}
		return null;
	}

	@Override
	public String getText(Object element) {
		return element.toString();
	}

	@Override
	public Object[] getElements(Object inputElement) {
		return getChildren(inputElement);
	}

	@Override
	public Object[] getChildren(Object parentElement) {
		
		if (parentElement instanceof IProject) {
			IProject project = (IProject)parentElement;
			AppProject o = AppProject.get(project);		
			if (o==null || o.getApp()==null) return null;
			return new Object[] { new AppModel(o,project,viewer) };
		}
		
		if (parentElement instanceof AbstractModel) {
			List<AbstractModel> kids = ((AbstractModel) parentElement).getChildren(); 
			return kids.toArray(new AbstractModel[kids.size()]);
		}
		return null;
	}

	@Override
	public Object getParent(Object element) {
		if (element instanceof AbstractModel) {
			return ((AbstractModel)element).getParent();
		}
		return null;
	}

	@Override
	public boolean hasChildren(Object element) {
		if (element instanceof AbstractModel) {
			return !((AbstractModel)element).getChildren().isEmpty();
		}
		return false;
	}

}
