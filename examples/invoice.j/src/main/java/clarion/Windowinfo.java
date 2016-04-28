package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Windowinfo extends ClarionGroup
{
	public ClarionNumber x=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber y=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber w=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber h=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber maximized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber minimized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber got=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Windowinfo()
	{
		this.addVariable("X",this.x);
		this.addVariable("Y",this.y);
		this.addVariable("W",this.w);
		this.addVariable("H",this.h);
		this.addVariable("Maximized",this.maximized);
		this.addVariable("Minimized",this.minimized);
		this.addVariable("Got",this.got);
	}
}
