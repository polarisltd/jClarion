package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Errorblock extends ClarionGroup
{
	public ClarionNumber number=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Errorblock()
	{
		this.addVariable("Number",this.number);
	}
}
