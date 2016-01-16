package org.jclarion.clarion.ide.model;

import org.eclipse.jface.text.AbstractDocument;
import org.eclipse.jface.text.DocumentEvent;
import org.jclarion.clarion.appgen.template.BufferedWriteTarget;
import org.jclarion.clarion.appgen.template.prompt.EmbedEditor;
import org.jclarion.clarion.appgen.template.prompt.EmbeditorBlock;
import org.jclarion.clarion.ide.model.app.ProcedureSave;
import org.jclarion.clarion.ide.model.app.ProcedureSaveListener;

public class EmbeditorDocument extends AbstractDocument implements ProcedureSaveListener
{
	private EmbeditorTextStore store;
	private EmbeditorInput     input;
	
	public EmbeditorDocument(EmbeditorInput input)
	{
		super();
		this.input=input;
		this.store=loadStore();
		setTextStore(store);		
		setLineTracker(store.getLineTracker());
		completeInitialization();
		
		ProcedureSave.get(input.getProcedure()).add(this);
	}	
	
	public void dispose()
	{
		ProcedureSave.get(input.getProcedure()).remove(this);
	}
	
	@Override
	public EmbeditorTextStore getStore()
	{
		return (EmbeditorTextStore)super.getStore();
	}
	
	private EmbeditorTextStore loadStore()
	{
		BufferedWriteTarget target = null;
	
		AppProject proj = input.getAppProject(); 
	
		if (input.isEditModule()) {
			target = proj.getEditModule(input.getModule(),input.isAllEmbedPoints());			
		} else {
			target = proj.getEditProcedure(input.getProcedure(),input.isAllEmbedPoints());
		}
		EmbeditorBlock block = (new EmbedEditor(input.isAllEmbedPoints())).load(target);
		return new EmbeditorTextStore(block);
	}

	@Override
	public void procedureSaved() 
	{
		String currentText = getStore().get(0, getStore().getLength());
		EmbeditorTextStore newStore = loadStore();
		String newText = newStore.get(0, newStore.getLength());
		
		DocumentEvent e= null;
		
		if (!currentText.equals(newText)) {
			e=new DocumentEvent(this, 0, currentText.length(),newText);
			fireDocumentAboutToBeChanged(e);
		}
		
		this.store.replace(newStore);

		if (e!=null) {
			fireDocumentChanged(e);
		}
	}
	
	

	@Override
	public void procedureDeleted() 
	{
	}

}
