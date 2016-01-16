package org.jclarion.clarion.ide.model;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.runtime.Platform;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IPersistableElement;
import org.jclarion.clarion.appgen.template.prompt.EmbedTreeNodeEntry;
import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.editor.EmbedEditor;
import org.jclarion.clarion.ide.model.app.ProcedureModel;

public class EmbedInput implements IEditorInput, ClarionProjectInput, ClarionEditorInput
{
	private ProcedureModel 		procedure;
	private EmbedEditor 		editor;
	private EmbedTreeNodeEntry 	entry;
	private AbstractClarionEditor cEditor;
	
	public EmbedInput(EmbedEditor embedEditor, ProcedureModel model,EmbedTreeNodeEntry entry,AbstractClarionEditor editor) {
		this.editor=embedEditor;
		this.cEditor=editor;
		this.entry=entry;
		this.procedure=model;
	}

	@Override
	public boolean exists() {
		return true;
	}

	@Override
	public ImageDescriptor getImageDescriptor() {
		return null;
	}

	@Override
	public String getName() {
		return procedure.getProcedure().getName()+" Embed:"+entry.getEmbed().getKey().toString();
	}
	
	public ProcedureModel getProcedure()
	{
		return procedure;
	}

	@Override
	public IPersistableElement getPersistable() {
		return null;
	}

	@Override
	public String getToolTipText() {
		return null;
	}
	
	@Override
	public boolean equals(Object o)
	{
		if (o==null) return false;
		if (!(o instanceof EmbedInput)) return false;
		EmbedInput target = (EmbedInput)o;
		return entry.getEmbed()==target.entry.getEmbed();
	}

	@Override
	public Object getAdapter(@SuppressWarnings("rawtypes") Class adapter) {
		return Platform.getAdapterManager().getAdapter(this, adapter);
	}

	public String getText() {
		return entry.getEmbed().getValue();
	}

	public void saveText(String text) 
	{
		editor.save(entry,text);
	}

	@Override
	public IProject getProject() {
		return procedure.getApp().getProject().getProject();
	}

	@Override
	public AbstractClarionEditor getEditor() {
		return cEditor;
	}
}
