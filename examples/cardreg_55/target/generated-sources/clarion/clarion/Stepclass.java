package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

public class Stepclass
{
	public ClarionNumber controls;
	public Stepclass()
	{
		controls=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber getPercentile(ClarionObject value)
	{
		return Clarion.newNumber(50);
	}
	public ClarionString getValue(ClarionNumber percentile)
	{
		return Clarion.newString("");
	}
	public void init(ClarionNumber controls)
	{
		this.controls.setValue(controls);
	}
	public void kill()
	{
	}
	public void setLimit(ClarionObject l,ClarionObject h)
	{
	}
	public ClarionNumber setLimitNeeded()
	{
		return Clarion.newNumber(1);
	}
}
