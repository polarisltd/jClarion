package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Positiongroup extends ClarionGroup
{
	public ClarionNumber xpos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber ypos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber height=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);

	public Positiongroup()
	{
		this.addVariable("XPos",this.xpos);
		this.addVariable("YPos",this.ypos);
		this.addVariable("Width",this.width);
		this.addVariable("Height",this.height);
	}
}
