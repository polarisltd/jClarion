package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Totalingfieldsqueue extends ClarionQueue
{
	public ClarionAny source=Clarion.newAny();
	public ClarionAny target=Clarion.newAny();
	public ClarionAny auxTarget=Clarion.newAny();
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber resetOnLevel=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString condition=Clarion.newString(200);

	public Totalingfieldsqueue()
	{
		this.addVariable("Source",this.source);
		this.addVariable("Target",this.target);
		this.addVariable("AuxTarget",this.auxTarget);
		this.addVariable("Type",this.type);
		this.addVariable("ResetOnLevel",this.resetOnLevel);
		this.addVariable("Condition",this.condition);
	}
}
