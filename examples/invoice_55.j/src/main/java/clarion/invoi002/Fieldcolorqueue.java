package clarion.invoi002;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Fieldcolorqueue extends ClarionQueue
{
	public ClarionNumber feq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber oldcolor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Fieldcolorqueue()
	{
		this.addVariable("Feq",this.feq);
		this.addVariable("OldColor",this.oldcolor);
	}
}
