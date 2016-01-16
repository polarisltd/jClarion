package org.jclarion.clarion.ide.view.properties;

import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.ColorDialog;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.views.properties.tabbed.ITabbedPropertyConstants;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

import org.jclarion.clarion.ide.Messages;
import org.jclarion.clarion.ide.model.manager.PropertyManager;

abstract public class AbstractColorPropertySection extends AbstractPropertyObjectWrapperPropertySection {

	private int property;

	public AbstractColorPropertySection(int property)
	{
		this.property=property;
	}
	
	private CLabel 	label;
	private CLabel 	dividerLabel;
	private CCombo 	combo;
	private Text 	text;
	private Button 	button;

	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	final String getColorName()
	{
		return getPropertyManager().getValueAsColorName(property);
	}
	
	final void setColorName(String value)
	{
		getPropertyManager().setValueAsColorName(property, getPropertyManager().getInt(property), value);
	}

	final RGB getColorRGB() {
		return getPropertyManager().getValueAsRGBIfNotColorName(property);
	}
	
	final void setColorRGB(RGB value)
	{
		getPropertyManager().setValueAsRGB(property, getPropertyManager().getInt(property), value);
	}

	public AbstractColorPropertySection() {
		super();
	}

	@Override
	public final void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
        super.createControls(parent, tabbedPropertySheetPage);

        Composite composite = createForm(parent);
        label = createLabel(composite, getLabel());
        dividerLabel = createLabel(composite, Messages.getString(AbstractColorPropertySection.class, "Divider.label"));
        combo = createCombo(composite, PropertyManager.getColorNames(), new ComboListener());
		text = createText(composite, false);
		button = createButton(composite, new ButtonListener());

		dividerLabel.setMargins(0, 0, 0, 0);

        layoutOneColumn(label, combo);

        FormData data = new FormData();
        data.top = new FormAttachment(combo, -ITabbedPropertyConstants.VSPACE);
        data.left = new FormAttachment(0, STANDARD_LABEL_WIDTH);
        dividerLabel.setLayoutData(data);

        data = new FormData();
        data.top = new FormAttachment(dividerLabel, -ITabbedPropertyConstants.VSPACE);
        data.left = new FormAttachment(0, STANDARD_LABEL_WIDTH);
        data.right = new FormAttachment(button, -ITabbedPropertyConstants.HSPACE);
        text.setLayoutData(data);

        layoutButton(button, dividerLabel);
	}

	@Override
	public final void refresh() {
		combo.setText(getSafeString(getColorName()));
		refreshRGB(getColorRGB());
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(label);
		disposeIfNotNull(dividerLabel);
		disposeIfNotNull(combo);
		disposeIfNotNull(text);
		disposeIfNotNull(button);
	}

	private class ComboListener extends SelectionAdapter {

		@Override
		public void widgetSelected(SelectionEvent e) {
			setColorName(combo.getText());
			text.setText(""); // Clear the RGB selection
		}

	}

	private class ButtonListener extends SelectionAdapter {

		@Override
		public void widgetSelected(SelectionEvent e) {
			ColorDialog dialog = new ColorDialog(getShell());
			dialog.setRGB(getColorRGB());
			RGB rgb = dialog.open();
			if (rgb != null) {
				setColorRGB(rgb);
				refreshRGB(rgb);
				combo.setText(""); // Clear the name selection
			}
		}

	}

	private void refreshRGB(RGB rgb) {
		PropertyManager manager = getPropertyManager();
		String rgbText = "";
		Color rgbColor = Display.getCurrent().getSystemColor(SWT.COLOR_LIST_FOREGROUND);

		if (rgb != null) {
			rgbText = manager.convertIntegerToColorHex(manager.convertRgbToInteger(rgb));
			rgbColor = new Color(Display.getCurrent(), rgb);
		}

		text.setText(rgbText);
		text.setForeground(rgbColor);

		rgbColor.dispose();
	}

}
