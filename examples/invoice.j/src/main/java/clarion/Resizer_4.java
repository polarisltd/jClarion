package clarion;

import clarion.Windowresizeclass;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Resizer_4 extends Windowresizeclass
{
	public Resizer_4()
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
	public void init(ClarionNumber appstrategy,ClarionNumber setWindowMinSize,ClarionNumber setWindowMaxSize)
	{
		super.init(appstrategy.like(),setWindowMinSize.like(),setWindowMaxSize.like());
		this.deferMoves.setValue(Constants.FALSE);
		this.setParentDefaults();
	}
}
