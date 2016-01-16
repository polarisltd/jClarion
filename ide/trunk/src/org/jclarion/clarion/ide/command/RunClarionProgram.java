package org.jclarion.clarion.ide.command;


import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.debug.core.DebugPlugin;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.ILaunchConfigurationType;
import org.eclipse.debug.core.ILaunchConfigurationWorkingCopy;
import org.eclipse.debug.core.ILaunchManager;
import org.eclipse.debug.ui.DebugUITools;
import org.eclipse.jdt.launching.IJavaLaunchConfigurationConstants;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.handlers.HandlerUtil;
import org.jclarion.clarion.ide.model.ClarionProjectInputHelper;
import org.jclarion.clarion.ide.model.app.AppModel;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class RunClarionProgram extends AbstractHandler
{
	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException {
		
		
		
		try {
			IWorkbenchWindow workbenchWindow = HandlerUtil.getActiveWorkbenchWindow(event);
			IEditorPart  editorPart = workbenchWindow.getActivePage().getActiveEditor();
			IProject project=null;
			if(editorPart  != null) {
				project=ClarionProjectInputHelper.getProject(editorPart.getEditorInput());
			}
			if (project==null) {
				ISelection selection = HandlerUtil.getCurrentSelection(event);
				if (selection instanceof IStructuredSelection && !selection.isEmpty()) {
					IStructuredSelection ss = (IStructuredSelection) selection;
					Object o = ss.getFirstElement();
					if (o instanceof IProject) {
						project=(IProject)o;
					} else if (o instanceof IResource) {
						project=((IResource)o).getProject();
					}
					if ( o instanceof ProcedureModel) {
						project = ((ProcedureModel)o).getApp().getProject().getProject();
					}
					if ( o instanceof AppModel) {
						project = ((AppModel)o).getProject().getProject();
					}
				}
			}
			if (project==null) {
                MessageBox mb = new MessageBox(workbenchWindow.getShell(),SWT.ICON_ERROR+SWT.OK);
                mb.setText("Launch Clarion App");
                mb.setMessage("Could not determine project");
                mb.open();
                return null;
			}
			
			if (!project.hasNature("jclarion.Clarion")) {
                MessageBox mb = new MessageBox(workbenchWindow.getShell(),SWT.ICON_ERROR+SWT.OK);
                mb.setText("Launch Clarion App");
                mb.setMessage("Not a Clarion Project");
                mb.open();
                return null;				
			}
			
			ILaunchManager manager = DebugPlugin.getDefault().getLaunchManager();
			ILaunchConfigurationType type = manager.getLaunchConfigurationType(IJavaLaunchConfigurationConstants.ID_JAVA_APPLICATION);
			ILaunchConfiguration[] configurations = manager.getLaunchConfigurations();
			ILaunchConfiguration configuration=null;
			for (int i = 0; i < configurations.length; i++) {
		      configuration = configurations[i];
		      if (configuration.getName().equals("Start Clarion")) {
		         break;
		     }
		      configuration=null;
		   }
			if (configuration==null) {
				ILaunchConfigurationWorkingCopy workingCopy =type.newInstance(null, "Start Clarion");
				workingCopy.setAttribute(IJavaLaunchConfigurationConstants.ATTR_MAIN_TYPE_NAME,"clarion.Main");
				workingCopy.setAttribute(IJavaLaunchConfigurationConstants.ATTR_PROJECT_NAME,project.getName());
				configuration = workingCopy.doSave();
			}
		   DebugUITools.launch(configuration, ILaunchManager.RUN_MODE);
		   
		} catch (CoreException e) {
			e.printStackTrace();
		}
		return null;
	}

}
