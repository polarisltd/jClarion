package org.jclarion.clarion.appgen.app;

import java.util.LinkedHashMap;
import java.util.Map;

public class PrimaryFile extends File
{
	private int 					instanceID;
	private String 	 				key;
	private Map<String,FileJoin> 	secondary=new LinkedHashMap<String,FileJoin>();
	
	public int getInstanceID() 
	{
		return instanceID;
	}
	
	public PrimaryFile()
	{
	}
	
	public PrimaryFile(PrimaryFile base)
	{
		super(base,null);
		this.key=base.key;
		cloneAddSecondary(this);
	}

	private void cloneAddSecondary(File file) {
		for (FileJoin fj : file.getChildren()) {
			add(fj);
			cloneAddSecondary(fj.getChild());
		}
	}

	public PrimaryFile clone()
	{
		return new PrimaryFile(this);
	}
	
	@Override
	public PrimaryFile clone(FileJoin parent)
	{
		return clone();
	}
	
	public void setInstanceID(int instanceID) 
	{
		this.instanceID = instanceID;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		if (key!=null && key.length()==0) key=null;
		this.key = key;
	}
	
	public void add(FileJoin join)
	{
		secondary.put(join.getChild().getName().toUpperCase(),join);
	}
	
	public void deleteSecondary(FileJoin join)
	{
		secondary.remove(join.getChild().getName().toUpperCase());
	}
	
	public Iterable<FileJoin> getJoins()
	{
		return secondary.values();
	}
	
	public FileJoin getJoin(String name)
	{
		return secondary.get(name.toUpperCase());
	}

	@Override
	public PrimaryFile getPrimary()
	{
		return this;
	}

	@Override
	public String toString() {
		return "PrimaryFile [instanceID=" + instanceID + ", key=" + key
				+ ", secondary=" + secondary + ", getName()=" + getName()
				+ ", getChildren()=" + getChildren() + "]";
	}

	
}
