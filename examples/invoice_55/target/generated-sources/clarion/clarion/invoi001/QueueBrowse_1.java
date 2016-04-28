package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse_1 extends ClarionQueue
{
	public ClarionString staStatecode=Clarion.newString(2);
	public ClarionString staName=Clarion.newString(25);
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewposition=Clarion.newString(1024);

	public QueueBrowse_1()
	{
		this.addVariable("STA:StateCode",this.staStatecode);
		this.addVariable("STA:Name",this.staName);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewposition);
	}
}
