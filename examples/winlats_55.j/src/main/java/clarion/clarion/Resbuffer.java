package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Resbuffer extends ClarionGroup
{
	public ClarionArray<ClarionNumber> rb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(256);

	public Resbuffer()
	{
		this.addVariable("RB",this.rb);
	}
}
