package org.jclarion.clarion.appgen.dict;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Dict {

	public static void main(String args[]) {
		java.util.HashSet<String> h = new java.util.HashSet<String>(128);
		for (String s : new String[] { "cunits","unitline","unithist","Makes","Types","unitinv" }) {
			h.add(s);
		}
		System.out.println(h);
	}
	
	private String version;
	private String longDesc;
	private Map<String,File> files=new LinkedHashMap<String,File>();
	private Map<String,File> prefix=new LinkedHashMap<String,File>();
	
	
	public String getVersion() {
		return version;
	}
	
	public void setVersion(String version) {
		this.version = version;
	}
	
	public String getLongDesc() {
		return longDesc;
	}
	
	public void setLongDesc(String longDesc) {
		this.longDesc = longDesc;
	}
	
	public Set<String> getFileNames()
	{
		return files.keySet();
	}
	
	public Collection<File> getFiles()
	{
		return files.values();
	}
	
	public void addFile(File f) 
	{
		//System.out.println(files.size()+" "+f.getFile().getName());
		files.put(f.getFile().getName().toUpperCase(),f);
		prefix.put(f.getFile().getValue("PRE").toUpperCase(),f);
	}

	public File getFile(String name)
	{
		return files.get(name.toUpperCase());
	}
	
	public File getFileByPrefix(String prefix) {
		return this.prefix.get(prefix.toUpperCase());
	}	

	private List<RelationKey> relations=new ArrayList<RelationKey>();
	
	public void addRelation(RelationKey file) {
		relations.add(file);
	}
	
	public Collection<RelationKey> getRelations()
	{
		return relations;
	}

	
}
