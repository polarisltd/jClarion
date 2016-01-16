package org.jclarion.clarion.ide.model.fieldops;

import java.util.IdentityHashMap;
import java.util.Map;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.TreeItem;
import org.jclarion.clarion.appgen.app.Field;
import org.jclarion.clarion.appgen.app.FieldStore;

public class MoveOp extends AbstractOp
{
	private String[] 	source;
	private String[]	dest;
	private int 		position;

	public MoveOp(Field item,FieldStore target,int position)
	{
		this.source=getPath(item);
		this.dest=getPath(target);
		this.position=position;
	}
	
	@Override
	public void apply(FieldStore root) 
	{
		Field f = getField(root,source);
		FieldStore base = getStore(root, dest);
		f.getParent().deleteField(f.getLabel());
		base.addField(f,position);
	}

	@Override
	public void apply(TreeItem root) 
	{
		TreeItem item = getItem(root,source);
		Field f = (Field)item.getData();
		

		Map<Field,Boolean> expansions = new IdentityHashMap<Field,Boolean>();
		loadExpansions(item,expansions);		
		
		item.dispose();		
		
		TreeItem parent = getItem(root, dest);
		item = new TreeItem(parent,SWT.NONE,position);
		render(f,item);
		addAll(f,item);
		
		restoreExpansions(item,expansions);
		
		item.getParent().setSelection(item);
	}

	private void loadExpansions(TreeItem item, Map<Field, Boolean> expansions) 
	{
		expansions.put((Field)item.getData(),item.getExpanded()) ;
		for (TreeItem scan : item.getItems()) {
			loadExpansions(scan,expansions);
		}
	}
	
	private void restoreExpansions(TreeItem item, Map<Field, Boolean> expansions) 
	{
		Boolean b = expansions.get(item.getData());
		item.setExpanded(b!=null ? b : false);
		for (TreeItem scan : item.getItems()) {
			restoreExpansions(scan,expansions);
		}
	}
	
	
	private void addAll(Field f, TreeItem item) 
	{
		for (Field kid : f.getFields()) {
			TreeItem ikid = new TreeItem(item,SWT.NONE);
			render(kid,ikid);
			addAll(kid,ikid);
		}
	}

}
