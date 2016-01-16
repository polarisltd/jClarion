package org.jclarion.clarion.appgen.embed;



public class EmbedKey 
{
	private String      name;
	private String[] 	instances;
	private int 		hashCode;
	private int 		length;
	private boolean		wildcards;
	
	
	public EmbedKey(String name,String ...inst)
	{
		this.name=name.toLowerCase();
		this.instances=new String[inst.length];
		for (int scan=0;scan<inst.length;scan++) {
			instances[scan]=inst[scan]==null ? null  : inst[scan].toLowerCase();
		}
		hashCode=this.name.hashCode();
		
		this.length=instances.length;
		while (this.length>0 && this.instances[this.length-1]==null) {
			this.length--;
		}
		
		for (int scan=0;scan<this.length;scan++) {
			String i = instances[scan];
			if (i==null) {
				wildcards=true;
				hashCode=hashCode*31;
			}  else {
				i=i.toLowerCase();
				instances[scan]=i;
				hashCode=hashCode*31+i.hashCode();
			}
		}
	}
	
	private EmbedKey(EmbedKey source)
	{
		this.name=source.name;
		this.instances=source.instances;
		this.length=source.length-1;
		this.hashCode=name.hashCode();
		for (int scan=0;scan<this.length;scan++) {
			hashCode=hashCode*31+instances[scan].hashCode();
		}
	}

	public EmbedKey shorten()
	{
		return new EmbedKey(this);
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getInstance(int ofs)
	{
		return instances[ofs];
	}
	
	public int getInstanceCount()
	{
		return length;
	}
	
	@Override
	public int hashCode()
	{
		return hashCode;
	}
	
	public boolean containsWildcards()
	{
		return wildcards;
	}
	
	@Override
	public boolean equals(Object o)
	{
		if (o==null) return false;
		if (!(o instanceof EmbedKey)) return false;
		
		EmbedKey other = (EmbedKey)o;
		if (!other.name.equals(name)) return false;
		if (other.length!=length) return false;
		
		for (int scan=0;scan<length;scan++) {
			if (instances[scan]==null ^ other.instances[scan]==null) return false;  // either or, not both
			if (other.instances[scan]==null) continue;
			if (!other.instances[scan].equals(instances[scan])) return false;
		}
		return true;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("Key[").append(name);
		for (int scan=0;scan<length;scan++) {
			sb.append(',').append(instances[scan]);
		}
		sb.append(']');
		return sb.toString();
	}
	
	
}
