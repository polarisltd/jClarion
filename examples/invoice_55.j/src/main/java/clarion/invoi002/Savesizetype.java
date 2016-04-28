package clarion.invoi002;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Savesizetype extends ClarionGroup
{
	public ClarionNumber set=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber xpos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber ypos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber height=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Savesizetype()
	{
		this.addVariable("Set",this.set);
		this.addVariable("XPos",this.xpos);
		this.addVariable("YPos",this.ypos);
		this.addVariable("Width",this.width);
		this.addVariable("Height",this.height);
	}
}
