package org.jclarion.clarion.ide.model;

import org.eclipse.core.resources.IProject;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public interface WindowDefinitionProvider extends AbstractClarionEditor
{
	public abstract void startEditSession();
	public abstract void finishEditSession();
	public abstract String getName();
	public abstract String getWindow();
	public abstract void setWindow(String window);	
	public abstract IProject getProject();
	public abstract ProcedureModel getModel();
	public abstract Procedure      getDirtyProcedure();
}
