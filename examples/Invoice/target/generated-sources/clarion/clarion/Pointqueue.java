package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Pointqueue extends ClarionQueue
{
	public ClarionNumber xPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber yPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Pointqueue()
	{
		this.addVariable("XPos",this.xPos);
		this.addVariable("YPos",this.yPos);
	}
}
