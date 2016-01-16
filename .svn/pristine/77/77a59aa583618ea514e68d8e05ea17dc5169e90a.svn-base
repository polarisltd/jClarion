package org.jclarion.clarion.appgen.template.prompt;



public class AtTreeNodeEntry extends TreeNodeEntry
{
	private String description;
	private int    priority;
	
	
	public AtTreeNodeEntry(String description, int priority) 
	{
		this.description = description;
		this.priority = priority;
	}

	public String getDescription() {
		return description;
	}


	public int getPriority() {
		return priority;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		AtTreeNodeEntry other = (AtTreeNodeEntry) obj;
		if (description == null) {
			if (other.description != null) return false;
		} else if (!description.equals(other.description))
			return false;
		if (priority != other.priority) return false;
		return true;
	}
}