package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Threadedaction extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionString action=Clarion.newString(20);

	public Threadedaction()
	{
		this.addVariable("Id",this.id);
		this.addVariable("Action",this.action);
	}
}
