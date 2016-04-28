package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Itemqueue extends ClarionQueue
{
	public ClarionString item=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Itemqueue()
	{
		this.addVariable("Item",this.item);
		this.addVariable("Mark",this.mark);
	}
}
