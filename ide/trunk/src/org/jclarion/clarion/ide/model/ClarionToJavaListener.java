package org.jclarion.clarion.ide.model;

import java.util.List;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.PropertyChange;
import org.jclarion.clarion.ide.view.ClarionToJavaViewer;

/**
 * Interface for registering interest in UI events and changes to
 * {@link PropertyObjects}s provided by {@link JavaSwingProvider} and displayed
 * by {@link ClarionToJavaViewer}
 */
public interface ClarionToJavaListener {

	/**
	 * One or more {@link AbstractControl} widgets have been selected. May
	 * be empty if selection is cleared
	 *
	 * @param controls
	 *            the newly selected controls
	 */
	public void mouseSelectionChanged(List<PropertyObject> controls);

	public void mouseDragged(
			List<PropertyObject> controls,
			int sx,int sy,
			int x, int y,
			int deltaX, int deltaY,
			int deltaWidth, int deltaHeight,
			boolean rehome, List<PropertyChange> otherChanges);
	
	public void structureChanged(PropertyObject parent);

	/**
	 * An {@link AbstractControl} has changed
	 *
	 * @param control
	 *            the control that has changed
	 * @param property
	 *            the property id
	 * @param value
	 *            the new value
	 */
	public void controlChanged(PropertyObject control, int property, Object value);
}