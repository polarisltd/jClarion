package clarion;

import clarion.Positiongroup;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Resizequeue extends ClarionQueue
{
	public ClarionNumber priority=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber controlID=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public Positiongroup before=new Positiongroup();
	public Positiongroup after=new Positiongroup();

	public Resizequeue()
	{
		this.addVariable("Priority",this.priority);
		this.addVariable("ControlID",this.controlID);
		this.addVariable("Type",this.type);
		this.addVariable("Before",this.before);
		this.addVariable("After",this.after);
	}
}
