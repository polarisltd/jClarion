package org.jclarion.clarion.ide.view;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.swt.SWT;
import org.eclipse.swt.dnd.Clipboard;
import org.eclipse.swt.dnd.TextTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Label;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IEditorReference;
import org.eclipse.ui.IPartListener2;
import org.eclipse.ui.IWorkbenchPartReference;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.actions.ActionFactory;
import org.eclipse.ui.handlers.IHandlerActivation;
import org.eclipse.ui.handlers.IHandlerService;
import org.eclipse.ui.part.ViewPart;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.editor.FieldTransfer;


public class ClarionFields extends ViewPart
{
	private Composite parent;
	private FieldTreeHelper helper;
	private IHandlerActivation copyHandler;
	private Clipboard clipboard;
	
	@Override
	public void createPartControl(Composite parent) {
		this.parent=parent;
		
		PlatformUI.getWorkbench().getActiveWorkbenchWindow().getPartService().addPartListener(new IPartListener2()
		{
			@Override
			public void partActivated(IWorkbenchPartReference partRef) {
				if (partRef instanceof IEditorReference) {
					setEditor( ((IEditorReference)partRef).getEditor(false));
				}
			}

			@Override
			public void partBroughtToTop(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partClosed(IWorkbenchPartReference partRef) {
				if (partRef instanceof IEditorReference) {
					clearEditor( ((IEditorReference)partRef).getEditor(false));
				}				
			}

			@Override
			public void partDeactivated(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partOpened(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partHidden(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partVisible(IWorkbenchPartReference partRef) {
			}

			@Override
			public void partInputChanged(IWorkbenchPartReference partRef) {
			}
			
		});
		
		clipboard = new Clipboard(getSite().getShell().getDisplay());
		
		AbstractHandler ah = new AbstractHandler() {
			@Override
			public boolean isEnabled()
			{
				return helper!=null;
			}

			@Override
			public Object execute(ExecutionEvent event) throws ExecutionException 
			{
				String name = helper.getFieldName();
				if (name==null) return null;
				TextTransfer tt = TextTransfer.getInstance();	
				FieldTransfer ft = FieldTransfer.getInstance();
				clipboard.setContents(new Object[] { helper.getFieldDefinition(false),name } ,new Transfer[] { ft,tt });
				return null;
			}
		};
		IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);		
		copyHandler=handlerService.activateHandler(ActionFactory.COPY.getCommandId(),ah);
		
		setEditor(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().getActiveEditor());	
		
		
	}
	
	
	private void setEditor(IEditorPart ed) {
		if (ed!=null && (ed instanceof AbstractClarionEditor)) {
			AbstractClarionEditor newEditor = (AbstractClarionEditor)ed;
			
			while (newEditor.getModel()==null && newEditor.getParentEditor()!=null) {
				newEditor=newEditor.getParentEditor();
			}
			
			if (helper!=null && helper.isSameAs(newEditor)) {
				return;
			}
			if (helper!=null) {
				helper.dispose();
			}
			helper=new FieldTreeHelper(newEditor,parent);
			if (!helper.isValid()) {
				helper=null;
			}
		} else {
			if (helper!=null) {
				helper.dispose();
			}
			helper=null;
		}
	
		for (Control c : parent.getChildren()) {
			c.dispose();
		}
		
		if (helper==null) {
			Label t = new Label(parent,SWT.NONE);
			t.setText("No Clarion Editor Selected");
			
		} else {
			helper.getViewer();
		}
		parent.layout(true);
		parent.redraw();
	}

	private void clearEditor(IEditorPart editor) {
		if (helper!=null && helper.getEditor()==editor) {
			setEditor(null);
		}
	}
	

	@Override
	public void dispose() {
		if (copyHandler!=null) {
			IHandlerService handlerService = (IHandlerService) getSite().getService(IHandlerService.class);		
			handlerService.deactivateHandler(copyHandler);	
			copyHandler=null;
		}
		clipboard.dispose();
		super.dispose();
	}



	@Override
	public void setFocus() {
	}
}
