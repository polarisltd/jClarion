package clarion.abquery;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Popupqueue extends ClarionQueue
{
	public ClarionString queryname=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString popupid=Clarion.newString(100).setEncoding(ClarionString.CSTRING);

	public Popupqueue()
	{
		this.addVariable("QueryName",this.queryname);
		this.addVariable("PopupID",this.popupid);
	}
}
