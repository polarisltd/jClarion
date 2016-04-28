package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Queueobjects extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Queueobjects()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Type",this.type);
	}
}
