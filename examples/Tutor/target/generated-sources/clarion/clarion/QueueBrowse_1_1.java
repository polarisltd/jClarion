package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1_1 extends ClarionQueue
{
	public ClarionString sTAState=Main.states.state.like();
	public ClarionString sTAStateName=Main.states.stateName.like();
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewPosition=Clarion.newString(1024);

	public QueueBrowse_1_1()
	{
		this.addVariable("STA:State",this.sTAState);
		this.addVariable("STA:StateName",this.sTAStateName);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
