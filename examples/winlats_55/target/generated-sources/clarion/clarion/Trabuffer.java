package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Trabuffer extends ClarionGroup
{
	public ClarionArray<ClarionNumber> tb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(256);

	public Trabuffer()
	{
		this.addVariable("TB",this.tb);
	}
}
