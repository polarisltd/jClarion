package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Fieldcolorqueue extends ClarionQueue
{
	public ClarionNumber feq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber oldColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Fieldcolorqueue()
	{
		this.addVariable("Feq",this.feq);
		this.addVariable("OldColor",this.oldColor);
	}
}
