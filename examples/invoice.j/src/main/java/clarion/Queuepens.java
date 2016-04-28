package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Queuepens extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Queuepens()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Color",this.color);
		this.addVariable("Width",this.width);
		this.addVariable("Style",this.style);
	}
}
