package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.List;

public class File {
	private String 	 		name;
	
	private FileJoin 		parent;
	private List<FileJoin> 	children=new ArrayList<FileJoin>();
	
	public File()
	{		
	}
	
	public File(File base,FileJoin parent)
	{
		this.name=base.name;
		this.parent=parent;
		for (FileJoin scan : base.children ) {
			scan = new FileJoin(scan,this);
			children.add(scan);
		}
	}
	
	public File clone(FileJoin parent)
	{
		return new File(this,parent);
	}

	public File(String name)
	{		
		this.name=name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
		
	public FileJoin addChild(File child,boolean inner,String join)
	{
		FileJoin fj = new FileJoin(this,child,inner,join);
		children.add(fj);
		child.parent=fj;
		if (getPrimary()!=null) {
			getPrimary().add(fj);
		}
		return fj;
	}
	
	public PrimaryFile getPrimary()
	{
		if (parent!=null) {
			return parent.getPrimary();
		}
		return null;
	}
	
	public Iterable<FileJoin> getChildren()
	{
		return children;
	}
	
	public FileJoin getParent()
	{
		return parent;
	}

	public void delete(FileJoin fileJoin) 
	{
		if (!children.remove(fileJoin)) {
			throw new IllegalStateException("Noting was deleted!!!");
		}
		if (getPrimary()!=null) {
			getPrimary().deleteSecondary(fileJoin);
		}
	}

	@Override
	public String toString() {
		return "File [name=" + name + ", children=" + children + "]";
	}
	
}
