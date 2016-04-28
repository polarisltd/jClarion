package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionQueue;

public class Fieldsqueue extends ClarionQueue
{
	public ClarionAny fieldValue=Clarion.newAny();
	public ClarionAny savedValue=Clarion.newAny();

	public Fieldsqueue()
	{
		this.addVariable("FieldValue",this.fieldValue);
		this.addVariable("SavedValue",this.savedValue);
	}
}
