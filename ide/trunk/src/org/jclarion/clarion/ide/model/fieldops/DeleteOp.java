package org.jclarion.clarion.ide.model.fieldops;

import org.eclipse.swt.widgets.TreeItem;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;

public class DeleteOp extends AbstractOp
{
	private String[] 		path;
	private String			delete;

	public DeleteOp(Field delete)
	{
		this.path=getPath(delete.getParent());
		this.delete=delete.getLabel();
	}
	
	@Override
	public void apply(FieldStore root) 
	{
		getStore(root,path).deleteField(delete);
	}

	@Override
	public void apply(TreeItem root) 
	{
		TreeItem ti = getItem(getItem(root,path),delete);
		TreeItem parent = ti.getParentItem();
		int pos = parent.indexOf(ti);
		ti.dispose();
		
		int count=parent.getItemCount();
		if (count<=pos) {
			pos=count-1;
		}
		
		if (pos>=0) {
			parent.getParent().select(parent.getItem(pos));
		} else {
			parent.getParent().select(parent);
		}
	}

}
