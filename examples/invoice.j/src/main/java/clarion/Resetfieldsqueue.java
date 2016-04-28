package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionQueue;

public class Resetfieldsqueue extends ClarionQueue
{
	public ClarionAny fieldValue=Clarion.newAny();
	public ClarionAny lastValue=Clarion.newAny();
	public ClarionAny savedValue=Clarion.newAny();

	public Resetfieldsqueue()
	{
		this.addVariable("FieldValue",this.fieldValue);
		this.addVariable("LastValue",this.lastValue);
		this.addVariable("SavedValue",this.savedValue);
	}
}
