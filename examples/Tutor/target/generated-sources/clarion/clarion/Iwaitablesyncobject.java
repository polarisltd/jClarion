package clarion;

import org.jclarion.clarion.ClarionNumber;

public abstract class Iwaitablesyncobject
{

	public abstract void _wait();
	public abstract ClarionNumber tryWait(ClarionNumber milliseconds);
	public abstract void release();
	public abstract void release(ClarionNumber count);
	public abstract void kill();
	public abstract ClarionNumber handleOf();
}
