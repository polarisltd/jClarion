package org.jclarion.clarion.ide.command;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.window.Window;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.handlers.HandlerUtil;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.dialog.CopyProcedureDialog;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.model.app.ProcedureNameSave;
import org.jclarion.clarion.ide.model.app.ProcedureSaveListener;


public class CopyProcedureHandler extends AbstractHandler
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
		
		String name = model.getName();
		int last=1;
		int end=name.length();
		while (end>0) {
			char c = name.charAt(end-1);
			if (c>='0' && c<='9') {
				end=end-1;
			} else {
				break;
			}
		}
		if (end!=name.length()) {
			last=Integer.parseInt(name.substring(end));
			name=name.substring(0,end);
		}
		String prefix=name;
		while ( true ) {
			last++;
			name=prefix+last;
			if (model.getApp().getApp().getProcedure(name)==null) {
				break;
			}
		}
		
		CopyProcedureDialog dialog = new CopyProcedureDialog();
		dialog.setInfo(model.getApp().getApp(), name);
		dialog.setBlockOnOpen(true);
		if (dialog.open()!=Window.OK) return null;
		
		
		Procedure clone = new Procedure(model.getProcedure());
		clone.setParent(null);
		clone.setName(dialog.getName());
		clone.getOldName(true);

		Module m = model.getApp().getAppProject().createNewModule(dialog.getName(),clone.getBase().getChain());
		m.addProcedure(clone);
		model.getApp().getApp().addModule(m);
		
		// prep prompts
		model.save(clone,null);
		
		for (ProcedureSaveListener psl : ProcedureNameSave.get(model.getApp().getApp(),dialog.getName())) {
			psl.procedureSaved();
		}	
		if (model.getApp().reloadChildren()) {
			model.getApp().getViewer().refresh(model.getApp());
		}
		return null;
	}

}
