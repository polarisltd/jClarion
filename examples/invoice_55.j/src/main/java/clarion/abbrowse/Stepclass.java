package clarion.abbrowse;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Stepclass
{
	public ClarionNumber controls=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Stepclass()
	{
		controls=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber getpercentile(ClarionObject value)
	{
		return Clarion.newNumber(50);
	}
	public ClarionString getvalue(ClarionNumber percentile)
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
	public void setlimit(ClarionObject l,ClarionObject h)
	{
	}
	public ClarionNumber setlimitneeded()
	{
		return Clarion.newNumber(1);
	}
}
