package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Sectorqueue extends ClarionQueue
{
	public ClarionString family=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString item=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString type=Clarion.newString(100).setEncoding(ClarionString.CSTRING);

	public Sectorqueue()
	{
		this.addVariable("Family",this.family);
		this.addVariable("Item",this.item);
		this.addVariable("Type",this.type);
	}
}
