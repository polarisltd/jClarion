package org.jclarion.clarion.ide.view.properties;

import java.util.Collection;

import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

/**
 * Minimises the effort required to implement a combo property section
 */
abstract class AbstractComboPropertySection extends AbstractPropertyObjectWrapperPropertySection {

	private CCombo combo;

	abstract Collection<String> getValues();
	abstract String getLabel();
	abstract String getValueAsString();
	abstract void setValueAsString(String value);

	public AbstractComboPropertySection() {
		super();
	}

	@Override
	public void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
		super.createControls(parent, tabbedPropertySheetPage);
		combo = createOneColumnComboForm(parent, getLabel(), getValues(), new ComboListener());
	}

	@Override
	public void refresh() {
		combo.setText(getSafeString(getValueAsString()));
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(combo);
	}

	private class ComboListener extends SelectionAdapter {

		@Override
		public void widgetSelected(SelectionEvent e) {
			setValueAsString(combo.getText());
		}

	}

}
