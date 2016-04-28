package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Constdescriptorlist extends ClarionQueue
{
	public ClarionNumber itemType=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionAny destination=Clarion.newAny();

	public Constdescriptorlist()
	{
		this.addVariable("ItemType",this.itemType);
		this.addVariable("Destination",this.destination);
	}
}
