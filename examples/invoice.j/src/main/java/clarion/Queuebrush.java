package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Queuebrush extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber hatch=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Queuebrush()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Color",this.color);
		this.addVariable("Style",this.style);
		this.addVariable("Hatch",this.hatch);
	}
}
