package org.jclarion.clarion.ide.editor;


import java.util.List;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorSite;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.forms.editor.FormEditor;
import org.eclipse.ui.forms.editor.IFormPage;
import org.jclarion.clarion.appgen.app.Addition;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.ClarionProcedureInput;
import org.jclarion.clarion.ide.model.WindowDefinitionProvider;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class ClarionProcedureEditor extends FormEditor implements WindowDefinitionProvider, EmbedProvider
{
	@Override
	public void init(IEditorSite site, IEditorInput input) throws PartInitException 
	{
		super.init(site, input);
		setPartName(getEditorInput().getName());
	}
	
	// dirty model of the procedure is tracked here instead of tabs because we have potentially two different tabs
	// that can edit prompts.  Procedure properties and extension editor
	private Procedure dirtyProcedure;
	private boolean	  isDirty;
	private EditorCloseProducer tracker=new EditorCloseProducer(); 
	
	
	public ProcedureModel getProcedure()
	{
		ClarionProcedureInput input = (ClarionProcedureInput)getEditorInput();
		return input.getModel();
	}
	
	public Procedure getDirtyProcedure()
	{
		if (dirtyProcedure==null) {
			dirtyProcedure=new Procedure(getProcedure().getProcedure());
			dirtyProcedure.meta().setObject("OriginalWindow",dirtyProcedure.getWindow());
		}
		return dirtyProcedure;
	}
	
	public void prompt(final AtSource src,final Runnable r) 
	{
		AppProject project = getProcedure().getApp().getAppProject();
		ExecutionEnvironment env = project.getEnvironment(true);
		env.setAlternative(getProcedure().getProcedure(),getDirtyProcedure());
		if (getProcedure().getApp().getAppProject().prompt(env,src)) {
			src.meta().setObject("PromptDirty",true);
			isDirty=true;
			editorDirtyStateChanged();
			if (r!=null) {
				r.run();							
			}
		};
	}
	

	

	@Override
	public boolean isDirty() {
		if (isDirty) return true;
		return super.isDirty();
	}
	
	public void setDirty()
	{
		isDirty=true;
		editorDirtyStateChanged();
	}
	
	private void logSave(String log)
	{
		//System.out.println(log);
	}

	@Override
	public void doSave(IProgressMonitor monitor) 
	{
		if (dirtyProcedure!=null) {
			
			Procedure target = getProcedure().getProcedure();
			
			// prune additions that were explicitly removed
			@SuppressWarnings("unchecked")
			List<Addition> scan = (List<Addition>) dirtyProcedure.meta().getObject("DeletedAdditions");
			if (scan!=null) {
				for (Addition a : scan) {
					a=  (Addition)a.meta().getObject("Original");
					if (a!=null) {
						logSave("Deleting Addition "+a);
						a.delete();
					}
				}
			}
			
			// merge in rest
			for (Addition a : dirtyProcedure.getAllAdditions()) {
				Addition original = (Addition)a.meta().getObject("Original");
				if (original==null) {
					// new 
					if (a.getParentAddition()==null) {
						logSave("Adding base addition "+a);
						target.addAddition(a);
					} else {
						if (a.getParentAddition().meta().getObject("Original")!=null) {
							logSave("Adding child addition "+a);
							((Addition)a.getParentAddition().meta().getObject("Original")).addChild(a);
							target.addAddition(a);
						}
					}
				} else {
					if (a.meta().getObject("PromptDirty")!=null) {
						logSave("Using altered prompts for addition "+a);
						original.setProperties(a.getProperties());
					}					
					if (a.meta().getObject("FileDirty")!=null) {
						logSave("Using altered file for addition "+a);
						original.setPrimaryFile(a.getPrimaryFile());
					}
				}
			}
			
			String orig = (String)dirtyProcedure.meta().getObject("OriginalWindow");
			if (orig!=dirtyProcedure.getWindow()) {
				logSave("Saving altered window");
				target.setWindow(dirtyProcedure.getWindow());
			}
			
			if (dirtyProcedure.meta().getObject("PromptDirty")!=null) {
				target.setPrompts(dirtyProcedure.getPrompts());
			}
			
		}
		// save embeds
		if (embedHelper!=null) {
			embedHelper.save();
		}
		isDirty=false;
		dirtyProcedure=null;
		
		for (Object scan : pages) {
			if (scan instanceof IFormPage) {
				((IFormPage)scan).doSave(monitor);
			}
		}		
		
		if (dirtyProcedure!=null) {
			throw new IllegalStateException("Should not happen!");
		}
		
		getProcedure().save(monitor);
		editorDirtyStateChanged();
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
		tracker.fire();
		if (embedHelper!=null) embedHelper.dispose();
	}

	@Override
	protected void addPages() {
		try {
			addPage(new ProcedureForm(this,"org.jclarion.clarion.ide.editor.ProcedureForm","Procedure"));
			addPage(new EmbedEditor(this,"org.jclarion.clarion.ide.editor.EmbedTree","Embeds",this));
			addPage(new ProcedureCallEditor(this,"org.jclarion.clarion.ide.editor.ProcedureCallEditor","Calls"));
			addPage(new ProcedureExtensionEditor(this,"org.jclarion.clarion.ide.editor.ProcedureExtensionEditor","Extensions"));
			addPage(new FieldEditor(this,"org.jclarion.clarion.ide.editor.FieldEditor","Fields"));
			addPage(new OtherFileEditor(this,"org.jclarion.clarion.ide.editor.OtherFileEditor","Other Files"));
		} catch (PartInitException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public String getName() {
		return getProcedure().getProcedure().getName(); 
	}

	@Override
	public String getWindow() {
		return getDirtyProcedure().getWindow();
	}

	@Override
	public void setWindow(String window) {
		getDirtyProcedure().setWindow(window);
		setDirty();
	}

	@Override
	public IProject getProject() {
		return getProcedure().getApp().getAppProject().getProject();
	}

	@Override
	public ProcedureModel getModel() {
		return getProcedure();
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

	private EmbedHelper embedHelper;
	
	@Override
	public EmbedHelper getEmbedHelper() {
		if (embedHelper==null) {
			embedHelper=new EmbedHelper(getModel().getProcedure());
		}
		return embedHelper;
	}

	@Override
	public AbstractClarionEditor getParentEditor() {
		return null;
	}

	@Override
	public void startEditSession() {
	}

	@Override
	public void finishEditSession() {
	}

}
