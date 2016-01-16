package org.jclarion.clarion.ide.editor.action;

import org.eclipse.core.runtime.Assert;
import org.eclipse.ui.ISharedImages;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.texteditor.TextEditorAction;

import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.editor.ClarionIncEditor;

public class AddWindowAction extends TextEditorAction {

	public AddWindowAction() {
		super(Messages.getResourceBundle(), "AddWindowAction.", null);
		setEnabled(true);
		setImageDescriptor(
				PlatformUI.getWorkbench().getSharedImages().getImageDescriptor(ISharedImages.IMG_OBJ_ADD));
	}

	@Override
	public void run() {
		Assert.isTrue(getTextEditor() instanceof ClarionIncEditor);
		((ClarionIncEditor) getTextEditor()).addWindow();
	}

}