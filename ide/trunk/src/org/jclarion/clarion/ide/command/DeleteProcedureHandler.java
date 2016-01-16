package org.jclarion.clarion.ide.command;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.handlers.HandlerUtil;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.model.app.ProcedureSave;
import org.jclarion.clarion.ide.model.app.ProcedureSaveListener;


public class DeleteProcedureHandler extends AbstractHandler
{
	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException 
	{
		IWorkbenchWindow workbenchWindow = HandlerUtil.getActiveWorkbenchWindow(event);
		if (workbenchWindow == null) return null;
		ISelection selection = HandlerUtil.getCurrentSelection(event);
		if (selection.isEmpty()) return null;
		if (!(selection instanceof IStructuredSelection)) return null;
		IStructuredSelection ss = (IStructuredSelection) selection;
		ProcedureModel model = (ProcedureModel) ss.getFirstElement();
		if (model.getProcedure()==null) return null;
		
		MessageBox mb = new MessageBox(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(),
				SWT.ICON_QUESTION+SWT.YES+SWT.NO);
		mb.setText("Delete");
		mb.setMessage("Are you sure you want to delete this?");
		if (mb.open()!=SWT.YES) return null;
		
		Procedure p = model.getProcedure();
		Module parent=  (Module)p.getParent();
		parent.deleteProcedure(p);
		model.getApp().getApp().deleteProcedure(p);
		
		if (!parent.getProcedures().iterator().hasNext()) {
			model.getApp().getApp().deleteModule(parent);
			try {
				((IFile)parent.getSource()).delete(true,null);
			} catch (CoreException e) {
				e.printStackTrace();
			}
		} else {
			model.save(parent, null);
		}
		
		for (ProcedureSaveListener psl : ProcedureSave.get(model.getProcedure())) {
			psl.procedureDeleted();
		}	
		return null;
	}

}
