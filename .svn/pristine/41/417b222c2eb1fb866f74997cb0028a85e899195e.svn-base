package org.jclarion.clarion.ide.view.properties;

import java.util.Collection;
import java.util.List;
import java.util.ArrayList;

import org.eclipse.core.runtime.Assert;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.swt.SWT;
import org.eclipse.swt.custom.CCombo;
import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.IWorkbenchPart;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.views.properties.tabbed.AbstractPropertySection;
import org.eclipse.ui.views.properties.tabbed.ITabbedPropertyConstants;

import org.jclarion.clarion.ide.Messages;

/**
 * Handles the setting of input and provides convenience methods for the
 * creation of property sheet forms by providing defaults for the widget factory
 * methods
 */
abstract public class AbstractJClarionPropertySection extends AbstractPropertySection {

	public static final int STANDARD_LABEL_WIDTH=100;
	public static final int SHORT_LABEL_WIDTH=60;
	
	private Integer buttonHeight;

	abstract void doSetInput(Object input);

	public AbstractJClarionPropertySection() {
		// Empty
	}

	@Override
	public final void setInput(IWorkbenchPart part, ISelection selection) {
		super.setInput(part, selection);
        Assert.isTrue(selection instanceof IStructuredSelection);
        doSetInput(((IStructuredSelection) selection).getFirstElement());
	}

	Composite createForm(Composite parent) {
		return getWidgetFactory().createFlatFormComposite(parent);
	}

	CLabel createLabel(Composite parent, String label) {
		return getWidgetFactory().createCLabel(parent, label);
	}

	/**
	 * Returns a button with the default "Change..." label
	 */
	Button createButton(Composite parent, SelectionListener listener) {
		return createButton(
				parent,
				Messages.getString(AbstractJClarionPropertySection.class, "Button.label"),
				listener);
	}

	Button createButton(Composite parent, String label, SelectionListener listener) {
		return createButton(parent, label, SWT.PUSH, listener);
	}

	Button createCheck(Composite parent, SelectionListener listener) {
		return createButton(parent, "", SWT.CHECK, listener);
	}

	CCombo createCombo(Composite parent, Collection<String> values, SelectionListener listener) {
		CCombo combo = getWidgetFactory().createCCombo(parent);
		combo.setEditable(false);
		combo.addSelectionListener(listener);
		
		List<String> nvalues =new ArrayList<String>(values.size());
		if (!values.contains("")) {
			nvalues.add("");
		}
		nvalues.addAll(values);
		
		combo.setItems(nvalues.toArray(new String[nvalues.size()]));
		return combo;
	}

	Text createText(Composite parent) {
		return createText(parent, true);
	}

	Text createText(Composite parent, boolean editable) {
		Text text = getWidgetFactory().createText(parent, "");
		text.setEditable(editable);
		return text;
	}

	/**
	 * Creates and returns a {@link Text} widget with the supplied label
	 */
	Text createOneColumnTextForm(Composite parent, String label) {
		Composite composite = createForm(parent);
		Text text = createText(composite);
		layoutOneColumn(createLabel(composite, label), text);
		return text;
	}

	Button createOneColumnCheckForm(Composite parent, String label, SelectionListener listener) {
		Composite composite = createForm(parent);
		Button button = createCheck(composite, listener);
		layoutOneColumn(createLabel(composite, label), button);
		return button;
	}

	CCombo createOneColumnComboForm(
			Composite parent,
			String label,
			Collection<String> values,
			SelectionListener listener) {
		Composite composite = createForm(parent);
		CCombo combo = createCombo(composite, values, listener);
		layoutOneColumn(createLabel(composite, label), combo);
		return combo;
	}

	/**
	 * Creates, aligns and returns two {@link Text} widgets, with the first
	 * widget proceeded by <code>label1</code> and the second by
	 * <code>label2</code>
	 */
	Text[] createTwoColumnTextForm(Composite parent, String label1, String label2) {
        Composite composite = createForm(parent);
        Text text1 = createText(composite);
        Text text2 = createText(composite);

        layoutTwoColumns(
                       createLabel(composite, label1), text1,
                       createLabel(composite, label2), text2);

        return new Text[] { text1, text2 };
	}

	FormAttachment createDefaultTopFormAttachment() {
		return new FormAttachment(0, ITabbedPropertyConstants.VSPACE);
	}

	/**
	 * Returns "" if <code>value</code> is <code>null</code>. SWT text widgets
	 * can't be set to <code>null</code> so use this to be safe when calling
	 * {@link Text#setText(String)}
	 */
	String getSafeString(Object value) {
        String strValue = "";
        if (value != null) {
        	strValue = value.toString();
        }
        return strValue;
	}

	Shell getShell() {
		return PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();
	}

	int getButtonHeight() {
		if (buttonHeight == null) {
			Shell shell = getShell();
			GC gc = new GC(shell);
			gc.setFont(shell.getFont());
			Point point = gc.textExtent("");
			gc.dispose();
			buttonHeight = point.y + 8;
		}
		return buttonHeight;
	}

	void disposeIfNotNull(Control control) {
		if (control != null) {
			control.dispose();
		}
	}

	void layoutOneColumn(Control label, Control control) {
		
		FormData data = new FormData();
		data.left = new FormAttachment(0, STANDARD_LABEL_WIDTH);
		data.right = new FormAttachment(100);
		data.top = createDefaultTopFormAttachment();
		data.width = 50;
		control.setLayoutData(data);

		data = new FormData();
		data.left = new FormAttachment(0);
		data.right = new FormAttachment(control, -ITabbedPropertyConstants.HSPACE);
		data.top = new FormAttachment(control, 0, SWT.CENTER);
		label.setLayoutData(data);
	}

	/**
	 * Convenience method to layout a {@link Button}, relative to an optional
	 * top control
	 */
	void layoutButton(Button button, Control top) {
		int offset = (top == null)
				? (int) Math.round(0.75 * -ITabbedPropertyConstants.VSPACE)
				: (int) Math.round(1.5 * -ITabbedPropertyConstants.VSPACE);
		FormData data = new FormData();
		data.top = (top == null)
				? new FormAttachment(0, offset)
				: new FormAttachment(top, offset);
		data.right = new FormAttachment(100);
		data.bottom = new FormAttachment(100);
		data.height = getButtonHeight();
		button.setLayoutData(data);
	}

	/**
	 * Lays out the labels and controls in the order that their named
	 */
	private void layoutTwoColumns(Control label1, Control control1, Control label2, Control control2) {
		FormData data = new FormData();
		data.top = createDefaultTopFormAttachment();
		data.left = new FormAttachment(0);
        data.right = new FormAttachment(control1, -ITabbedPropertyConstants.HSPACE);
        label1.setLayoutData(data);

        data = new FormData();
        data.top = createDefaultTopFormAttachment();
        data.left = new FormAttachment(0, SHORT_LABEL_WIDTH);
        data.right = new FormAttachment(label2, -ITabbedPropertyConstants.HSPACE);
        data.width = 25;
        control1.setLayoutData(data);

        data = new FormData();
        data.top = createDefaultTopFormAttachment();
        data.left = new FormAttachment(50);
        data.width = SHORT_LABEL_WIDTH;
        label2.setLayoutData(data);

        data = new FormData();
        data.top = createDefaultTopFormAttachment();
        data.left = new FormAttachment(label2, ITabbedPropertyConstants.HSPACE);
        data.right = new FormAttachment(100);
        data.width = 25;
        control2.setLayoutData(data);
	}

	private Button createButton(Composite parent, String label, int style, SelectionListener listener) {
		Button button = getWidgetFactory().createButton(parent, label, style);
		button.addSelectionListener(listener);
		return button;
	}

}
