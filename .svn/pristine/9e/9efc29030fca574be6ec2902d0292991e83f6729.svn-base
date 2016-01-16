package org.jclarion.clarion.ide.editor;



import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.IFormPage;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.model.ClarionControlEmbedInput;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class ClarionControlEmbedEditor extends FormEditor implements AbstractClarionEditor, EditorClosedListener,EmbedProvider
{
	private EditorCloseProducer tracker=new EditorCloseProducer(); 
	
	@Override
	public void init(IEditorSite site, IEditorInput input) throws PartInitException 
	{
		super.init(site, input);
		setPartName(getEditorInput().getName());
		ClarionControlEmbedInput i = (ClarionControlEmbedInput)input;
		i.getEditor().addEditorCloseListener(this);
		
	}

	private EmbedHelper embedHelper;
	
	@Override
	public void doSave(IProgressMonitor monitor) 
	{
		if (embedHelper!=null) {
			if (embedHelper.isDirty()) {
				embedHelper.save();
			}
		}
		
		for (Object scan : pages) {
			if (scan instanceof IFormPage) {
				((IFormPage)scan).doSave(monitor);
			}
		}
		editorDirtyStateChanged();
		((ClarionControlEmbedInput)getEditorInput()).getEditor().restoreFocus();			
	}

	@Override
	public void doSaveAs() {		
	}

	@Override
	public boolean isSaveAsAllowed() {
		return false;
	}
	
	@Override
	public void dispose()
	{
		super.dispose();
		((ClarionControlEmbedInput)getEditorInput()).getEditor().removeEditorCloseListener(this);
		tracker.fire();
		if (embedHelper!=null) embedHelper.dispose();
	}

	@Override
	public void addEditorCloseListener(EditorClosedListener listener) {
		tracker.addEditorCloseListener(listener);
	}

	@Override
	public void removeEditorCloseListener(EditorClosedListener listener) {
		tracker.removeEditorCloseListener(listener);
	}

	@Override
	public void restoreFocus() 
	{
		getEditorSite().getPage().activate(this);
	}

	@Override
	protected void addPages() {
		try {
			addPage(new EmbedEditor(this,"org.jclarion.clarion.ide.editor.EmbedTree","Embeds",this));
		} catch (PartInitException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Procedure getDirtyProcedure() {
		return ((ClarionControlEmbedInput)getEditorInput()).getEditor().getDirtyProcedure();
	}
	
	@Override
	public ProcedureModel getModel() {
		return ((ClarionControlEmbedInput)getEditorInput()).getEditor().getModel();
	}

	@Override
	public void editorClosed() {
		close(false);
	}

	@Override
	public EmbedHelper getEmbedHelper() {
		if (embedHelper==null) {
			// find the parent
			AbstractClarionEditor ace = getParentEditor();
			while (ace!=null) {
				if (ace instanceof EmbedProvider) {
					embedHelper=new EmbedHelper(((EmbedProvider)ace).getEmbedHelper());
					break;
				}
				ace=ace.getParentEditor();					
			}
		}
		return embedHelper;
	}

	@Override
	public AbstractClarionEditor getParentEditor() {
		return ((ClarionControlEmbedInput)getEditorInput()).getEditor();
	}
}
