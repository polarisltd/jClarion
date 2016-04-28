package clarion;

import org.jclarion.clarion.runtime.concurrent.ISyncObject;

public class Criticalprocedure
{
	public ISyncObject sync;
	public Criticalprocedure()
	{
		sync=null;
		construct();
	}

	public void construct()
	{
		this.sync=null;
		return;
	}
	public void destruct()
	{
		this.kill();
		return;
	}
	public void init(ISyncObject o)
	{
		this.kill();
		if (!(o==null)) {
			o.Wait();
			this.sync=o;
		}
		return;
	}
	public void kill()
	{
		if (!(this.sync==null)) {
			this.sync.Release();
			this.sync=null;
		}
		return;
	}
}
