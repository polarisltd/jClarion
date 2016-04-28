package clarion.abutil;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Constdescriptorlist extends ClarionQueue
{
	public ClarionNumber itemtype=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionAny destination=Clarion.newAny();

	public Constdescriptorlist()
	{
		this.addVariable("ItemType",this.itemtype);
		this.addVariable("Destination",this.destination);
	}
}
