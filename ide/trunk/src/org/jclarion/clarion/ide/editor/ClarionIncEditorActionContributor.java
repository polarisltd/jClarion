package org.jclarion.clarion.ide.editor;

import org.eclipse.jface.action.IToolBarManager;
import org.eclipse.jface.action.Separator;
import org.eclipse.ui.IActionBars;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.editors.text.TextEditorActionContributor;
import org.eclipse.ui.texteditor.ITextEditor;

import org.jclarion.clarion.ide.editor.action.AddWindowAction;

public class ClarionIncEditorActionContributor extends TextEditorActionContributor {

	private final AddWindowAction newWindowAction;

	public ClarionIncEditorActionContributor() {
		super();
		this.newWindowAction = new AddWindowAction();
	}

	@Override
	public void init(IActionBars bars) {
		super.init(bars);

		IToolBarManager toolBarManager= bars.getToolBarManager();
		if (toolBarManager != null) {
			toolBarManager.add(new Separator());
			toolBarManager.add(newWindowAction);
		}
	}

	@Override
	public void setActiveEditor(IEditorPart part) {
		super.setActiveEditor(part);
		doSetActiveEditor(part);
	}

	private void doSetActiveEditor(IEditorPart part) {
		super.setActiveEditor(part);

		ITextEditor editor = null;
		if (part instanceof ITextEditor) {
			editor= (ITextEditor) part;
		}

		newWindowAction.setEditor(editor);
	}

}
