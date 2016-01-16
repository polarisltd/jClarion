package org.jclarion.clarion.ide.editor;

import java.util.Arrays;

import jclarion.Activator;

import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.presentation.IPresentationReconciler;
import org.eclipse.jface.text.presentation.PresentationReconciler;
import org.eclipse.jface.text.rules.DefaultDamagerRepairer;
import org.eclipse.jface.text.source.ISourceViewer;
import org.eclipse.jface.text.source.SourceViewerConfiguration;
import org.jclarion.clarion.ide.editor.rule.SimpleDamager;


/**
 * Central location for configuring Clarion *.inc file editors pluggable
 * behaviour
 */
public class ClarionIncSourceViewerConfiguration extends SourceViewerConfiguration {

	public ClarionIncSourceViewerConfiguration() {
		// Empty
	}

	@Override
	public String getConfiguredDocumentPartitioning(ISourceViewer sourceViewer) {
		return Activator.CLARION_INC_DOCUMENT_PARTITIONING;
	}

	@Override
	public String[] getConfiguredContentTypes(ISourceViewer sourceViewer) {
		String[] src = ClarionIncPartitionScanner.CONTENT_TYPES;
		String[] types = Arrays.copyOf(src, src.length + 1);
		types[src.length] = IDocument.DEFAULT_CONTENT_TYPE;
		return types;
	}

	/**
	 * Presentation reconciler provides syntax highlighting for each of the
	 * content types
	 */
	@Override
	public IPresentationReconciler getPresentationReconciler(ISourceViewer sourceViewer) {
		PresentationReconciler reconciler = new PresentationReconciler();
		reconciler.setDocumentPartitioning(getConfiguredDocumentPartitioning(sourceViewer));

		
		DefaultDamagerRepairer dr= new DefaultDamagerRepairer(Activator.getDefault().getClarionIncCodeScanner());
		SimpleDamager simpleDamager=new SimpleDamager();
		
		//dr = new DefaultDamagerRepairer(Activator.getDefault().getClarionIncCodeScanner());
		reconciler.setDamager(new SimpleDamager(), IDocument.DEFAULT_CONTENT_TYPE);
		reconciler.setRepairer(dr, IDocument.DEFAULT_CONTENT_TYPE);

		//dr = new DefaultDamagerRepairer(Activator.getDefault().getClarionIncCodeScanner());
		reconciler.setDamager(simpleDamager, ClarionIncPartitionScanner.CLARION_INC_WINDOW_CONTENT_TYPE);
		reconciler.setRepairer(dr, ClarionIncPartitionScanner.CLARION_INC_WINDOW_CONTENT_TYPE);
		
		return reconciler;
	}

}
