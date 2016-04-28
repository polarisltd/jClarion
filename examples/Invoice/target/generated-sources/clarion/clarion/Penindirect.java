package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Penindirect extends ClarionGroup
{
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Penindirect()
	{
		this.addVariable("Style",this.style);
		this.addVariable("Width",this.width);
		this.addVariable("Color",this.color);
	}
}
