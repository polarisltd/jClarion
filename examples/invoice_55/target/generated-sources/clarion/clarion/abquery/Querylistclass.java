package clarion.abquery;

import clarion.aberror.Errorclass;
import clarion.abquery.Queryclass;
import clarion.abquery.Querylistvisual;
import clarion.abutil.Iniclass;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Querylistclass extends Queryclass
{
	public Querylistvisual win=null;
	public Querylistclass()
	{
		win=null;
	}

	public void init(Querylistvisual q)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(Querylistvisual q,Iniclass inimgr,ClarionString family,Errorclass e)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
