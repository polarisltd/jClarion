package org.jclarion.clarion.ide.model;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.ide.Compiler;

/**
 * Use to figure out where property objects can be moved to 
 * 
 * @author barney
 *
 */
public class PropertyObjectNavigator {

	private PropertyObject original;
	
	
	private PropertyObject object;
	private int position;
	private boolean skip=false;

	public PropertyObjectNavigator()
	{
	}
	
	public void set(PropertyObject object)
	{
		this.original=object;
		this.object=object.getParentPropertyObject();
		if (this.object==null) return;
		this.position= this.object.getChildIndex(object);
		skip=true;
	}

	public void previous() 
	{
		if (object==null) return;
		
		while ( true ) {
			if (position==0) {
				PropertyObject parent = object.getParentPropertyObject();
				if (parent==null) {
					object=null;
					return;
				}
				position = parent.getChildIndex(object);
				object=parent;
			} else {
				// consider being last child of prior sibling
				PropertyObject child = object.getChildren().get(position-1);
				object=child;
				position=child.getChildren().size();
			}
			if (Compiler.isValidParent(original, object)) {
				return;
			}				
		}
	}
	
	public void next()
	{
		if (object==null) return;
		
		if (skip) {
			position++;
			skip=false;
		}
		
		while ( true ) {
			if (position==object.getChildren().size()) {
				PropertyObject parent = object.getParentPropertyObject();
				if (parent==null) {
					object=null;
					position=0;
					return;
				}
				position = parent.getChildIndex(object)+1;
				object=parent;				
			} else {
				PropertyObject child = object.getChildren().get(position);
				object=child;
				position=0;
			}
			if (Compiler.isValidParent(original, object)) {
				return;
			}				
		}
	}
	
	public PropertyObject getObject()
	{
		return object;
	}
	
	public int getIndex()
	{
		return position;
	}
}
