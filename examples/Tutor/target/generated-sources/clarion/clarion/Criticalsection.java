package clarion;

import org.jclarion.clarion.runtime.concurrent.ICriticalSection;
import org.jclarion.clarion.runtime.concurrent.ISyncObject;

public class Criticalsection
{
	public ICriticalSection cs;
	public Criticalsection()
	{
		cs=null;
		construct();
	}

	public void construct()
	{
		this.cs=new ICriticalSection();
		return;
	}
	public void destruct()
	{
		this.cs.Kill();
		return;
	}
	public void _wait()
	{
		this.cs.Wait();
		return;
	}
	public void release()
	{
		this.cs.Release();
		return;
	}
	public ISyncObject getIFace()
	{
		return this.cs;
	}
}
