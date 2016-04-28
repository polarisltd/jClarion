package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Savesizetype extends ClarionGroup
{
	public ClarionNumber set=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber xPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber yPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber height=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Savesizetype()
	{
		this.addVariable("Set",this.set);
		this.addVariable("XPos",this.xPos);
		this.addVariable("YPos",this.yPos);
		this.addVariable("Width",this.width);
		this.addVariable("Height",this.height);
	}
}
