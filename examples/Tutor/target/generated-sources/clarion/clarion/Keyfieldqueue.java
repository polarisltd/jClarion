package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Keyfieldqueue extends ClarionQueue
{
	public ClarionAny field=Clarion.newAny();
	public RefVariable<ClarionString> fieldName=new RefVariable<ClarionString>(null);
	public ClarionNumber ascend=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Keyfieldqueue()
	{
		this.addVariable("Field",this.field);
		this.addVariable("FieldName",this.fieldName);
		this.addVariable("Ascend",this.ascend);
	}
}
