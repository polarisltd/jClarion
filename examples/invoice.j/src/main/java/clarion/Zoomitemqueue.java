package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Zoomitemqueue extends ClarionQueue
{
	public ClarionNumber percentile=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionString menuText=Clarion.newString(64).setEncoding(ClarionString.CSTRING);
	public ClarionString statusText=Clarion.newString(64).setEncoding(ClarionString.CSTRING);

	public Zoomitemqueue()
	{
		this.addVariable("Percentile",this.percentile);
		this.addVariable("MenuText",this.menuText);
		this.addVariable("StatusText",this.statusText);
	}
}
