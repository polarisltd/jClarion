package org.jclarion.clarion.ide.editor;

import jclarion.Activator;

import org.eclipse.core.filebuffers.IDocumentSetupParticipant;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentExtension3;
import org.eclipse.jface.text.IDocumentPartitioner;
import org.eclipse.jface.text.rules.FastPartitioner;


/**
 * Sets up the document partitioner for Clarion *.inc files
 */
public class ClarionIncDocumentSetupParticipant implements IDocumentSetupParticipant {

	public ClarionIncDocumentSetupParticipant() {
		// Empty
	}

	@Override
	public void setup(IDocument document) {
		IDocumentExtension3 extension = (IDocumentExtension3) document;
		IDocumentPartitioner partitioner = new FastPartitioner(
				Activator.getDefault().getClarionIncPartitionScanner(),
				ClarionIncPartitionScanner.CONTENT_TYPES);
		extension.setDocumentPartitioner(Activator.CLARION_INC_DOCUMENT_PARTITIONING, partitioner);
		partitioner.connect(document);
	}

}
