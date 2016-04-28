package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Stringlist extends ClarionQueue
{
	public ClarionString value=Clarion.newString(100).setEncoding(ClarionString.CSTRING);

	public Stringlist()
	{
		this.addVariable("Value",this.value);
	}
}
