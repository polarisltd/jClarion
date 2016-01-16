package org.jclarion.clarion.ide.model;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.jface.operation.IRunnableContext;
import org.eclipse.jface.text.Document;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.source.IAnnotationModel;
import org.eclipse.ui.texteditor.AbstractDocumentProvider;
import org.jclarion.clarion.ide.editor.ClarionIncDocumentSetupParticipant;

public class TargetSourceDocumentProvider extends AbstractDocumentProvider
{
	@Override
	protected IDocument createDocument(Object element) throws CoreException {
		ClarionToJavaInput input = (ClarionToJavaInput)element;
		Document document = new Document(input.getProvider().getWindow());
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
		ClarionToJavaInput input = (ClarionToJavaInput)element;
		input.getProvider().setWindow(document.get());
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
