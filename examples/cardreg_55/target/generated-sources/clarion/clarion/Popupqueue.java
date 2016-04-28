package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Popupqueue extends ClarionQueue
{
	public ClarionString queryName=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString popupID=Clarion.newString(100).setEncoding(ClarionString.CSTRING);

	public Popupqueue()
	{
		this.addVariable("QueryName",this.queryName);
		this.addVariable("PopupID",this.popupID);
	}
}
