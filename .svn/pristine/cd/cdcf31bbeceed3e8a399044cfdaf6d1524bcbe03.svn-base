package org.jclarion.clarion.ide.view.properties;

import org.eclipse.core.runtime.Assert;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.views.properties.tabbed.ITabbedPropertyConstants;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

import org.jclarion.clarion.ide.model.ClarionIncContent;

public class NamePropertySection extends AbstractJClarionPropertySection {

	private final ModifyListener listener;

	private ClarionIncContent input;
	private Text text;

	public NamePropertySection() {
		super();
		this.listener = new Listener();
	}

	@Override
	public final void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
		super.createControls(parent, tabbedPropertySheetPage);
		Composite composite = createForm(parent);
		text = createText(composite);
		text.addModifyListener(listener);

		FormData data = new FormData();
		data.top = new FormAttachment(0, ITabbedPropertyConstants.VSPACE * 2);
		data.left = new FormAttachment(0);
		data.right = new FormAttachment(100);
		text.setLayoutData(data);
	}

	@Override
	public final void refresh() {
        text.removeModifyListener(listener);
        text.setText(getSafeString(input.getName()));
        text.addModifyListener(listener);
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(text);
	}

	@Override
	void doSetInput(Object input) {
        Assert.isTrue(input instanceof ClarionIncContent);
        this.input = (ClarionIncContent) input;
	}

	private class Listener implements ModifyListener {

		@Override
		public void modifyText(ModifyEvent e) {
			input.setName(text.getText());
		}

	}

}
