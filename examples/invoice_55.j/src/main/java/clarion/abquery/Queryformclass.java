package clarion.abquery;

import clarion.aberror.Errorclass;
import clarion.abquery.Queryclass;
import clarion.abquery.Queryformvisual;
import clarion.abutil.Iniclass;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Queryformclass extends Queryclass
{
	public Queryformvisual win=null;
	public Queryformclass()
	{
		win=null;
	}

	public void init(Queryformvisual q)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(Queryformvisual q,Iniclass inimgr,ClarionString family,Errorclass e)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
