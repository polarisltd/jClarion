package org.jclarion.clarion.ide.view.properties;

import org.eclipse.jface.resource.StringConverter;
import org.eclipse.swt.graphics.FontData;
import org.eclipse.swt.widgets.FontDialog;
import org.eclipse.swt.widgets.Shell;

import org.jclarion.clarion.ide.Messages;

public class FontPropertySection extends AbstractDialogPropertySection {

	public FontPropertySection() {
		super();
	}

	@Override
	String getLabel() {
		return Messages.getString(getClass(), "label");
	}

	@Override
	public Object getValue() {
		FontData fd= getPropertyManager().getFont();
		return fd==null ?  null :StringConverter.asString(fd);
	}

	@Override
	public void setValueAsString(Object priorValue, String value, boolean commit) {
		if (!commit) return;
		getPropertyManager().setFont(
			value==null ? null : StringConverter.asFontData(value), 
			priorValue==null  ? getPropertyManager().getInheritedFont() : StringConverter.asFontData((String)priorValue));
	}

	@Override
	Object openDialog(Object value, Shell shell) {
		FontDialog dialog = new FontDialog(shell);
		if (value != null) {
			FontData fd = StringConverter.asFontData((String)value);
			dialog.setFontList(new FontData[] { fd });
		} else {
			FontData fd = getPropertyManager().getInheritedFont();
			dialog.setFontList(new FontData[] { fd });
		}
		FontData fd = dialog.open();
		if (fd==null) {
			return value;
		} else {
			return StringConverter.asString(fd);
		}
	}

	/*
	@Override
	Object getValue() {
		return getPropertyManager().getFont();
	}

	@Override
	void setValue(Object value) {
		Assert.isTrue(value instanceof FontData);
		getPropertyManager().setFont((FontData) value);
	}

	@Override
	String toDisplay(Object value) {
		Assert.isTrue(value instanceof FontData);
		return StringConverter.asString((FontData) value);
	}

	@Override
	Object openDialog(Object value, Shell shell) {
		FontDialog dialog = new FontDialog(shell);
		if (value != null) {
			Assert.isTrue(value instanceof FontData);
			dialog.setFontList(new FontData[] { ((FontData) value) });
		}
		return dialog.open();
	}

	@Override
	void clearValue() {
		getPropertyManager().setFont(null);
	}
	*/
}
