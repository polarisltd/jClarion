package clarion;

import org.jclarion.clarion.runtime.concurrent.ISyncObject;

public abstract class Ireaderwriterlock
{

	public abstract ISyncObject reader();
	public abstract ISyncObject writer();
	public abstract void kill();
}
