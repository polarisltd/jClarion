package org.jclarion.clarion.ide;

import org.eclipse.ui.IPageLayout;
import org.eclipse.ui.IPerspectiveFactory;

public class PerspectiveFactory implements IPerspectiveFactory {

	static {
		System.err.println("WTF!");
	}
	
	public PerspectiveFactory() {
		// Empty
	}

	@Override
	public void createInitialLayout(IPageLayout layout) {
		String editorArea = layout.getEditorArea();
		layout.addView(IPageLayout.ID_PROJECT_EXPLORER, IPageLayout.LEFT, 0.25f, editorArea);
		//layout.addView("org.jclarion.clarion.ide.navigator.AppProcedure", IPageLayout.LEFT, 0.25f, editorArea);
		layout.addView(IPageLayout.ID_OUTLINE, IPageLayout.RIGHT, 0.5f, editorArea);
		layout.addView(IPageLayout.ID_PROP_SHEET, IPageLayout.BOTTOM, 0.5f, IPageLayout.ID_OUTLINE);
	}
}
