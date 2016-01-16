package org.jclarion.clarion.ide.model;

import org.eclipse.core.commands.operations.UndoContext;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

/**
 * Wraps an {@link AbstractControl} for passing around as input to editors and
 * views. Provides convenience getter and setter methods for setting properties.
 */
public class ControlWrapper	extends AbstractPropertyObjectWrapper {

	public final String type;

	public ControlWrapper(AbstractControl control, JavaSwingProvider provider, UndoContext undoContext) {
		super(control, provider, undoContext);
		this.type = getType(control);
	}

	@Override
	public String getName() {
		return po.getProperty(Prop.TEXT).toString();
	}

	@Override
	public String toString() {
		String name = po.getProperty(Prop.TEXT).toString().trim();
		if (name.startsWith("@")) {
			name="";
		}
		if (name.length()==0) {
			ExtendProperties ep = ExtendProperties.get(po);
			name=ep.getLabel();
			if (name==null) name="";
			if (name.length()==0) {
				String bits[] = ep.getUsevars();
				if (bits.length>0) {
					name=bits[0];
				}
			}
		}
		if (name.trim().length()>0) {
			return type+" : "+name;
		} else {
			return type;
		}
	}

	public AbstractControl getControl() {
		return (AbstractControl) po;
	}

	public AbstractPropertyObjectWrapper getParent() {
		if (getControl().getParent() == null) {
			AbstractWindowTarget awt = getControl().getWindowOwner();
			return new WindowTargetWrapper(awt,provider,null,undoContext);
		}
		return new ControlWrapper(getControl().getParent(), provider, undoContext);
	}

	/**
	 * Returns a string representation of the supplied control's type
	 */
	private String getType(AbstractControl control) {
		return control.getClass().getSimpleName().replaceAll("Control", "");
	}
}