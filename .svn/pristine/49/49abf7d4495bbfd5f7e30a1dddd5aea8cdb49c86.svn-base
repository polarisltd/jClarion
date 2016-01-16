package org.jclarion.clarion.ide.editor;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public interface AbstractClarionEditor {
	public void removeEditorCloseListener(EditorClosedListener listener);
	public void addEditorCloseListener(EditorClosedListener listener);
	public void restoreFocus();
	public Procedure getDirtyProcedure();
	public ProcedureModel getModel();
	public AbstractClarionEditor getParentEditor();
}
