package org.jclarion.clarion.appgen.dict;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.appgen.loader.Definition;

public class File extends Identity 
{

	private Definition file;
	private Definition record;
	private Map<String,Key> keys = new LinkedHashMap<String,Key>();
	private Map<String,Field> fields = new LinkedHashMap<String,Field>();
	private List<RelationKey> relations = new ArrayList<RelationKey>();
	//private List<RelationKey> foreignRelations = new ArrayList<RelationKey>();

	private boolean threaded=false;
	
	public void setFile(Definition def)  
	{
		file=def;
		if (file.getProperty("THREAD")!=null) { 
			file=file.remove("THREAD");
			threaded=true;
		}
	}
	
	public boolean isThreaded()
	{
		return threaded;
	}
		
	public void setRecord(Definition def)  
	{
		record=def;
	}

	public Definition getFile() {
		return file;
	}

	public Definition getRecord() {
		return record;
	}

	public void addKey(Key k) 
	{
		keys.put(k.getKey().getName().toUpperCase(),k);
		k.setFile(this);
	}

	public void addField(Field fld) {
		fields.put(fld.getField().getName().toUpperCase(),fld);
	}
	
	public Key getKey(String name)
	{
		name=name.toUpperCase();
		name=name.substring(name.indexOf(':')+1);
		return keys.get(name);
	}
	
	public Field getField(String name)
	{
		name=name.toUpperCase();
		name=name.substring(name.indexOf(':')+1);
		return fields.get(name);
	}
	
	public Iterable<Field> getFields()
	{
		return fields.values();
	}

	public RelationKey addRelationKey(File f, Key k,boolean oneToMany) 
	{
		RelationKey rk = new RelationKey(f,k,oneToMany);
		relations.add(rk);
		return rk;
	}

	public Iterable<Key> getKeys() {
		return keys.values();
	}

	public Iterable<RelationKey> getRelations() {
		return relations;
	}

	public RelationKey getRelation(int ofs) {
		getRelations();
		return relations.get(ofs);
	}

}
