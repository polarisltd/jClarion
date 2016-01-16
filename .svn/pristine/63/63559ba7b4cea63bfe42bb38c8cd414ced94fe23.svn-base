package org.jclarion.clarion.appgen.app;

public interface FieldStore {
	public void addField(Field f);
	public void replaceField(String oldName,Field newField); 
	public void addField(Field f,int position);
	public Field getField(String name);
	public Iterable<Field> getFields();
	public void deleteField(String name);
	public Field getParentField();
	public int getOffset(Field f);
	public Field getPrevious(Field f);
	public Field getNext(Field f);
	public Field getField(int ofs);
	public int 	 getFieldCount();
	public Field getFirstField();
	public Field getLastField();
	public FieldStore getParentStore();
}
