package org.jclarion.clarion.ide.view;

import java.util.ArrayList;
import java.util.List;

import jclarion.Activator;

import org.eclipse.core.resources.IProject;
import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.BadPositionCategoryException;
import org.eclipse.jface.text.DefaultPositionUpdater;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentExtension3;
import org.eclipse.jface.text.IDocumentPartitioner;
import org.eclipse.jface.text.IPositionUpdater;
import org.eclipse.jface.text.ITypedRegion;
import org.eclipse.jface.text.Position;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.Viewer;
import org.eclipse.swt.SWT;
import org.eclipse.ui.texteditor.IDocumentProvider;

import org.jclarion.clarion.ide.editor.AbstractClarionEditor;
import org.jclarion.clarion.ide.editor.ClarionIncEditor;
import org.jclarion.clarion.ide.editor.ClarionIncPartitionScanner;
import org.jclarion.clarion.ide.model.ClarionIncContent;


/**
 * Displays an outline of Clarion *.inc source files in the Content Outline
 * view. The outline currently only supports <code>WINDOW</code> code blocks.
 */
public class ClarionIncContentOutlinePage extends AbstractContentOutlinePage
		implements ClarionIncContent.Listener {

	private final IDocumentProvider documentProvider;

	private ContentProvider contentProvider;

	private IProject project;

	private AbstractClarionEditor tracker;

	public ClarionIncContentOutlinePage(AbstractClarionEditor tracker,IProject project,IDocumentProvider documentProvider) {
		super();
		this.project=project;
		this.tracker=tracker;
		this.documentProvider = documentProvider;
	}

	/**
	 * Returns the content at the specified position, or <code>null</code> if
	 * none is found
	 */
	public ClarionIncContent getContentAt(Position position) {
		for (ClarionIncContent content : contentProvider.content) {
			if (content.position.overlapsWith(position.offset, position.length)) {
				return content;
			}
		}
		return null;
	}

	@Override
	public void contentChanged() {
		refresh();
	}

	/**
	 * Overridden to disable multi-selection
	 */
	@Override
	protected int getTreeStyle() {
		return SWT.H_SCROLL | SWT.V_SCROLL;
	}

	@Override
	ITreeContentProvider getContentProvider() {
		if (contentProvider == null) {
			contentProvider = new ContentProvider();
		}
		return contentProvider;
	}

	private IDocument getDocument(Object input) {
		return documentProvider.getDocument(input);
	}

	private List<ClarionIncContent> createContentFor(IDocument document) throws BadLocationException {
		List<ClarionIncContent> content = new ArrayList<ClarionIncContent>();

		IDocumentPartitioner x = getPartitioner(document);
		if (x==null) return content;
		for (ITypedRegion region : x.computePartitioning(0, document.getLength())) {
			if (region.getType().equals(ClarionIncPartitionScanner.CLARION_INC_WINDOW_CONTENT_TYPE)) {
				content.add(new ClarionIncContent(tracker,project,document, region, this));
			}
		}

		return content;
	}

	private IDocumentPartitioner getPartitioner(IDocument document) {
		IDocumentExtension3 extension = (IDocumentExtension3) document;
		return extension.getDocumentPartitioner(Activator.CLARION_INC_DOCUMENT_PARTITIONING);
	}

	private class ContentProvider implements ITreeContentProvider {

		private final IPositionUpdater positionUpdater;
		private List<ClarionIncContent> content;

		private ContentProvider() {
			this.positionUpdater = new DefaultPositionUpdater(ClarionIncEditor.POSITION_CATEGORY);
			this.content = new ArrayList<ClarionIncContent>();
		}

		@Override
		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
			if (oldInput != null) {
				IDocument document = getDocument(oldInput);
				if ((document != null) && document.containsPositionCategory(ClarionIncEditor.POSITION_CATEGORY)) {
					try {
						document.removePositionCategory(ClarionIncEditor.POSITION_CATEGORY);
					} catch (BadPositionCategoryException e) {
						Activator.getDefault().logError("Failed to remove position categories", e);
					} finally {
						document.removePositionUpdater(positionUpdater);
					}
				}
			}

			content.clear();

			if (newInput != null) {
				IDocument document = getDocument(newInput);
				if (document != null) {
					document.addPositionCategory(ClarionIncEditor.POSITION_CATEGORY);
					document.addPositionUpdater(positionUpdater);

					try {
						populate(document);
					} catch (BadLocationException e) {
						Activator.getDefault().logError("Failed to populate the Content Outline view", e);
					}
				}
			}
		}

		@Override
		public void dispose() {
			if (content != null) {
				content.clear();
				content = null;
			}
		}

		@Override
		public Object[] getElements(Object element) {
			if (element.equals(input)) {
				return content.toArray();
			}
			return null;
		}

		@Override
		public boolean hasChildren(Object element) {
			if (element.equals(input)) {
				return true;
			}
			if (element instanceof ClarionIncContent) {
				return ((ClarionIncContent) element).hasChildren();
			}
			return false;
		}

		@Override
		public Object getParent(Object element) {
			if (element.equals(input)) {
				return null;
			}
			if (element instanceof ClarionIncContent) {
				return ((ClarionIncContent) element).getParent();
			}
			return null;
		}

		@Override
		public Object[] getChildren(Object element) {
			if (element.equals(input)) {
				return content.toArray();
			}
			if (element instanceof ClarionIncContent) {
				return ((ClarionIncContent) element).getChildren();
			}
			return null;
		}

		private void populate(IDocument document) throws BadLocationException {
			for (ClarionIncContent c : createContentFor(document)) {
				try {
					document.addPosition(ClarionIncEditor.POSITION_CATEGORY, c.position);
					content.add(c);
				} catch (BadLocationException e) {
					Activator.getDefault().logError("Failed to add content to the content outline view at " + c.position, e);
				} catch (BadPositionCategoryException e) {
					Activator.getDefault().logError("Unknown position category " + ClarionIncEditor.POSITION_CATEGORY, e);
				}

			}
		}

	}

}
