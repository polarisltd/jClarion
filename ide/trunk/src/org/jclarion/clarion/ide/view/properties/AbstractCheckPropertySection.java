package org.jclarion.clarion.ide.view.properties;

import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

/**
 * Minimises the effort required to implement a check box property section
 */
abstract class AbstractCheckPropertySection extends AbstractPropertyObjectWrapperPropertySection {

	abstract String getLabel();
	abstract boolean getValue();
	abstract void setValue(boolean value);

	private Button button;

	public AbstractCheckPropertySection() {
		super();
	}

	@Override
	public final void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
		super.createControls(parent, tabbedPropertySheetPage);
		button = createOneColumnCheckForm(parent, getLabel(), new Listener());
	}

	@Override
	public final void refresh() {
		button.setSelection(getValue());
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(button);
	}

	private class Listener extends SelectionAdapter {

		@Override
		public void widgetSelected(SelectionEvent e) {
			setValue(button.getSelection());
		}

	}

}
