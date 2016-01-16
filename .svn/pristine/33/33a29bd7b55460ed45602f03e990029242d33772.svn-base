package org.jclarion.clarion.ide.command;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.handlers.HandlerUtil;
import org.jclarion.clarion.ide.dialog.FindProcedureDialog;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.app.AppModel;
import org.jclarion.clarion.ide.model.app.ProcedureModel;


public class FindProcedureHandler extends AbstractHandler
{
	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException 
	{
		IWorkbenchWindow workbenchWindow = HandlerUtil.getActiveWorkbenchWindow(event);
		if (workbenchWindow == null) return null;
		
		AppModel model =null;
		
		ISelection selection = HandlerUtil.getCurrentSelection(event);
		if (selection!=null && !selection.isEmpty()) {
			if (selection instanceof IStructuredSelection) {
				IStructuredSelection ss = (IStructuredSelection) selection;
				if (!ss.isEmpty()) {
					model=figureModel(ss.getFirstElement());
				}
			}
		}
		
		
		if (model==null) {
			IEditorPart part = workbenchWindow.getActivePage().getActiveEditor();
			if (part!=null) {
				if (part instanceof AbstractClarionEditor) {
					AbstractClarionEditor scan = (AbstractClarionEditor) part;
					while (scan!=null && model==null) {
						model= figureModel(scan.getModel());
						scan=scan.getParentEditor();
					}
				}
				if (model==null) {
					Object resource = part.getEditorInput().getAdapter(IResource.class);
					if (resource!=null) {
						model=figureModel(((IResource)resource).getProject());
					}
				}
			}
		}
		
		if (model==null) return null;

		FindProcedureDialog fpd = new FindProcedureDialog();
		fpd.setInfo(model.getApp());
		fpd.setBlockOnOpen(true);
		if (fpd.open()==FindProcedureDialog.OK) {
			String result = fpd.getResult();
			model.find(result);
		}
		return null;
	}

	private AppModel figureModel(Object e) {
		if (e==null) return null; 
		if (e instanceof AppModel) return (AppModel)e;
		if (e instanceof ProcedureModel) return ((ProcedureModel)e).getApp();
		if (e instanceof IProject) {
			AppProject project = AppProject.get((IProject)e);
			if (project==null) return null;
			return project.getModel();
		}
		
		System.out.println(e.getClass());
		return null;
		
	}

}
