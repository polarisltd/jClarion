package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.concurrent.IMutex;
import org.jclarion.clarion.runtime.concurrent.ISyncObject;

public class Mutex
{
	public IMutex m;
	public Mutex()
	{
		m=null;
		construct();
	}

	public void construct()
	{
		this.m=new IMutex();
		return;
	}
	public void destruct()
	{
		this.m.Kill();
		return;
	}
	public void _wait()
	{
		this.m.Wait();
		return;
	}
	public ClarionNumber tryWait(ClarionNumber milliseconds)
	{
		return Clarion.newNumber(this.m.TryWait(milliseconds.intValue()));
	}
	public void release()
	{
		this.m.Release();
		return;
	}
	public void release(ClarionNumber count)
	{
		this.m.Release(count.intValue());
		return;
	}
	public ClarionNumber handleOf()
	{
		return Clarion.newNumber(this.m.handleOf());
	}
	public ISyncObject getIFace()
	{
		return this.m;
	}
}
