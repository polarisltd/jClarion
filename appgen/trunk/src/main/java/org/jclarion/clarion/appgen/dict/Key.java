package org.jclarion.clarion.appgen.dict;

import org.jclarion.clarion.appgen.loader.Definition;

public class Key extends Identity 
{

	private Definition key;

	public void setKey(Definition def)  
	{
		key=def;
	}
		

	public Definition getKey()
	{
		return key;
	}
	
	public String toString()
	{
		return key.toString();
	}

	private File file;
	
	public File getFile() {
		return file;
	}
	
	public void setFile(File src)
	{
		this.file=src;
	}

}
