package org.jclarion.clarion.compile.javaimport;

public class FieldImport {
	private String name;
	private String type;

	public FieldImport(String name,String type)
	{
		this.name=name;
		this.type=type;
	}

	public String getName() {
		return name;
	}

	public String getType() {
		return type;
	}

	@Override
	public String toString() {
		return "FieldImport [name=" + name + ", type=" + type + "]";
	}
	
	
	
}
