package clarion;

import clarion.Reportgeneratorqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Targetreportgeneratorqueue extends Reportgeneratorqueue
{
	public ClarionNumber enableOnPreview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Targetreportgeneratorqueue()
	{
		this.addVariable("EnableOnPreview",this.enableOnPreview);
	}
}
