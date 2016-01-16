package org.jclarion.clarion.appgen.template.cmd;

public class TemplateID {
	private String chain;
	private String type;

	public TemplateID(String chain,String type)
	{
		this.chain=chain;
		this.type=type;
	}

	public String getChain() {
		return chain;
	}

	public String getType() {
		return type;
	}

	public void setChain(String name) 
	{
		this.chain=name;
	}

	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((chain == null) ? 0 : chain.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TemplateID other = (TemplateID) obj;
		if (chain == null) {
			if (other.chain != null)
				return false;
		} else if (!chain.equals(other.chain))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "TemplateID [chain=" + chain + ", type=" + type + "]";
	}
}
