package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.concurrent.ISemaphore;
import org.jclarion.clarion.runtime.concurrent.ISyncObject;

public class Semaphore
{
	public ISemaphore s;
	public Semaphore()
	{
		s=null;
		construct();
	}

	public void construct()
	{
		this.s=new ISemaphore(null,null);
		return;
	}
	public void destruct()
	{
		this.s.Kill();
		return;
	}
	public void _wait()
	{
		this.s.Wait();
		return;
	}
	public ClarionNumber tryWait(ClarionNumber milliseconds)
	{
		return Clarion.newNumber(this.s.TryWait(milliseconds.intValue()));
	}
	public void release()
	{
		this.s.Release();
		return;
	}
	public void release(ClarionNumber count)
	{
		this.s.Release(count.intValue());
		return;
	}
	public ClarionNumber handleOf()
	{
		return Clarion.newNumber(this.s.handleOf());
	}
	public ISyncObject getIFace()
	{
		return this.s;
	}
}
