package org.jclarion.clarion.ide.model;

import org.jclarion.clarion.appgen.embed.EmbedKey;

public class EmbedPriorityKey
{
	
	private EmbedKey key;
	private int 	 priority;
	private int 	 hash;

	public EmbedPriorityKey(EmbedKey key,int priority)
	{
		this.key=key;
		this.priority=priority;
		hash = 31 * key.hashCode() +priority; 
	}
	
	public EmbedKey getKey()
	{
		return key;
	}
	
	public int getPriority()
	{
		return priority;
	}

	@Override
	public int hashCode() {
		return hash;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		EmbedPriorityKey other = (EmbedPriorityKey) obj;
		if (priority != other.priority) return false;
		if (!key.equals(other.key)) return false;
		return true;
	}
	
	
}