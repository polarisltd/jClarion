package clarion.abreport;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Zoomitemqueue extends ClarionQueue
{
	public ClarionNumber percentile=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionString menutext=Clarion.newString(64).setEncoding(ClarionString.CSTRING);
	public ClarionString statustext=Clarion.newString(64).setEncoding(ClarionString.CSTRING);

	public Zoomitemqueue()
	{
		this.addVariable("Percentile",this.percentile);
		this.addVariable("MenuText",this.menutext);
		this.addVariable("StatusText",this.statustext);
	}
}
