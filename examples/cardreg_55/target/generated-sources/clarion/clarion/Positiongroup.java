package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Positiongroup extends ClarionGroup
{
	public ClarionNumber xPos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber yPos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber height=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);

	public Positiongroup()
	{
		this.addVariable("XPos",this.xPos);
		this.addVariable("YPos",this.yPos);
		this.addVariable("Width",this.width);
		this.addVariable("Height",this.height);
	}
}
