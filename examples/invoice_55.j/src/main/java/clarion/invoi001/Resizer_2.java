package clarion.invoi001;

import clarion.abresize.Windowresizeclass;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Resizer_2 extends Windowresizeclass
{
	public Resizer_2()
	{
	}

	public void init(ClarionNumber p0,ClarionNumber p1)
	{
		init(p0,p1,Clarion.newNumber(Constants.FALSE));
	}
	public void init(ClarionNumber p0)
	{
		init(p0,Clarion.newNumber(Constants.FALSE));
	}
	public void init()
	{
		init(Clarion.newNumber(Appstrategy.RESIZE));
	}
	public void init(ClarionNumber appstrategy,ClarionNumber setwindowminsize,ClarionNumber setwindowmaxsize)
	{
		super.init(appstrategy.like(),setwindowminsize.like(),setwindowmaxsize.like());
		this.defermoves.setValue(Constants.FALSE);
		this.setparentdefaults();
	}
}
