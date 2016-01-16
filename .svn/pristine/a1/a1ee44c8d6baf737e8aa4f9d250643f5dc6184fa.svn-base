package org.jclarion.clarion.ide.model.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class AbstractModel 
{
	private String					name;
	private AbstractModel 			parent;
	private List<AbstractModel> 	children=null;
	private boolean					isDeleted;
	
	public AbstractModel(String name,AbstractModel parent)
	{
		this.name=name;
		this.parent=parent;
	}
	
	public void delete()
	{
		isDeleted=true;
		if (parent!=null) {
			parent.children.remove(this);
		}
		if (children!=null) {
			for (AbstractModel scan : children) {
				scan.delete();
			}
		}
	}
	
	public boolean isDeleted()
	{
		return isDeleted;
	}
	
	public AbstractModel getParent()
	{
		return parent;
	}
	
	public void setName(String name)
	{
		this.name=name;
	}
	
	public String getName()
	{
		return name;
	}
	
	public abstract List<AbstractModel> loadChildren();

	public List<AbstractModel> getChildren()
	{
		if (children==null) {
			children=loadChildren();
			for (AbstractModel model : children) {
				model.init();
			}
		}
		return children;
	}

	
	public abstract void init();
	
	public boolean reloadChildren()
	{
		if (children==null) return false;
		List<AbstractModel> loadChildren = loadChildren();
		Map<AbstractModel,AbstractModel> old = new HashMap<AbstractModel,AbstractModel>();
		for (AbstractModel scan : children) {
			old.put(scan,scan);
		}
		children=new ArrayList<AbstractModel>(loadChildren.size());
		
		boolean changed=false;
		
		for (AbstractModel scan : loadChildren) {
			AbstractModel orig = old.remove(scan);
			if (orig!=null) {
				children.add(orig);				
			} else {
				changed=true;
				children.add(scan);
				scan.init();
			}
		}
		
		if (!old.isEmpty()) {
			changed=true;
			for (AbstractModel model : old.values() ) {
				model.delete();
			}
		}		
		return changed;
	}
	
	public String toString()
	{
		return name;
	}
}
