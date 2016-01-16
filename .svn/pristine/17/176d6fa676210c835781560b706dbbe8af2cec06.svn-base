package org.jclarion.clarion.ide.model.fieldops;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.TreeItem;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;

public class AddOp extends AbstractOp
{
	private String[] 	store;
	private Field 		add;
	private int ofs;

	public AddOp(FieldStore store,Field add)
	{
		this.store=getPath(store);
		this.add=add;
		ofs=-1;
	}

	public AddOp(String[] path,Field add)
	{
		this.store=path;
		this.add=add;
		ofs=-1;
	}
	
	public AddOp(FieldStore store,Field add,int ofs)
	{
		this.store=getPath(store);
		this.add=add;
		this.ofs=ofs;
	}
	
	@Override
	public void apply(FieldStore root) 
	{
		add.clear(); // remove any accumulated children. These will be added by later ops
		if (ofs>-1) {
			getStore(root,store).addField(add,ofs);
		} else {
			getStore(root,store).addField(add);
		}
	}

	@Override
	public void apply(TreeItem root) 
	{
		root=getItem(root,store);
		TreeItem ti = null;
		if (ofs>-1) {
			ti=new TreeItem(root,SWT.None,ofs);
		} else {
			ti=new TreeItem(root,SWT.None);
		}
		root.setExpanded(true);		
		render(add,ti);
		ti.getParent().setSelection(ti);
	}

}
