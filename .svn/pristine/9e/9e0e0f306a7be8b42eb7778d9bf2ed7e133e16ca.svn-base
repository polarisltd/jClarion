package org.jclarion.clarion.ide.view.properties;

import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.views.properties.tabbed.TabbedPropertySheetPage;

/**
 * Minimises the effort required to implement a dual text property section
 */
abstract class AbstractDualTextPropertySection extends AbstractPropertyObjectWrapperPropertySection {

    private Text text1;
    private Text text2;
    
    private PropTextBox box1;
    private PropTextBox box2;

    abstract String getLabel1();
    abstract String getLabel2();

	abstract Object getValue1();
	abstract void setValue1AsString(Object priorValue,String value,boolean commit);
    
	abstract Object getValue2();
	abstract void setValue2AsString(Object priorValue,String value,boolean commit);
    
	public AbstractDualTextPropertySection() {
		super();
	}

	@Override
	public final void createControls(Composite parent, TabbedPropertySheetPage tabbedPropertySheetPage) {
        super.createControls(parent, tabbedPropertySheetPage);
        Text[] texts = createTwoColumnTextForm(parent, getLabel1(), getLabel2());
        text1 = texts[0];
        text2 = texts[1];
        
		box1 = new PropTextBox(text1) {

			@Override
			public void setValueAsString(Object priorValue, String value,boolean commit) {
				AbstractDualTextPropertySection.this.setValue1AsString(priorValue, value, commit);
			}

			@Override
			public Object getValue() {
				return AbstractDualTextPropertySection.this.getValue1(); 
			}
			
		};
        
		
		box2 = new PropTextBox(text2) {

			@Override
			public void setValueAsString(Object priorValue, String value,boolean commit) {
				AbstractDualTextPropertySection.this.setValue2AsString(priorValue, value, commit);
			}

			@Override
			public Object getValue() {
				return AbstractDualTextPropertySection.this.getValue2(); 
			}
			
		};		
	}

	@Override
	public final void refresh() {
		box1.refresh();
		box2.refresh();
	}

	@Override
	public void dispose() {
		super.dispose();
		disposeIfNotNull(text1);
		disposeIfNotNull(text2);
	}
}
