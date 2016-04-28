package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Queuefonts extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString face=Clarion.newString(32).setEncoding(ClarionString.CSTRING);
	public ClarionNumber angle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Queuefonts()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Color",this.color);
		this.addVariable("Size",this.size);
		this.addVariable("Style",this.style);
		this.addVariable("Face",this.face);
		this.addVariable("Angle",this.angle);
	}
}
