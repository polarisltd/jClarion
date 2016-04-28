package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Buttonlist extends ClarionQueue
{
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber action=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Buttonlist()
	{
		this.addVariable("Control",this.control);
		this.addVariable("Action",this.action);
	}
}
