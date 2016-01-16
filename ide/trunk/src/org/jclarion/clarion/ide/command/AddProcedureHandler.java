package org.jclarion.clarion.ide.command;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.handlers.HandlerUtil;
import org.jclarion.clarion.ide.dialog.CreateProcedureDialog;
import org.jclarion.clarion.ide.model.app.ProcedureModel;


public class AddProcedureHandler extends AbstractHandler
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
		if (model.getProcedure()!=null) return null;
		
		CreateProcedureDialog d = new CreateProcedureDialog();
		d.setInfo(model);
		d.setBlockOnOpen(true);
		d.open();
		return null;
	}

}
