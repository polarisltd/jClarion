package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Brushindirect extends ClarionGroup
{
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber hatch=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Brushindirect()
	{
		this.addVariable("Style",this.style);
		this.addVariable("Color",this.color);
		this.addVariable("Hatch",this.hatch);
	}
}
