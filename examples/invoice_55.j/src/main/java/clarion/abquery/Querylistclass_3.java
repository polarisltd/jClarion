package clarion.abquery;

import clarion.aberror.Errorclass;
import clarion.abquery.Queryclass_3;
import clarion.abquery.Querylistvisual_3;
import clarion.abutil.Iniclass;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Querylistclass_3 extends Queryclass_3
{
	public Querylistvisual_3 win=null;
	public Querylistclass_3()
	{
		win=null;
	}

	public void init(Querylistvisual_3 q)
	{
		this.win=q;
		q.qfc=this;
		super.init(q);
	}
	public void init(Querylistvisual_3 q,Iniclass inimgr,ClarionString family,Errorclass e)
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
