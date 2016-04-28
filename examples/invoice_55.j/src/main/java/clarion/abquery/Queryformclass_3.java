package clarion.abquery;

import clarion.aberror.Errorclass;
import clarion.abquery.Queryclass_3;
import clarion.abquery.Queryformvisual_3;
import clarion.abutil.Iniclass;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Queryformclass_3 extends Queryclass_3
{
	public Queryformvisual_3 win=null;
	public Queryformclass_3()
	{
		win=null;
	}

	public void init(Queryformvisual_3 q)
	{
		this.win=q;
		q.qfc=this;
		super.init(q);
	}
	public void init(Queryformvisual_3 q,Iniclass inimgr,ClarionString family,Errorclass e)
	{
		this.win=q;
		q.qfc=this;
		super.init(this.win,inimgr,family.like(),e);
	}
	public void kill()
	{
		if (!(this.win==null)) {
			this.win.kill();
		}
		super.kill();
	}
}
