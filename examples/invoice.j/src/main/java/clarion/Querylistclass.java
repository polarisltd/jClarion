package clarion;

import clarion.Errorclass;
import clarion.Iniclass;
import clarion.Queryclass;
import clarion.Querylistvisual;
import org.jclarion.clarion.ClarionString;

public class Querylistclass extends Queryclass
{
	public Querylistvisual win;
	public Querylistclass()
	{
		win=null;
	}

	public void init(Querylistvisual q)
	{
		this.win=q;
		q.qfc=this;
		super.init(q);
	}
	public void init(Querylistvisual q,Iniclass iNIMgr,ClarionString family,Errorclass e)
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
