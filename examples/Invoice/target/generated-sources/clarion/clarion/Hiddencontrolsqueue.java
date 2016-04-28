package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Hiddencontrolsqueue extends ClarionQueue
{
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);

	public Hiddencontrolsqueue()
	{
		this.addVariable("Control",this.control);
	}
}
