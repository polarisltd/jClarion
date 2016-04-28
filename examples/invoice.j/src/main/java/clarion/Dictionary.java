package clarion;

import clarion.Invoibc;
import org.jclarion.clarion.runtime.CRun;

public class Dictionary extends org.jclarion.clarion.AbstractThreaded
{
	public Dictionary()
	{
		construct();
	}
	public void initThread() {
		super.initThread();
		CRun.addInitThreadHook(new Runnable() { public void run() { construct(); } });
	}
	protected void lock(Dictionary base,Thread thread)
	{
		super.lock(base,thread);
	}
	public Object getLockedObject(Thread thread)
	{
		Dictionary result=new Dictionary();
		result.lock(this,thread);
		return result;
	}

	public void construct()
	{
		Invoibc.dctInit();
	}
	public void destruct()
	{
		Invoibc.dctKill();
	}
}