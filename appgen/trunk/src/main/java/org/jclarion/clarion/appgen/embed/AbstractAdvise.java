package org.jclarion.clarion.appgen.embed;



public abstract class AbstractAdvise implements Advise
{
	private int priority;
	private int instanceID;
	private int	superInstanceID;

	public AbstractAdvise(int priority,int s_instance,int instance)
	{
		this.priority=priority;
		this.superInstanceID=s_instance;
		this.instanceID=instance;
	}

	@Override
	public int getPriority() {
		return priority;
	}
	
	public int getInstanceID()
	{
		return instanceID;
	}

	@Override
	public int compareTo(Advise bo) {
		AbstractAdvise o = (AbstractAdvise)bo;
		int diff = priority-o.priority;
		if (diff==0) diff = superInstanceID-o.superInstanceID;
		if (diff==0) diff = instanceID-o.instanceID;
		return diff;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + instanceID;
		result = prime * result + priority;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		AbstractAdvise other = (AbstractAdvise)obj;
		if (instanceID != other.instanceID) return false;
		if (priority != other.priority) return false;
		return true;
	}
	
	public abstract EmbedKey getKey();
}
