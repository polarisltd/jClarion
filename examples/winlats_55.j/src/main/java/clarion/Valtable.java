package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Valtable extends ClarionQueue
{
	public ClarionString val=Clarion.newString(3);
	public ClarionNumber nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Valtable()
	{
		this.addVariable("VAL",this.val);
		this.addVariable("NR",this.nr);
		this.setPrefix("V");
	}
}
