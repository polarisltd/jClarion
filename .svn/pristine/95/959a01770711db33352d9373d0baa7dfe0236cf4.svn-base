package org.jclarion.clarion.ide.command;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.handlers.HandlerUtil;
import org.jclarion.clarion.ide.model.EmbeditorInput;
import org.jclarion.clarion.ide.model.app.ProcedureModel;


public class OpenProcedureSourceHandler extends AbstractHandler
{
	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException 
	{
		IWorkbenchWindow workbenchWindow = HandlerUtil.getActiveWorkbenchWindow(event);
		if (workbenchWindow == null) {
			return null;
		}

		ISelection selection = HandlerUtil.getCurrentSelection(event);
		if (selection instanceof IStructuredSelection && !selection.isEmpty()) {
			IStructuredSelection ss = (IStructuredSelection) selection;

			ProcedureModel model = (ProcedureModel) ss.getFirstElement();
			
			try {
				workbenchWindow.getActivePage().openEditor(new EmbeditorInput(model,false,true),"org.jclarion.clarion.ide.editor.ClarionIncEditor");
			} catch (PartInitException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		
		return null;
	}

}
