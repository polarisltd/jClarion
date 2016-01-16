package org.jclarion.clarion.ide.view.properties;

import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.views.properties.tabbed.ITabbedPropertyConstants;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

/**
 * Minimises the effort required to implement a dialog property section
 */
abstract class AbstractDialogPropertySection extends AbstractPropertyObjectWrapperPropertySection 
{
	private CLabel label;
	private Text text;
	private PropTextBox box;
	private Button button;

    abstract String getLabel();
    
    public abstract Object getValue();
    public abstract void setValueAsString(Object priorValue, String value, boolean commit);

    abstract Object openDialog(Object value, Shell shell);

	public AbstractDialogPropertySection() {
		super();
	}

	@Override
	public final void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
		super.createControls(parent, tabbedPropertySheetPage);

		Composite composite = createForm(parent);
		label = createLabel(composite, getLabel());
		text = createText(composite, false);
		box = new PropTextBox(text) {
			@Override
			public void setValueAsString(Object priorValue, String value, boolean commit) {
				AbstractDialogPropertySection.this.setValueAsString(priorValue,value,commit);
			}
			
			@Override
			public Object getValue() {
				return AbstractDialogPropertySection.this.getValue();
			}
		};
		button = createButton(composite, new Listener());

		FormData data = new FormData();
		data.top = new FormAttachment(0);
		data.left = new FormAttachment(0);
		data.right = new FormAttachment(text, -ITabbedPropertyConstants.HSPACE);
		label.setLayoutData(data);

		data = new FormData();
		data.top = new FormAttachment(0);
		data.left = new FormAttachment(0, STANDARD_LABEL_WIDTH);
		data.right = new FormAttachment(button, -ITabbedPropertyConstants.HSPACE);
		data.width = 50;
		text.setLayoutData(data);

		layoutButton(button, null);
	}

	@Override
	public final void refresh() {
		box.refresh();
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(label);
		disposeIfNotNull(button);
		disposeIfNotNull(text);
	}

	private class Listener extends SelectionAdapter {

		public void widgetSelected(SelectionEvent event) {
			Object oldValue = getValue();
			Object newValue = openDialog(oldValue, getShell());
			if ((newValue != null) && !newValue.equals(oldValue)) {
				text.setText(newValue.toString());
				box.commit();
			} else if ((newValue == null) && (oldValue != null)) {
				text.setText("");
				box.commit();
			}
			refresh();
		}

	}

}
