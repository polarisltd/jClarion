package org.jclarion.clarion.ide.view.properties;

import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

/**
 * Minimises the effort required to implement a text property section
 */
abstract class AbstractTextPropertySection extends AbstractPropertyObjectWrapperPropertySection {
	private Text text;
	private PropTextBox box;
	
	abstract String getLabel();
	abstract Object getValue();
	abstract void setValueAsString(Object priorValue,String value,boolean commit);
	
	public AbstractTextPropertySection() {
		super();
	}
	
	public int getProperty()
	{
		return 0;
	}

	@Override
	public final void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
		super.createControls(parent, tabbedPropertySheetPage);
		text = createOneColumnTextForm(parent, getLabel());
		box = new PropTextBox(text) {

			@Override
			public void setValueAsString(Object priorValue, String value,boolean commit) {
				AbstractTextPropertySection.this.setValueAsString(priorValue, value, commit);
			}

			@Override
			public Object getValue() {
				return AbstractTextPropertySection.this.getValue(); 
			}

			@Override
			public int getProperty() {
				return AbstractTextPropertySection.this.getProperty();
			}
		};
	}

	@Override
	public final void refresh() {
		box.refresh();
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(text);
	}
}
