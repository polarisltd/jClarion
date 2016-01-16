package org.jclarion.clarion.ide.model.fieldops;

import org.eclipse.swt.widgets.TreeItem;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;

public class ModifyOp extends AbstractOp
{
	private String[] 	store;
	private String 		find;
	private Field 		replace;

	public ModifyOp(FieldStore store,String find,Field replace)
	{
		this.store=getPath(store);
		this.find=find;
		this.replace=replace;
	}
	
	@Override
	public void apply(FieldStore root) 
	{
		FieldStore base =getStore(root,store);
		Field old = base.getField(find);
		base.replaceField(find, replace);
		if (old!=null) {
			replace.clear();
			for (Field f : old.getFields()) {
				replace.addField(f);
			}
		}
	}

	@Override
	public void apply(TreeItem root) 
	{
		render(replace,getItem(getItem(root,store),find));
	}

}
