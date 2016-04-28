package clarion;

import clarion.Errorclass;
import clarion.Iniclass;
import clarion.Queryclass;
import clarion.Queryformvisual;
import org.jclarion.clarion.ClarionString;

public class Queryformclass extends Queryclass
{
	public Queryformvisual win;
	public Queryformclass()
	{
		win=null;
	}

	public void init(Queryformvisual q)
	{
		this.win=q;
		q.qfc=this;
		super.init(q);
	}
	public void init(Queryformvisual q,Iniclass iNIMgr,ClarionString family,Errorclass e)
	{
		this.win=q;
		q.qfc=this;
		super.init(this.win,iNIMgr,family.like(),e);
	}
	public void kill()
	{
		if (!(this.win==null)) {
			this.win.kill();
		}
		super.kill();
	}
}
