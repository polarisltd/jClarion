package org.jclarion.clarion.ide.model;


import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.jface.operation.IRunnableContext;
import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.source.IAnnotationModel;
import org.eclipse.ui.texteditor.AbstractDocumentProvider;
import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.ide.editor.ClarionIncDocumentSetupParticipant;

public class EmbeditorDocumentProvider extends AbstractDocumentProvider
{
	
	protected class MyElementInfo extends ElementInfo
	{
		public MyElementInfo(IDocument document, IAnnotationModel model) {
			super(document, model);
		}

		@Override
		public void documentChanged(DocumentEvent event) 
		{
			if (!((EmbeditorDocument)fDocument).getStore().isDirty()) return;
			super.documentChanged(event);
		}
		
		
	}
	
	@Override
	protected ElementInfo createElementInfo(Object element) throws CoreException {
		return new MyElementInfo(createDocument(element), createAnnotationModel(element));
	}

	@Override
	protected void disposeElementInfo(Object element, ElementInfo info) {
		super.disposeElementInfo(element, info);
		((EmbeditorDocument)info.fDocument).dispose();
	}

	@Override
	protected IDocument createDocument(Object element) throws CoreException {
		EmbeditorInput input = (EmbeditorInput)element;
		IDocument document = new EmbeditorDocument(input);
		(new ClarionIncDocumentSetupParticipant()).setup(document);
		return document;
	}

	@Override
	protected IAnnotationModel createAnnotationModel(Object element) throws CoreException 
	{
		return null;
	}

	@Override
	protected void doSaveDocument(IProgressMonitor monitor, Object element,IDocument document, boolean overwrite) throws CoreException 
	{
		EmbeditorInput input = (EmbeditorInput)element;
		
		EmbeditorDocument doc  = (EmbeditorDocument)document;
		for (EmbedCode code : doc.getStore().getDirtyEmbeds()) {
			
			boolean indented=code.getIndent().length()==0;
			String content = code.getContent();
			
			Embed e = code.getExistingEmbed();
			
			if ((e==null || e.isIndent()) && !indented && content.length()>0) {
				// try and remove indents
				int pos = 0;
				StringBuilder fixed = new StringBuilder();
				indented=true;
				
				while (pos<content.length() ) {
					
					int thisIndentLength = 0;
					while (pos<content.length() && thisIndentLength<code.getIndent().length()) {
						char c = content.charAt(pos++);
						if (c==' ') {
							thisIndentLength++;
							continue;
						}
						if (c=='\t') {
							thisIndentLength+=8;
							continue;
						}
						break;
					}
					
					
					if (thisIndentLength!=code.getIndent().length()) {
						indented=false;
						break;
					}
					
					while (pos<content.length()) {
						char c = content.charAt(pos++);
						fixed.append(c);
						if (c=='\n') break;
						
					}
				}
				
				if (indented) {
					content=fixed.toString();
				}				
			}
			
			if (e!=null) {
				if (content.trim().length()==0) {
					code.getEmbedStore().getEmbeds().delete(e);
					code.setEmbed(null);
				} else {
					e.setIndent(indented);
					e.setValue(content);
				}
			} else {
				e = new Embed(code.getPriority(),code.getEmbedKey(),0);
				e.setIndent(indented);
				e.setValue(content);
				code.setEmbed(e);
				code.getEmbedStore().getEmbeds().add(e);
			}
		}
		doc.getStore().flagAsNotDirty();
		
		input.save(monitor);
	}

	@Override
	protected IRunnableContext getOperationRunner(IProgressMonitor monitor) {
		return null;
	}

	@Override
	public boolean isReadOnly(Object element) {
		return false;
	}

	@Override
	public boolean isModifiable(Object element) {
		return true;
	}

	
}
