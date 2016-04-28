package clarion.abquery;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Stringlist extends ClarionQueue
{
	public ClarionString value=Clarion.newString(100).setEncoding(ClarionString.CSTRING);

	public Stringlist()
	{
		this.addVariable("Value",this.value);
	}
}
