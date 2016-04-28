package clarion.aberror;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pnq extends ClarionQueue
{
	public ClarionNumber thread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString name=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Pnq()
	{
		this.addVariable("Thread",this.thread);
		this.addVariable("Name",this.name);
	}
}
