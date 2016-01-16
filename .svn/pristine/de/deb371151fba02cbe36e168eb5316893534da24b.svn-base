package org.jclarion.clarion.ide.model.fieldops;

import java.util.LinkedList;

import org.eclipse.swt.widgets.TreeItem;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;

/**
 * Model an mutation operation on a set of fields.  Field ops are built up over an edit and on commit replayed on real non-dirty field store. This object
 *  can also eventually serve as basis of UNDO/REDO log as well if required.
 * 
 * @author barney
 */
public abstract class AbstractOp {
	
	public static void render(Field f,TreeItem field) {
		field.setData(f);
		field.setText(0,f.getLabel());
		field.setText(1,f.getDefinition().getTypeProperty().render());
		
		String init = f.getGuiDefinition().getValue("INITIAL");
		if (init!=null) {
			int len = init.length();
			while (len>0 && init.charAt(len-1)==' ') {
				len--;
			}
			field.setText(2,init.substring(0,len));
		}
		
		String comment = f.getDefinition().getComment();
		if (comment!=null) {
			field.setText(3,comment);
		}
	}

	public static String[] getPath(FieldStore field) {
		
		if (field instanceof Field) {
			return getPath((Field)field);
		}
		return new String[0];
	}
	
	public static String[] getPath(Field field) {
		
		LinkedList<String> path = new LinkedList<String>();
		
		while (field!=null) {
			path.addFirst(field.getLabel());
			field=field.getParentField();
		}
		return path.toArray(new String[path.size()]);
	}
	
	public static TreeItem getItem(TreeItem base,String ...path)
	{
		
		for (String scan : path) {
			if (base==null) return null;
			TreeItem match=null;
			for (TreeItem kid : base.getItems() ){
				if (kid.isDisposed()) continue;
				Field test = (Field)kid.getData();
				if (test.getLabel().equalsIgnoreCase(scan)) {
					match=kid;
					break;
				}
			}
			base=match;
		}
		return base;
	}
	
	public static FieldStore getStore(FieldStore base,String ...path)
	{
		for (String scan : path ) {
			base=base.getField(scan);
			if (base==null) break;
		}
		return base;
	}
	
	public static Field getField(FieldStore base,String ...path)
	{
		return (Field)getStore(base,path);
	}
	
	public abstract void apply(FieldStore root);	
	public abstract void apply(TreeItem root);
}
