package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1 extends ClarionQueue
{
	public ClarionString sTAStateCode=Main.states.stateCode.like();
	public ClarionString sTAName=Main.states.name.like();
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewPosition=Clarion.newString(1024);

	public QueueBrowse_1()
	{
		this.addVariable("STA:StateCode",this.sTAStateCode);
		this.addVariable("STA:Name",this.sTAName);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
