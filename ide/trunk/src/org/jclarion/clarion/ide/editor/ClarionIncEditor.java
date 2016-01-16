package org.jclarion.clarion.ide.editor;

import java.util.ArrayList;
import java.util.List;

import jclarion.Activator;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.runtime.Assert;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentListener;
import org.eclipse.jface.text.IEventConsumer;
import org.eclipse.jface.text.Position;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.ISelectionChangedListener;
import org.eclipse.jface.viewers.ISelectionProvider;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.swt.custom.CaretEvent;
import org.eclipse.swt.custom.CaretListener;
import org.eclipse.swt.custom.LineBackgroundEvent;
import org.eclipse.swt.custom.LineBackgroundListener;
import org.eclipse.swt.custom.StyledText;
import org.eclipse.swt.events.VerifyEvent;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.editors.text.TextEditor;
import org.eclipse.ui.ide.ResourceUtil;
import org.eclipse.ui.views.contentoutline.IContentOutlinePage;
import org.eclipse.ui.views.properties.IPropertySheetPage;
import org.eclipse.ui.views.properties.tabbed.ITabbedPropertySheetPageContributor;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.AppProject;
import org.jclarion.clarion.ide.model.ClarionEditorInput;
import org.jclarion.clarion.ide.model.ClarionIncContent;
import org.jclarion.clarion.ide.model.ClarionProjectInputHelper;
import org.jclarion.clarion.ide.model.ClarionToJavaInput;
import org.jclarion.clarion.ide.model.EmbeditorDocument;
import org.jclarion.clarion.ide.model.EmbeditorInput;
import org.jclarion.clarion.ide.model.EmbeditorTextStore;
import org.jclarion.clarion.ide.model.app.ProcedureModel;
import org.jclarion.clarion.ide.view.AbstractContentOutlinePage;
import org.jclarion.clarion.ide.view.ClarionIncContentOutlinePage;

/**
 * A Clarion *.inc file text editor that supports syntax highlighting and a
 * content outline.
 */
public class ClarionIncEditor extends TextEditor implements
			AbstractContentOutlinePage.Listener,
			CaretListener,
			ISelectionProvider,
			IDocumentListener,
			OffsetPositionOverlapJob.Listener,
			ITabbedPropertySheetPageContributor,EditorClosedListener, AbstractClarionEditor {

	public static final String ID = ClarionIncEditor.class.getName();
	public static final String POSITION_CATEGORY = "__clarion_inc_content_awt";

	private final List<ISelectionChangedListener> listeners;

	private ClarionIncContentOutlinePage outlinePage;
	private boolean ignoreCaretEvent;
	private ISelection selection;
	private OffsetPositionOverlapJob offsetOverlapJob;

	public ClarionIncEditor() {
		super();
		this.listeners = new ArrayList<ISelectionChangedListener>();
	}
	
	


	/**
	 * Overridden to listen to add caret listener
	 */
	@Override
	public void createPartControl(Composite parent) {
		super.createPartControl(parent);

		this.offsetOverlapJob = new OffsetPositionOverlapJob(getDocument(), POSITION_CATEGORY);
		this.offsetOverlapJob.addListener(this);

		((StyledText) getAdapter(Control.class)).addCaretListener(this);
		getDocument().addDocumentListener(this);

		// Provides selections for the Properties views
		getSite().setSelectionProvider(this);

		if (getDocument() instanceof EmbeditorDocument) {

			final EmbeditorTextStore doc = ((EmbeditorDocument)getDocument()).getStore();

			getSourceViewer().setEventConsumer(new IEventConsumer() {
		         @Override
		         public void processEvent(VerifyEvent event) {
		             if (doc.isReadOnly(event.start)) {
		                event.doit = false;
		                 return;
		             }

		             if (event.end!=event.start) {
		            	 if (doc.getComponent(event.start)!=doc.getComponent(event.end)) {
				             event.doit = false;
				             return;
		            	 }
		             }
		         }
		    });

			getSourceViewer().getTextWidget().addLineBackgroundListener(new LineBackgroundListener() {

				Color white;
				Color readonly;

				@Override
				public void lineGetBackground(LineBackgroundEvent event) {
					if (white==null) {
						white=new Color(event.display,255,255,255);
						readonly=new Color(event.display,224,224,224);
					}

					if (doc.isReadOnly(event.lineOffset)) {
						event.lineBackground=readonly;
					} else {
						event.lineBackground=white;
					}
				}
			});


		}
	}

	@Override
	public void caretMoved(CaretEvent event) {
		if (ignoreCaretEvent) {
			return;
		}
		offsetOverlapJob.setOffsetAndSchedule(event.caretOffset);
	}

	@Override
	public void dispose() {
		getDocument().removeDocumentListener(this);
		if (outlinePage != null) {
			outlinePage.setInput(null);
		}
		tracker.fire();
		if (getEditorInput() instanceof ClarionEditorInput) {
			((ClarionEditorInput)getEditorInput()).getEditor().removeEditorCloseListener(this);
		}
		super.dispose();
	}

	@Override
	public void doRevertToSaved() {
		super.doRevertToSaved();
		refreshOutlinePage();
	}

	@Override
	public void doSave(IProgressMonitor monitor) {
		super.doSave(monitor);
		refreshOutlinePage();
		if (getEditorInput() instanceof ClarionEditorInput) {
			((ClarionEditorInput)getEditorInput()).getEditor().restoreFocus();
		}		
	}

	@Override
	public void doSaveAs() {
		super.doSaveAs();
		refreshOutlinePage();
	}

	@Override
	public void doSetInput(IEditorInput input) throws CoreException {
		
		IFile file = ResourceUtil.getFile(input);
		if (file!=null && file.isDerived()) {
			AppProject app = AppProject.get(file.getProject());
			if (app!=null && app.getApp()!=null) {
				Module m = app.getApp().getModule(file.getName());
				if (m!=null) {
					input=new EmbeditorInput(app,m,false);
				}
			}
		}
		super.doSetInput(input);
		if (outlinePage != null) {
			outlinePage.setInput(input);
		}
		if (getEditorInput() instanceof ClarionEditorInput) {
			((ClarionEditorInput)getEditorInput()).getEditor().addEditorCloseListener(this);
		}
	}
	
	private EditorCloseProducer tracker = new EditorCloseProducer();
	

	@Override
	@SuppressWarnings("rawtypes")
	public Object getAdapter(Class adapter) {
		if (IContentOutlinePage.class.equals(adapter)) {
			if (outlinePage == null) {
				outlinePage = new ClarionIncContentOutlinePage(this,ClarionProjectInputHelper.getProject(getEditorInput()),getDocumentProvider());
				outlinePage.setListener(this);
				if (getEditorInput() != null) {
					outlinePage.setInput(getEditorInput());
				}
			}
			return outlinePage;
		}
		if (IPropertySheetPage.class.equals(adapter)) {
			return new TabbedPropertySheetPage(this);
		}
		return super.getAdapter(adapter);
	}

	@Override
	public void contentOutlineSelectionChanged(StructuredSelection selection) {
		// Tell the caret listener to ignore this change event coming from the
		// Content Outline view
		ignoreCaretEvent = true;
		handleSelectionChanged(selection, false);
		// Reset so that caret events are handled while there is no Content
		// Outline selection
		ignoreCaretEvent = false;
	}

	@Override
	public void contentOutlineDoubleClicked(StructuredSelection selection) {
		Assert.isTrue(selection.getFirstElement() instanceof ClarionIncContent);
		ClarionIncContent content = (ClarionIncContent) selection.getFirstElement();

		try {
			getSite().getWorkbenchWindow().getActivePage().openEditor(
					new ClarionToJavaInput(content.getWindowDefinitionProvider()), ClarionToJavaEditor.ID);
		} catch (PartInitException e1) {
			e1.printStackTrace();
		}
	}

	@Override
	public void addSelectionChangedListener(ISelectionChangedListener listener) {
		if (!listeners.contains(listener)) {
			listeners.add(listener);
		}
	}

	@Override
	public ISelection getSelection() {
		return selection;
	}

	@Override
	public void removeSelectionChangedListener(ISelectionChangedListener listener) {
		listeners.remove(listener);
	}

	@Override
	public void setSelection(ISelection selection) {
		this.selection = selection;
		handleSelectionChanged(selection, true);
		fireSelectionChanged(new SelectionChangedEvent(this, selection));
	}

	@Override
	public void documentChanged(DocumentEvent event) {
		if (outlinePage != null) {
			outlinePage.refresh();
		}
	}

	@Override
	public void documentAboutToBeChanged(DocumentEvent event) {
		// Not interested in this event
	}

	@Override
	public void overlappingPositionFound(final Position position) {
		Activator.getDefault().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				ISelection selection = new StructuredSelection();
				if (position != null) {
					ClarionIncContent content = outlinePage.getContentAt(position);
					if (content != null) {
						selection = new StructuredSelection(content);
					}
				}
				setSelection(selection);
			}
		});
	}

	@Override
	public String getContributorId() {
		return ID;
	}

	/**
	 * Adds a pre-made <code>WINDOW</code> block at the current caret position
	 */
	public void addWindow() {
		try {
			getDocument().replace(offsetOverlapJob.getOffset(), 0, Messages.getString(getClass(), "new_window"));
			refreshOutlinePage();
		} catch (BadLocationException e) {
			Activator.getDefault().logError("Failed to insert new window", e);
		}
	}

	@Override
	protected void initializeEditor() {
		super.initializeEditor();
		setSourceViewerConfiguration(new ClarionIncSourceViewerConfiguration());
	}

	private IDocument getDocument() {
		return getDocumentProvider().getDocument(getEditorInput());
	}

	private void fireSelectionChanged(SelectionChangedEvent event) {
		for (ISelectionChangedListener listener : listeners) {
			listener.selectionChanged(event);
		}
	}

	/**
	 * Highlights the selection in the left-hand ruler and in the Content
	 * Outline view where applicable
	 */
	private void handleSelectionChanged(ISelection selection, boolean selectInOutlinePage) {
		Assert.isTrue(selection instanceof StructuredSelection);
		StructuredSelection ss = (StructuredSelection) selection;

		if (selectInOutlinePage) {
			outlinePage.setSelectionWithoutEvent(selection);
		}
		if (ss.isEmpty()) {
			resetHighlightRange();
		} else {
			Assert.isTrue(ss.getFirstElement() instanceof ClarionIncContent);
			ClarionIncContent content = (ClarionIncContent) ss.getFirstElement();
			setHighlightRange(content.position.offset, content.position.length, !selectInOutlinePage);
		}
	}

	private void refreshOutlinePage() {
		if (outlinePage != null) {
			outlinePage.refresh();
		}
	}

	@Override
	public void editorClosed() 
	{
		close(false);
	}

	@Override
	public void removeEditorCloseListener(EditorClosedListener listener) {
		tracker.removeEditorCloseListener(listener);
	}

	@Override
	public void addEditorCloseListener(EditorClosedListener listener) {
		tracker.addEditorCloseListener(listener);
	}

	@Override
	public void restoreFocus() {
		getEditorSite().getPage().activate(this);
	}

	@Override
	public Procedure getDirtyProcedure() {
		if (getEditorInput() instanceof ClarionEditorInput) {
			return ((ClarionEditorInput)getEditorInput()).getEditor().getDirtyProcedure();
		}
		return null;
	}

	@Override
	public ProcedureModel getModel() {
		if (getEditorInput() instanceof ClarionEditorInput) {
			return ((ClarionEditorInput)getEditorInput()).getEditor().getModel();
		}
		if (getEditorInput() instanceof EmbeditorInput) {
			return ((EmbeditorInput)getEditorInput()).getProcedureModel();
		}
		return null;
	}




	@Override
	public AbstractClarionEditor getParentEditor() {
		if (getEditorInput() instanceof ClarionEditorInput) {
			return ((ClarionEditorInput)getEditorInput()).getEditor();
		}
		return null;
	}

}
