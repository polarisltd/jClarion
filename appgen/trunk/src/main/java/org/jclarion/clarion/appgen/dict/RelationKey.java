package org.jclarion.clarion.appgen.dict;

import java.util.ArrayList;
import java.util.List;

public class RelationKey 
{
	private File 		file;
	private Key  		key;
	private RelationKey other;
	private String      deleteMode;
	public String getDeleteMode() {
		return deleteMode;
	}

	public void setDeleteMode(String deleteMode) {
		this.deleteMode = deleteMode;
	}

	public String getUpdateMode() {
		return updateMode;
	}

	public void setUpdateMode(String updateMode) {
		this.updateMode = updateMode;
	}

	private String      updateMode;
	
	private List<Join> joins = new ArrayList<Join>();
	private boolean oneToMany;
	
	public RelationKey(File f,Key k,boolean oneToMany)
	{
		this.file=f;
		this.key=k;
		this.oneToMany=oneToMany;
	}
	
	public boolean isOneToMany() {
		return oneToMany;
	}

	public void join(RelationKey other)
	{
		this.other=other;
		other.other=this;
	}

	public File getFile() {
		return file;
	}

	public Key getKey() {
		return key;
	}

	public RelationKey getOther() {
		return other;
	}

	public void addRelationship(Field from, Field to) 
	{
		joins.add(new Join(from,to));
	}

	public List<Join> getJoins() {
		return joins;
	}

	public Join getJoin(int ofs) {
		return joins.get(ofs);
	}
	
	public String toString()
	{
		return file.getFile().getName()+" "+getKeyString(key);
	}

	private String getKeyString(Key key2) 
	{
		if (key2==null) return "NONE";
		return key2.getKey().getName();
	}
}
