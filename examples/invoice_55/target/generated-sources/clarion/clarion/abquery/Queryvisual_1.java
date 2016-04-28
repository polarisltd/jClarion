package clarion.abquery;

import clarion.Sectorqueue;
import clarion.abquery.Queryclass_1;
import clarion.abresize.Windowresizeclass;
import clarion.abwindow.Windowmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Queryvisual_1 extends Windowmanager
{
	public Queryclass_1 qc=null;
	public Windowresizeclass resizer=null;
	public Sectorqueue queries=null;
	public Queryvisual_1()
	{
		qc=null;
		resizer=null;
		queries=null;
	}

	public ClarionNumber init()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takeaccepted()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takefieldevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takewindowevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void resetfromquery()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void updatefields()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
