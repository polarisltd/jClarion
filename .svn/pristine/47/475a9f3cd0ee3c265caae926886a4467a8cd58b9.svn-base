package org.jclarion.clarion.ide.view;

import org.eclipse.core.runtime.Assert;
import org.eclipse.jface.viewers.DoubleClickEvent;
import org.eclipse.jface.viewers.IDoubleClickListener;
import org.eclipse.jface.viewers.ILabelProvider;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.ITreeContentProvider;
import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.jface.viewers.SelectionChangedEvent;
import org.eclipse.jface.viewers.StructuredSelection;
import org.eclipse.jface.viewers.TreeViewer;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.ui.views.contentoutline.ContentOutlinePage;

/**
 * A base implementation of common Content Outline support for editors.
 */
public abstract class AbstractContentOutlinePage extends ContentOutlinePage {

	Object input;
	TreeViewer viewer;

	private Listener listener;
	private boolean swallowSelectionChangedEvent;

	abstract ITreeContentProvider getContentProvider();
	public   ILabelProvider getLabelProvider()
	{
		return new LabelProvider();
	}

	public AbstractContentOutlinePage() {
		super();
	}

	/**
	 * Base implementation handles all the setup of the tree viewer
	 */
	@Override
	public void createControl(Composite parent) {
		super.createControl(parent);

		viewer = getTreeViewer();
		viewer.setContentProvider(getContentProvider());		
		viewer.setLabelProvider(getLabelProvider());
		viewer.addSelectionChangedListener(this);
		viewer.addDoubleClickListener(new IDoubleClickListener() {
			@Override
			public void doubleClick(DoubleClickEvent event) {
				if (listener != null) {
					Assert.isTrue(event.getSelection() instanceof StructuredSelection);
					listener.contentOutlineDoubleClicked((StructuredSelection) event.getSelection());
				}
			}
		});
		if (input != null) {
			viewer.setInput(input);
		}
		viewer.expandToLevel(2);

		// The tree viewer provides selections that can be listened to
		getSite().setSelectionProvider(viewer);
	}

	@Override
	public final void setFocus() {
		viewer.getControl().setFocus();
	}

	public final void setInput(Object input) {
		this.input = input;
		refresh();
	}

	public final void refresh() {
		TreeViewer viewer = getTreeViewer();

		if (viewer != null) {
			Control control = viewer.getControl();
			if ((control != null) && !control.isDisposed()) {
				control.setRedraw(false);
				viewer.setInput(input);
				viewer.expandToLevel(1);
				control.setRedraw(true);
			}
		}
	}

	@Override
	public final void selectionChanged(SelectionChangedEvent event) {
		if (swallowSelectionChangedEvent) {
			return;
		}
		super.selectionChanged(event);
		if (listener != null) {
			Assert.isTrue(event.getSelection() instanceof StructuredSelection);
			listener.contentOutlineSelectionChanged((StructuredSelection) event.getSelection());
		}
	}

	@Override
	public void dispose() {
		viewer.removeSelectionChangedListener(this);
		super.dispose();
	}

	public void setListener(Listener listener) {
		this.listener = listener;
	}

	/**
	 * Programmatically selects the content without triggering a selection
	 * changed event. If the content is not known, any existing selection is
	 * cleared
	 */
	public final void setSelectionWithoutEvent(ISelection selection) {
		swallowSelectionChangedEvent = true;
		setSelection(selection);
		swallowSelectionChangedEvent = false;
	}

	/**
	 * Interface for registering interest in changes to the selection in an
	 * {@link AbstractContentOutlinePage}
	 */
	public static interface Listener {

		/**
		 * Notifies the receiver of a change of selection in the Content Outline
		 * view. Supplies the selected content, or <code>null</code> if selection
		 * is empty
		 */
		public void contentOutlineSelectionChanged(StructuredSelection selection);

		/**
		 * Notifies the receiver of a double-click event in the Content Outline
		 * view. Supplies the selected content
		 */
		public void contentOutlineDoubleClicked(StructuredSelection selection);
	}


}
